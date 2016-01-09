-- 3
sommeDeXaY x y = sum [x..y]

-- 4
somme [] = 0
somme (x:xs) = x + somme xs

-- 5

last' xs = head (reverse xs)

init' xs = reverse (tail (reverse xs))

-- 6

(x:xs) !!! 1 = x
(x:xs) !!! i = xs !!! (i-1)

[x] +++ ys = x : ys
(x:xs) +++ ys = x : (xs +++ ys)

concat' [x] = x
concat' (x:xs) = x +++ (concat' xs)

map' f [x] = [f x]
map' f (x:xs) = (f x) : (map' f xs)

-- 7
-- x i devient alors une fonction qui prendra le i ème élément de la liste l
-- (car x = (!!) l)

-- 8

length' xs = let f x = 1 in
             somme (map f xs)

-- 9

build f x n = take n (iterate f x)

-- TODO : build' :

 build' f x n =

-- 10

listeEntiers n = build (1+) 0 (n+1)
