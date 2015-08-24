{-|
Module      : Box
Description : Low level geometry routines.
Maintainer  : dpiponi@gmail.com

Basic geometry routines such as text rendering and
point in box tests.
-}

module Box where

import Data.Monoid
import qualified Graphics.Gloss.Interface.IO.Game as G
import Graphics.Gloss.Data.Vector

import Text

-- | Basic box type. A box is usually specified as
-- (lower left corner, upper right corner)
type Box = ( G.Point, G.Point)

-- | Test whether a point is in box.
pointWithin :: G.Point -- ^ Test whether this point...
               -> Box  -- ^ ...is in this box...
               -> Bool -- ^ ...returning 'True' if it is.
pointWithin (x0, y0) ((x1, y1), (x2, y2)) =
    x0 >= x1 && x0 <= x2 && y0 >= y1 && y0 <= y2

-- | Ensure that first element of 'Box' type is lower left corner
-- and that second element is upper right corner.
normaliseBox :: Box -> Box
normaliseBox ((x0, y0), (x1, y1)) =
    ((min x0 x1, min y0 y1), (max x0 x1, max y0 y1))

-- | Test whether one box is completely contained within another.
within :: Box     -- ^ Test whether this box...
          -> Box  -- ^ ...is completely contained in this box...
          -> Bool -- ^ ...returning 'True' if it is.
within (p, q) box = pointWithin p box && pointWithin q box

-- | Square a number.
square :: Num a => a -> a
square x = x^(2::Int)

-- | Test whether one point is near another.
pointNear :: Float      -- ^ If within this radius...
             -> G.Point -- ^ ...of this point...
             -> G.Point -- ^ ...lies this point...
             -> Bool    -- ^ ...then return 'True'.
pointNear r (x0, y0) (x1, y1) =
    square (x0-x1)+square (y0-y1) <= square r

-- | Gloss sometimes specifies rectanges using a centre point,
-- a width and a height. The 'rectToBox' function converts
-- from that format to our 'Box' format.
rectToBox :: G.Point -- ^ Convert a box with this centre...
             -> Int  -- ^ ...this width...
             -> Int  -- ^ ...and this height...
             -> Box  -- ^ ... to the 'Box' type.
rectToBox (x, y) w h =
    ((x-0.5*fromIntegral w, y-0.5*fromIntegral h),
     (x+0.5*fromIntegral w, y+0.5*fromIntegral h))

-- Why do vertical lines disappear? Maybe == is too strict. XXX
curve' :: Float -> G.Point -> G.Point -> [G.Point]
curve' alpha (x0, y0) (x1, y1) | x0 == x1 = [(x0, y0), (x1, y1)]
                            | x0 > x1 = curve' alpha (x1, y1) (x0, y0)
                            | otherwise =
                 let r = 1/(x0-x1)
                     c = (-(4*alpha*x0*x1)-x1*y0+x0*y1)*r
                     b = (4*alpha*(x0+x1)+y0-y1)*r
                     a = -4*alpha*r
                 in map (\i -> let x = x0+0.1*i*(x1-x0)
                               in (x, a*x*x+b*x+c)) [0..10]

polygons ::  [G.Point] -> [G.Point] -> G.Picture
polygons (u0 : us@(u1 : _)) (v0 : vs@(v1 : _)) =
    G.polygon [u0, u1, v1, v0] <> polygons us vs
polygons _ _ = G.blank
    
curve :: Float -> G.Point -> G.Point -> G.Picture
curve alpha p0 p1 = let c = curve' alpha p0 p1
                        (us, vs) = fatten 1.25 c
                    in polygons us vs

perp :: G.Point -> G.Point
perp (x, y) = (y, -x)

across :: Float -> G.Point -> G.Point -> G.Point
across t p0 p1 = perp $ mulSV (t/magV (p1-p0)) (p1-p0)

-- Fatten up curves to unions of rectangles.
--
--   p0 ---- p1 ---- p2 ---- p3
--
--   becomes
--
--   p0+n ---- p1+n ---- p2+n ---- p3+n
--     |         |         |         |
--   p0-n ---- p1-n ---- p2-n ---- p3-n
--
--   where the choice of n at each point depends on
--   the directions to the neighbouring points on the
--   curve.
fatten' :: Float -> [G.Point] -> ([G.Point], [G.Point]) ->
           ([G.Point], [G.Point])
fatten' t (p0 : p@(p1 : p2 : _)) (us, vs) = 
    let n1 = across t p0 p1
        n2 = across t p1 p2
        n = mulSV 0.5 (n1+n2)
    in fatten' t p (p1-mulSV t n : us, p1+mulSV t n : vs)
fatten' t [p0, p1] (us, vs) =
    let n = across t p0 p1
    in (p1-mulSV t n : us, p1+mulSV t n : vs)
fatten' _ ps _ = error ("Can't be called" ++ show ps)

fatten :: Float -> [G.Point] -> ([G.Point], [G.Point])
fatten _ [p0, p1] = ([p0, p1], [p0, p1])
fatten t (p0 : ps@(p1 : _)) = 
    let n = across t p0 p1
    in fatten' t ps ([p0-mulSV t n], [p0+mulSV t n])
fatten _ _ = error "Bad call"

clamp :: Float -> Float -> Float -> Float
clamp a b x | x < a = a
            | x > b = b
            | otherwise = x

-- | The 'Transform' type represents a 2D transform that is a
-- composition of translations and scalings.
data Transform = Transform { translate :: G.Point
                           , scaling :: Float } deriving Show

-- The monoid generated by 2D scalings and translations.
instance Monoid Transform where
    mempty = Transform (0, 0) 1
    Transform (tx, ty) s `mappend` Transform (tx', ty') s' =
        Transform (tx+s*tx', ty+s*ty') (s*s')

applyTransform :: Transform -> G.Point -> G.Point
applyTransform (Transform (tx, ty) s) (x, y) = (tx+s*x, ty+s*y)

inverse :: Transform -> Transform
inverse (Transform (tx, ty) s) =
    let is = 1/s in
    Transform (-tx*is, -ty*is) is

transparentBlack :: Float -> G.Color
transparentBlack = G.makeColor 0 0 0

textInBox :: G.Color -> G.Color -> String -> G.Picture
textInBox boxColor textColor targetText = 
    let w = estimateTextWidth targetText
    in G.color boxColor (G.rectangleSolid (w+10) 40) <>
       write (-w/2, -9) 0.2 textColor targetText
       {-
       G.translate (-w/2) (-9)
                 (G.scale 0.20 0.20 (G.color textColor (G.text targetText)))
                 -}

write :: (Float, Float) -> Float -> G.Color -> String -> G.Picture
write (x, y) s c = G.translate x y . G.scale s s . G.color c . G.text
