{-# LANGUAGE FlexibleContexts #-}

module HandleEvent where

import Cable
import Command
import ContainerTree
import Control.Lens hiding (setting)
import Control.Monad.State
import Control.Monad.Trans.Free
import Data.List
import Data.Monoid
import Draw
import GHC.IO.Exception
import Graphics.Gloss.Interface.IO.Game
import Music
import Numeric
import Symbols
import System.Posix
import UIElement
import UISupport
import Utils
import qualified Wiring as W
import World
import qualified Box as B
import qualified Data.Foldable as F
import qualified Data.Map as M
import qualified Data.Set as S
import qualified UiLib as U

-- Find a container somewhere in a list of ids.
-- Assumes there is precisely one. XXX
findContainer :: [UiId] -> MoodlerM (UiId, [UiId])
findContainer es = do
    (a, b) <- partitionM isContainer es
    return (head a, b)

handleDefault :: MoodlerM Zero
handleDefault = handleDefault' =<< MoodlerM (liftF $ GetEvent id)

-- Handle ordinary click on an In port.
-- If there's a cable attached we start dragging it
-- Otherwise we select and possibly drag the port itself.
clickOnIn' :: Point -> UiId -> MoodlerM Zero
clickOnIn' p i = do
    W.undoPoint
    d <- W.deleteCable i
    W.synthRecompile
    case d of
        Nothing -> do
            doSelection i
            handleDraggingSelection p
        Just (Cable src) -> do
            srcElt <- getElementById "clickOnIn'" src
            gadget .= cableGadget (_loc srcElt) p
            handleDraggingCable src (_loc srcElt) p

-- Straightforward click on a UI element
defaultClick' :: Point -> UiId -> MoodlerM Zero
defaultClick' p i = do
    elt <- getElementById "defaultClick'" i
    case elt of
        -- XXX Need to select images/containers correctly.
        Container {} -> do
            doSelection i
            handleDraggingSelection p
        Out {} -> do
            highlightJust i
            gadget .= cableGadget p p
            handleDraggingCable i p p
        In {} -> clickOnIn' p i
        Knob {} -> do
            highlightJust i
            W.undoPoint
            handleDraggingKnob i (_setting elt) p
        Label {} -> do
            doSelection i
            handleDefault
        Image {} -> do
            doSelection i
            handleDefault
        -- Switch plane
        Proxy {} -> do
            --let pl = Plane newPlane
            planes .= i
            handleDefault
        Selector { _setting = oldSetting,
                   _options = opts } -> do
            let newSetting = (floor oldSetting+1) `mod` length opts
            --inner . uiElements . ix i . UIElement.setting .=
            --                                fromIntegral newSetting
            -- Comms
            --sendSetMessage selectorName (fromIntegral newSetting)
            W.undoPoint
            W.synthSet i (fromIntegral newSetting)
            handleDefault

elementDisplayName :: UIElement -> String
elementDisplayName In { _displayName = n} = n
elementDisplayName Knob { _displayName = n} = n
elementDisplayName e = e ^. name

hoverGadget :: Point -> UIElement -> B.Transform -> Picture
hoverGadget (ex, ey) elt xform = 
     pictureTransformer xform $ translate ex ey (
        translate 86 1 (color (B.transparentBlack 0.5)
                              (rectangleSolid 150 24))
        <>
        translate 18 (-2) (scale 0.1 0.1 (
                color white (text (elementDisplayName elt))))
        )

handleDefault' :: Event -> MoodlerM Zero
handleDefault' (EventMotion (x, y)) = do
    selectionPlane <- use planes
    maybeHoveringOver <- selectedByPoint selectionPlane (x, y)
    case maybeHoveringOver of
        Just hoveringOver -> do
            elt <- getElementById "HandleEvent.hs" hoveringOver
            gadget .= hoverGadget (_loc elt) elt
        Nothing -> gadget .= const blank
    handleDefault

handleDefault' (EventKey (Char '"') Down _ _) = do
    showHidden %= not
    handleDefault

handleDefault' (EventKey (Char 'z') Down _ _) = do
    W.performUndo
    handleDefault

handleDefault' (EventKey (Char 'Z') Down _ _) = do
    liftIO $ putStrLn "Z was pressed"
    W.performRedo
    handleDefault

handleDefault' (EventKey (Char 'r') Down _ _) = do
    es <- use currentSelection
    (container, contentss) <- findContainer es
    forM_ contentss $ \content -> reparent container content
    handleDefault

handleDefault' (EventKey (Char '*') Down _ _) = do
    rootTransform %= (B.Transform (0, 0) 1.5 <>)
    handleDefault

handleDefault' (EventKey (Char '/') Down _ _) = do
    rootTransform %= (B.Transform (0, 0) (1/1.5) <>)
    handleDefault

handleDefault' (EventKey (Char 'l') Down _ _) = do
    allScripts <- liftIO getAllScripts
    filename <- handleGetString allScripts "" "load: "
    liftIO $ putStrLn $ "filename = " ++ show filename
    case filename of
        Just filename' -> do
            W.undoPoint
            evalUi (U.load filename')
        Nothing -> return ()
    handleDefault

handleDefault' (EventKey (Char 's') Down _ _) = do
    filename <- handleGetString [] "" "save: "
    liftIO $ putStrLn $ "filename = " ++ show filename
    case filename of
        Just filename' -> evalUi (U.save filename')
        Nothing -> return ()
    handleDefault

handleDefault' (EventKey (Char 'w') Down _ _) = do
    filename <- handleGetString [] "" "write: "
    liftIO $ putStrLn $ "filename = " ++ show filename
    case filename of
        Just filename' -> evalUi (U.write filename')
        Nothing -> return ()
    handleDefault

