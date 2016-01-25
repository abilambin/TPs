-- Lambin Abigaïl tp2

import Graphics.Gloss

-- 1
alterne :: [t] -> [t]

alterne [] = []
alterne [x] = [x]
alterne (x:xs) = x : (alterne (tail xs))

-- 2
combine :: (a -> b -> c) -> [a] -> [b] -> [c]

combine f xs ys | null xs || null ys = []
combine f [x] (y:ys) = [f x y]
combine f (x:xs) [y] = [f x y]
combine f (x:xs) (y:ys) = [f x y] ++ combine f xs ys

-- 3
pasPascal :: [Integer] -> [Integer]

pasPascal xs = zipWith (+) (0:xs) (reverse (0:xs))

-- 4
pascal :: [[Integer]]

pascal = iterate pasPascal [1]
{-
-- 5
pointAintercaler :: Point -> Point -> Point

pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

-- 6
pasDragon :: Path -> Path
-- TODO
pasDragon [] = []
pasDragon (x:[]) = [x]
pasDragon (x:y:[]) = :pointAintercaler x y:y:[]
pasDragon (x:y:z:xs) = x:pointAintercaler x y:y:pointAintercaler z y:(pasDragon(z:xs))

-- 7

main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))

dragon :: Point -> Point -> [Path]

dragon p1 p2 = iterate pasDragon [p1,p2]

-- 8
dragonOrdre :: Point -> Point -> Int -> Path

dragonOrdre a b 0 =a:b:[]
dragonOrdre a b n = (dragonOrdre a (pointAintercaler ab) (n-1)) ++ (dragonOrdre b (pointAintercaler a b) (n-1))

-- 9
main' = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime2 (50,250) (450,250) )

dragonAnime' a b t = Line (dragon2 a b)

dragon' a b = (dragonOrdre a b 15)

-}
