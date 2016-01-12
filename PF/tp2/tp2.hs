import Graphics.Gloss

-- 1

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

-- 5
pointAintercaler :: Point -> Point -> Point

pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

-- 6
pasDragon :: Path -> Path
-- TODO
pasDragon (x:y:xs) = x : (pointAintercaler x y) : (pasDragon2 xs)

pasDragon2 (x:y:xs) = x : (pointAintercaler y x) : (pasDragon xs)