handleDefault' (EventKey (Char 'q') Down _ _) = do
    liftIO $ exitImmediately ExitSuccess
    handleDefault

handleDefault' (EventKey (Char 'c') Down _ (x, y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    case e of
        Just i -> do
            elt <- getElementById "handleDefault'" i
            case elt of
                In {} -> do
                    W.undoPoint
                    W.rotateCables i
                    handleDefault
                _ -> handleDefault
        Nothing -> handleDefault

handleDefault' (EventKey (Char '?') Down _ (x, y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    case e of
        Just i -> do
            elt <- getElementById "HandleEvent.hs" i
            liftIO $ putStrLn $ "UiId = " ++ show i
            liftIO $ putStrLn $ "Element = " ++ show elt
            handleDefault
        Nothing -> handleDefault

handleDefault' (EventKey (Char 'g') Down _ proxyLocation) = do
    sel <- use currentSelection
    p <- use planes
    makeGroup p sel proxyLocation
    handleDefault

handleDefault' (EventKey (Char 't') Down _ labelLocation) = do
    p <- use planes
    void $
        newUIElement (Label p False False labelLocation .
                      unUiId)
    handleDefault

-- Shift mouse down
-- Starts MultiSelection
handleDefault' (EventKey (MouseButton LeftButton) Down
                    (Modifiers {alt = Up, shift = Down, ctrl = Up})
                    (x,y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    case e of
        Just i -> do
            --guiState .= MultiSelection (S.singleton i)
            sel <- use currentSelection
            if i `elem` sel
                then do
                    unhighlightElement i
                    currentSelection %= delete i
                else do
                    highlightElement i
                    currentSelection %= (i :)
        Nothing -> return ()
    handleDefault

-- The normal/ordinary mouse down event
handleDefault' (EventKey (MouseButton LeftButton) Down
    (Modifiers {alt = Up, shift = Up, ctrl = Up}) p) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane p
    case e of
        Just i -> do
            sel <- use currentSelection
            if (length sel > 1) && (i `elem` sel)
                then handleDraggingSelection p
                else defaultClick' p i

        Nothing -> handleDraggingRegion p p

handleDefault' (EventKey (MouseButton RightButton) Down
    (Modifiers {alt = Down, shift = Up, ctrl = Up}) (x,y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    case e of
        Just i -> do
            f <- getElementById "HandleEvent.hs" i
            gadget .= \xform ->
                pictureTransformer xform $
                    translate x y
                        (scale 0.05 0.05 (color black (text (show f))))
            handleDefault
        Nothing -> handleDefault

-- Start ordinary selection drag to move
handleDefault' (EventKey (MouseButton LeftButton) Down
    (Modifiers {alt = Down, shift = Up, ctrl = Up}) (x,y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    sel <- use currentSelection
    case e of
        Just i ->
            if i `elem` sel
                then handleDraggingSelection (x, y)
                else do
                    doSelection i
                    handleDraggingSelection (x, y)
        Nothing -> handleDraggingRoot (x, y)

-- Cable drag with ctrl-mouse
handleDefault' (EventKey (MouseButton LeftButton) Down
        (Modifiers {alt = Up, ctrl = Down, shift = Up}) (x,y)) = do
    selectionPlane <- use planes
    e <- selectedByPoint selectionPlane (x, y)
    case e of
        Just i -> do
            elt <- getElementById "HandleEvent.hs" i
            case elt of
                Container {} -> do
                    doSelection i
                    handleDefault
                Out {} -> do
                    highlightJust i
                    handleDraggingCable i (x, y) (x, y)
                In {} -> do
                    doSelection i
                    handleDefault
                Proxy {} -> do
                    doSelection i
                    handleDefault
                Knob {} -> do
                    highlightJust i
                    handleDraggingCable i (x, y) (x, y)
                Selector {} -> do
                    highlightJust i
                    handleDraggingCable i (x, y) (x, y)
                Label {} -> do
                    doSelection i
                    handleDefault
                Image {} -> do
                    doSelection i
                    handleDefault
        Nothing -> handleDefault

handleDefault' (EventKey key Down
            (Modifiers {shift = Up}) _) | isDirection key = do
    let (dx, dy) = getDirection key
    sel <- use currentSelection
    forM_ sel $ \e ->
        (inner . uiElements) . ix e .loc %= \(x, y) -> (x+10*dx, y+10*dy)
    handleDefault

