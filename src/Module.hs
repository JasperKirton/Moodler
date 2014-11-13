{-# LANGUAGE FlexibleContexts #-}

module Module where

import Control.Monad.State
import Control.Monad.Trans.Either
import Control.Monad.Writer
import Data.Maybe
import Language.C.Data.Ident
import Language.C.Data.Name
import Language.C.Data.Node
import Language.C.Data.Position
import Language.C.Parser
import Language.C.Syntax.AST
import Parser
import qualified Data.ByteString.Char8 as B
import qualified Data.Set as S
import Language.Preprocessor.Cpphs

import Text

data NodeType a = NodeType {
    inNames :: S.Set String,
    outNames :: S.Set String,
    stateNames :: [String],
    stateDecls :: [CDeclaration a],
    initCode :: CFunctionDef a,
    execCode :: CFunctionDef a
} deriving Show

varoffset :: (Eq a, Ord a, Num a, Show a) => String -> a -> String
varoffset var x | x == 0  = var
                | x > 0  = var ++ "+" ++ show x
                | x < 0  = var ++ "-" ++ show (-x)
                | otherwise = var ++ "+(" ++ show x ++ ")"

xyoffset :: (Eq a, Ord a, Num a, Show a) => (a, a) -> String
xyoffset (x, y) = "(" ++ varoffset "x" x ++ ", " ++ varoffset "y" y ++ ")"

indent :: Int -> String
indent n = replicate n ' '

synthPreamble :: MonadWriter String m =>
                 String -> String -> (Float, Float) -> m ()
synthPreamble panelName synthName topOffset = do
    tellLn "do"
    tellInd 4 "plane <- currentPlane"
    tellInd 4 "(x, y) <- mouse"
    tellInd 4 $ unwords ["panel <- container'",
                         show panelName,
                         "(x, y) plane"]
    tellInd 4 $ unwords ["lab <- label'",
                          show synthName,
                          xyoffset topOffset,
                          "plane"]
    tellInd 4 "parent panel lab"
    tellInd 4 $ unwords ["name <- new'", show synthName]

-- Auto-generate script for a .spec module
synthScript :: String -> [String] -> [String] -> String
synthScript synthName ins outs = do
    let numIns = length ins
    let numOuts = length outs
    let height = max numIns numOuts
    let inOffset = -25*numIns+25
    let outOffset = -25*numOuts+25
    let topOffset = (-25, 75 :: Float)
    let panelName = if height >= 4
            then "panel_4x1.bmp"
            else "panel_3x1.bmp"
    execWriter $ do
        synthPreamble panelName synthName topOffset
        forM_ (zip [inOffset, inOffset+50 ..] ins) $
                                    \(offset, eachInput) -> do
             tellInd 4 $ unwords
                    [ "inp <- plugin' (name ++",
                      show ("." ++ eachInput) ++ ")",
                      xyoffset (-21, -offset),
                      "plane" ]
             tellInd 4 "parent panel inp"
        forM_ (zip [outOffset, outOffset+50 ..] outs) $
                                    \(offset, eachInput) -> do
             tellInd 4 $ unwords
                    [ "out <- plugout' (name ++ ",
                      show ("." ++ eachInput) ++ ")",
                      xyoffset (20, -offset),
                      "plane" ]
             tellInd 4 "parent panel out"
        tellInd 4 "recompile"
        tellInd 4 "return ()"

loadNodeType :: String -> String -> EitherT String IO (NodeType NodeInfo)
loadNodeType dir fileName' = do
    let fileName = dir ++ "/" ++ fileName'
    rawCode <- liftIO $ readFile fileName
    code <- liftIO $ runCpphs defaultCpphsOptions { boolopts = defaultBoolOptions { locations = False, stripC89 = True } } fileName (rawCode::String)
    liftIO $ putStrLn "Parsing:"
    liftIO $ putStr (code::String)
    let typeNames = [builtinIdent "in", builtinIdent "out"] ++
                    builtinTypeNames
    let input = B.pack code
    let pos = position 0 "" 0 0
    (ast, _) <- hoistEither $ either (Left . show) Right $
                    execParser translUnitP input pos
                               typeNames newNameSupply
    (_, Extracted i e vs) <- liftIO $ runStateT
                (extractModuleParts ast) (Extracted Nothing Nothing [])
    let states = map varDefinedInDeclaration vs
    let (ins, outs) = getInsAndOuts (fromJust e)

    let synthName = fst (splitDot fileName')
    let script = synthScript synthName ins outs
    liftIO $ putStrLn $ "In scripts/" ++ synthName ++ ".hs"
    liftIO $ putStr script
    liftIO $ writeFile ("scripts/" ++ synthName ++ ".hs") script

    if isJust e && isJust i
        then return $ NodeType (S.fromList ins)
                               (S.fromList outs)
                               states
                               vs
                               (fromJust i)
                               (fromJust e)
        else left "loadNodeType failed"
