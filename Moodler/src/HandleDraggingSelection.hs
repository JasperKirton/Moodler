module HandleDraggingSelection where

import Graphics.Gloss.Interface.IO.Game
import Control.Monad
--import Control.Monad.Trans.Free
import Control.Lens hiding (setting)
import qualified Data.Set as S

import Sound.MoodlerLib.Quantise
import Sound.MoodlerLib.Symbols

import World
import WorldSupport
import ServerState
import UIElement

dragElement :: [UiId] -> Point -> [UiId] -> MoodlerM ()
dragElement top d sel = forM_ sel $ \s -> do
    serverState . uiElements . ix s . ur . loc += d
    elt <- getElementById "dragElement" s
    case elt of
        Container { _outside = cts } ->
            -- If you drag a parent and its children then only the
            -- parent needs to be expicitly dragged.
            -- XXX use minimal parent func
            dragElement top d (filter (not . flip elem top) $
                                                        S.toList cts)
        _ -> return ()

handleDraggingSelection :: (Event -> MoodlerM Zero) -> Point ->
                           MoodlerM Zero
handleDraggingSelection handleDefault p0' =
    getEvent >>= handleDraggingSelection' (quantise2 quantum p0')
    where

    doDrag :: Point -> Point -> MoodlerM ()
    doDrag p0 p1 = do
        sel <- use currentSelection
        dragElement sel (p1-p0) sel

    handleDraggingSelection' :: Point -> Event -> MoodlerM Zero
    handleDraggingSelection' p0 (EventMotion p1') = do
        let p1 = quantise2 quantum p1'
        doDrag p0 p1
        handleDraggingSelection handleDefault p1

    handleDraggingSelection' p0
        (EventKey (MouseButton LeftButton) Up _ p1') = do
        let p1 = quantise2 quantum p1'
        doDrag p0 p1
        getEvent >>= handleDefault

    handleDraggingSelection' a _ = handleDraggingSelection handleDefault a