-- Use key binding.
handleDefault' (EventKey (Char key) Down _ _) = do
    W.undoPoint
    binds <- use bindings
    F.forM_ (M.lookup key binds) $ \script ->
            execScript "scripts" script []
    handleDefault

handleDefault' _ =
    handleDefault

handleDraggingRoot :: Point -> MoodlerM Zero
handleDraggingRoot (x0, y0) = do
    e <- MoodlerM (liftF $ GetEvent id)
    handleDraggingRoot' (x0, y0) e

handleDraggingRoot' :: Point -> Event -> MoodlerM Zero
handleDraggingRoot' (x0, y0) (EventMotion (x1, y1)) = do
    rootTransform %= (B.Transform (x1-x0, y1-y0) 1 <>)
    -- It's not obvious that the following line is correct.
    -- It's tempting to use (x1, y1).
    -- Remember that mouse coordinates have been transformed
    -- by the very transform we're changing.
    -- This means that the position of the mouse at the previous
    -- event is always (x0, y0) in the current coordinate system
    -- despite the fact that the mouse is moving.
    handleDraggingRoot (x0, y0)

handleDraggingRoot' (x0, y0)
    (EventKey (MouseButton LeftButton) Up _ (x1, y1)) = do
    rootTransform %= (B.Transform (x1-x0, y1-y0) 1 <>)
    handleDefault

handleDraggingRoot' a _ = handleDraggingRoot a

dragElement :: [UiId] -> Float -> Float -> [UiId] -> MoodlerM ()
dragElement top dx dy sel = forM_ sel $ \s -> do
    inner . uiElements . ix s . loc %= \(x, y) -> (x+dx, y+dy)
    elts <- use (inner . uiElements)
    let Just elt = M.lookup s elts
    case elt of
        Container { _contents = cts } ->
            -- If you drag a parent and its children then only the
            -- parent needs to be expicitly dragged.
            -- XXX use minimal parent func
            dragElement top dx dy (filter (not . flip elem top) $
                                                        S.toList cts)
        _ -> return ()

handleDraggingSelection :: Point ->
                           MoodlerM Zero
handleDraggingSelection (x0, y0) = do
    e <- MoodlerM (liftF $ GetEvent id)
    handleDraggingSelection' (x0, y0) e

-- Don't drag container AND its children XXX
handleDraggingSelection' :: Point -> Event -> MoodlerM Zero
handleDraggingSelection' (x0, y0) (EventMotion (x1, y1)) = do
    sel <- use currentSelection
    dragElement sel (x1-x0) (y1-y0) sel
    handleDraggingSelection (x1, y1)

handleDraggingSelection' (x0, y0)
    (EventKey (MouseButton LeftButton) Up _ (x1, y1)) = do
    sel <- use currentSelection
    dragElement sel (x1-x0) (y1-y0) sel
    handleDefault

handleDraggingSelection' a _ = handleDraggingSelection a

selectEverythingInRegion :: (MonadIO m, MonadState GlossWorld m) =>
                            Point -> Point -> m ()
selectEverythingInRegion p0 p1 = do
    selectionPlane <- use planes
    s <- everythingInRegion selectionPlane p0 p1
    currentSelection .= s
    unhighlightEverything
    forM_ s highlightElement

handleDraggingRegion :: Point -> Point ->
                           MoodlerM Zero
handleDraggingRegion p1 p2 = do
    e <- MoodlerM (liftF $ GetEvent id)
    handleDraggingRegion' p1 p2 e

-- Mouse motion during region drag
handleDraggingRegion' :: Point -> Point -> Event ->
                           MoodlerM Zero
handleDraggingRegion' f z (EventMotion (x, y)) = do
    --secondCorner .= (x, y)
    gadget .= \xform -> pictureTransformer xform $
                                    color black (rect z (x, y))
    selectEverythingInRegion f (x, y)
    handleDraggingRegion f z

