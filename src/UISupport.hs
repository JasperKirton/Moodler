{-# LANGUAGE Rank2Types, FlexibleContexts #-}

module UISupport where

import Control.Lens
import Control.Monad.State
import Graphics.Gloss.Interface.IO.Game
import qualified Data.Foldable as F
import qualified Data.Map as M
import qualified Data.Set as S

import Cable
import Comms
import ContainerTree
import Symbols
import UIElement
import World

highlightElement :: MonadState GlossWorld m => UiId -> m ()
highlightElement i = (inner . uiElements) . ix i . highlighted .= True

unhighlightElement :: MonadState GlossWorld m => UiId -> m ()
unhighlightElement i = (inner . uiElements) . ix i . highlighted .= False

unhighlightEverything :: MonadState GlossWorld m => m ()
unhighlightEverything = (inner . uiElements) . traverse . highlighted .= False

highlightJust :: MonadState GlossWorld m => UiId -> m ()
highlightJust i =
    unhighlightEverything >> (inner . uiElements) . ix i . highlighted .= True

doSelection :: MonadState GlossWorld m => UiId -> m ()
doSelection i = do
    unhighlightEverything
    highlightJust i
    (inner . currentSelection) .= [i]

newUIElement :: MonadState GlossWorld m => (UiId -> UIElement) -> m UiId
newUIElement elt = do
    newN <- use (inner . newName)
    (inner . newName) %= (+ 1)
    let n = UiId $ "elt" ++ show newN
    let e = elt n
    (inner . uiElements) %= M.insert n e
    doSelection n
    --liftIO $ print $ "newUIElement " ++ unUiId n
    return n

installWorld :: WorldMonad ()
installWorld = do
    -- Install needed synths
    synths <- use (inner . synthList)
    -- Comms
    F.forM_ synths $ uncurry sendNewSynthMessage
    elts <- use (inner . uiElements)
    F.forM_ elts $ \elt ->
        case elt of
            Knob { _name = n} ->
                -- Comms
                sendNewInputMessage n
            _ -> return ()
    -- Connect them up
    F.forM_ elts $ \elt ->
        case elt of
            -- Comms
            Knob { _name = n, _setting = s} -> sendSetMessage n s
            In { _cables = (Cable src dst : _) } ->
                -- Comms
                connectCable src dst
            _ -> return ()

visitElements' :: MonadState GlossWorld m => UiId -> UIElement -> m [UiId]
visitElements' e elt@Container { _contents = cts } = do
    showHiddenElements <- use (inner . showHidden)
    if not showHiddenElements && (elt ^. hidden)
        then return []
        else do
            childElements <- forM (S.toList cts) $ \c -> do
                celt <- getElementById "UISupport.hs" c
                visitElements' c celt
            return $ concat childElements ++ [e]
visitElements' e elt = do
    showHiddenElements <- use (inner . showHidden)
    return $ if not showHiddenElements && (elt ^. hidden)
        then []
        else [e]
    
visitElements :: MonadState GlossWorld m => m [UiId]
visitElements = do
    es <- use (inner . uiElements)
    lists <- forM (M.toList es) $ \(e, elt) -> do
        -- Don't visit something with a parent from the top level.
        -- We'll probably get there via the parent.
        root <- use (inner . rootPlane)
        if (elt ^. parent) /= root && not (elt ^. hidden)
            then visitElements' e elt
            else return []
    return $ concat lists

visitElementsOnPlane :: MonadState GlossWorld m => UiId -> m [UiId]
visitElementsOnPlane planeId = do
    p <- getElementById "UISupport.hs" planeId
    lists <- forM (S.toList (p ^. contents)) $ \eltId -> do
        elt <- getElementById "UISupport.hs" eltId
        if not (elt ^. hidden)
            then visitElements' eltId elt
            else return []
    return $ concat lists

-- Visible root elements
-- Should be able to do better 'cos proxy lists its contents
rootElementsOnPlane :: MonadState GlossWorld m => UiId -> m [UiId]
rootElementsOnPlane planeId = do
    p <- getElementById "UISupport.hs" planeId
    return $ S.toList (p ^. contents)

-- What UI element lies directly under point?
selectedByPoint :: MonadState GlossWorld m => UiId -> (Float, Float) ->
                                         m (Maybe UiId)
selectedByPoint selectionPlane (x, y) = do
    parentsFirst <- visitElementsOnPlane selectionPlane
    poss <- flip filterM parentsFirst $ \e -> do
        elt <- getElementById "UISupport.hs" e
        return $ pointNearUIElement (x, y) elt
    return $ if null poss
        then Nothing
        else Just (head poss)

deleteCable :: (Functor m, MonadIO m, MonadState GlossWorld m) =>
               UiId -> m (Maybe Cable)
deleteCable selectedIn = do
    outPoint <- getElementById "UISupport.hs" selectedIn
    case outPoint ^. cables of
        [] -> return Nothing
        [c] -> do
            (inner . uiElements) . ix selectedIn . cables .= []
            selectedInName <- use ((inner . uiElements) . ix selectedIn . name)
            -- Comms
            sendConnectMessage "zero.result" selectedInName
            -- Comms
            sendRecompileMessage
            return (Just c)
        (c : rc@(Cable src dst : _)) -> do
            (inner . uiElements) . ix selectedIn . cables .= rc
            -- Comms
            connectCable src dst
            -- Comms
            sendRecompileMessage
            return (Just c)

rotateCables :: (Functor m, MonadIO m, MonadState GlossWorld m) => UiId -> m ()
rotateCables selectedIn = do
    outPoint <- getElementById "UISupport.hs" selectedIn
    case outPoint ^. cables of
        (c : rc@(Cable src dst : _)) -> do
            (inner . uiElements) . ix selectedIn . cables .= rc ++ [c]
            -- Comms
            connectCable src dst
            -- Comms
            sendRecompileMessage
            return ()
        _ -> return ()

newNameLike :: String -> M.Map String a -> String
newNameLike s m = if s `M.member` m
    then newNameLike (s ++ "'") m
    else s

{-
quantize :: Float -> Float -> Float
quantize q x = q*fromIntegral (floor (x/q) :: Int)
-}

anOut :: UiId -> GlossWorld -> Bool
anOut n = evalState $ do
    possibleOut <- getElementById "UISupport.hs" n
    return $ case possibleOut of
        Out {} -> True
        _ -> False

anIn :: UiId -> GlossWorld -> Bool
anIn n = evalState $ do
    possibleIn <- getElementById "UISupport.hs" n
    return $ case possibleIn of
        In {} -> True
        _ -> False

oneToMany :: S.Set UiId -> StateT GlossWorld IO (Maybe (UiId, [UiId]))
oneToMany elts = do
    world <- get
    let (outs, rest) = S.partition (`anOut` world) elts
    guard $ S.size outs == 1
    let (ins, _) = S.partition (`anIn` world) rest
    return $ Just (head $ S.toList outs, S.toList ins)

isDirection :: Key -> Bool
isDirection (SpecialKey KeyUp) = True
isDirection (SpecialKey KeyDown) = True
isDirection (SpecialKey KeyLeft) = True
isDirection (SpecialKey KeyRight) = True
isDirection _ = False

getDirection :: Key -> (Float, Float)
getDirection (SpecialKey KeyUp) = (0, 1)
getDirection (SpecialKey KeyDown) = (0, -1)
getDirection (SpecialKey KeyLeft) = (-1, 0)
getDirection (SpecialKey KeyRight) = (1, 0)
getDirection _ = (0, 0)

everythingInRegion :: MonadState GlossWorld m => UiId -> Point -> Point -> m [UiId]
everythingInRegion selectionPlane p0 p1 = do
    parentsFirst <- visitElementsOnPlane selectionPlane
    flip filterM parentsFirst $ \e -> do
        elt <- getElementById "UISupport.hs" e
        return $ uiElementWithinBox (p0, p1) elt

addPlane :: MonadState GlossWorld m => UiId -> m ()
addPlane plane = inner . planes .= plane

-- When we make a group we may have to remove elements from their parents.
-- We only remove them if the parents aren't also in the newly formed group.
makeGroup :: (Functor m, MonadState GlossWorld m, MonadIO m) =>
             UiId -> [UiId] -> Point -> m ()
makeGroup p sel proxyLocation = do
    liftIO $ putStrLn $ "Making group on " ++ show p
    everythingThatsMoving <- getAllContainerDescendants sel

    -- Make a name for our new group.
    newPlaneName <- use (inner . newName)
    inner . newName %= (+ 1) -- kludge XXX

    let proxyName = "proxy" ++ show newPlaneName
    let groupPlane = UiId proxyName
    let e = UIElement.Proxy p False False proxyLocation proxyName S.empty
    createdInParent groupPlane e p
    addPlane groupPlane

    forM_ everythingThatsMoving $ \movingId -> do
        liftIO $ print $ "considering " ++ show movingId
        movingElement <- getElementById "UISupport.hs" movingId
        liftIO $ putStrLn $ "parent = " ++ show (movingElement ^. parent)
        let p' = movingElement ^. parent
        unless (p' `elem` everythingThatsMoving) $ do
            liftIO $ print $ "no parent for " ++ show p'
            --unparent movingId
            moveElementToPlane movingId groupPlane