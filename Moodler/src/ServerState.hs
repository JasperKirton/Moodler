{-# LANGUAGE TemplateHaskell #-}

module ServerState where

import qualified Data.Map as M

import Sound.MoodlerLib.Symbols
import Control.Lens

import UIElement

-- ServerState is intended to reflect the state of the synth on the server
data ServerState = ServerState { _uiElements :: M.Map UiId UIElement
                               , _synthList :: [(String, String)]
                               , _aliases :: M.Map String String
                               -- XXX What are connections?
                               -- , _connections :: [(String, String)]
                               }

emptyServerState :: UiId -> UIElement -> ServerState
emptyServerState rootID root =
    ServerState { _uiElements = M.fromList [(rootID, root)]
                , _synthList = []
                , _aliases = M.empty
                }

-- Need to make args consistent XXX
data SendCommand = SendConnect String String
                 | SendDisconnect String
                 | SendSet String Float
                 | SendSetString String String
                 deriving Show

$(makeLenses ''ServerState)