-- Finished dragging
handleDraggingRegion' f _
    (EventKey (MouseButton LeftButton) Up _ (x, y)) = do
    if f /= (x, y)
        then selectEverythingInRegion f (x, y)
        else do
            unhighlightEverything
            currentSelection .= []
    gadget .= const blank
    handleDefault

handleDraggingRegion' a b _ = handleDraggingRegion a b

handleDraggingCable :: UiId -> Point -> Point -> MoodlerM Zero
handleDraggingCable src start end =
    handleDraggingCable' src start end =<< MoodlerM (liftF $ GetEvent id)

cableGadget :: Point -> Point -> B.Transform -> Picture
cableGadget p0 p1 xform = 
    pictureTransformer xform $ color (makeColor 0.6 0.6 0.3 0.5)
                              (B.curve 0.3 p0 p1)

justSelect :: UiId -> MoodlerM Zero
justSelect i = do
    doSelection i
    gadget .= const blank
    handleDefault

wireCable :: UiId -> UiId -> MoodlerM Zero
wireCable i selectedOut = do
    unhighlightEverything
    W.undoPoint
    W.synthConnect selectedOut i
    W.synthRecompile
    justSelect i

-- Motion during cable dragging
handleDraggingCable' :: UiId -> Point -> Point -> Event -> MoodlerM Zero
handleDraggingCable' src start _ (EventMotion (x, y)) = do
    gadget .= cableGadget start (x, y)
    selectionPlane <- use planes
    maybeHoveringOver <- selectedByPoint selectionPlane (x, y)
    case maybeHoveringOver of
        Just hoveringOver -> do
            elt <- getElementById "HandleEvent.hs" hoveringOver
            case elt of
                In {} -> do
                    highlightElement hoveringOver
                    gadget .= cableGadget start (x, y) <>
                                      hoverGadget (_loc elt) elt 
                _ -> unhighlightEverything
        Nothing -> unhighlightEverything
    handleDraggingCable src start (x, y)

-- Deal with the end of cable dragging
handleDraggingCable' selectedOut _ _
    (EventKey (MouseButton LeftButton) Up _ (x, y)) = do
    selectionPlane <- use planes
    maybeElement <- selectedByPoint selectionPlane (x, y)
    case maybeElement of
        Just i -> do
            elt <- getElementById "HandleEvent.hs" i
            case elt of
                In {} -> wireCable i selectedOut
                Out {} -> justSelect i
                _ -> do
                        gadget .= const blank
                        handleDefault
        Nothing -> do
                    gadget .= const blank
                    handleDefault

handleDraggingCable' _ _ _ e = handleDefault' e

handleDraggingKnob :: UiId -> Float -> Point -> 
                        MoodlerM Zero
handleDraggingKnob selectedKnob v (x0, y0) = do
    e <- MoodlerM (liftF $ GetEvent id)
    handleDraggingKnob' selectedKnob v (x0, y0) e

knobMapping :: Float -> Point -> Float
knobMapping v (dx, dy) = v+0.01*dx*exp (0.01*dy)

handleDraggingKnob' :: UiId -> Float -> Point -> Event -> MoodlerM Zero
handleDraggingKnob' selectedKnob v p0@(x0, y0) (EventMotion p) = do
    let newV = knobMapping v (p-p0)
    -- Use zoom?
    elts <- use (inner . uiElements)
    let elt = M.lookup selectedKnob elts
    case elt of
        Nothing -> handleDraggingKnob selectedKnob v p0
        Just e -> do
            let lowLimit = _knobMin e
            let highLimit = _knobMax e
            let v0 = case lowLimit of
                    Nothing -> newV
                    Just lo -> max newV lo
            let v1 = case highLimit of
                    Nothing -> v0
                    Just hi -> min v0 hi
            gadget .= \xform -> pictureTransformer xform $
                                            translate x0 y0 (
                color (B.transparentBlack 0.8) (rectangleSolid 250 100) <>
                translate (-80) (-40) (scale 0.27 0.27 $
                    color green $ text (showFFloat (Just 4) v1 "")) <>
                translate (-80) 0 (scale 0.27 0.27 $
                        color red $ text (showNote v1)))
            W.synthSet selectedKnob v1
            handleDraggingKnob selectedKnob v p0

handleDraggingKnob' selectedKnob _ _
    (EventKey (MouseButton LeftButton) Up _ _) = do
    gadget .= const blank
    doSelection selectedKnob
    handleDefault

handleDraggingKnob' _ _ _ e = handleDefault' e
