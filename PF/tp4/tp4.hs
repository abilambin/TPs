-- Fabre Loïc - Lambin Abigaïl - TP4

module Tp4 where
import Test.QuickCheck

-- 1
data Arbre coul val = Noeud { valeur :: val
                              , couleur :: coul
                              , gauche :: Arbre coul val
                              , droit  :: Arbre coul val }
                    | Feuille
                      deriving Show

-- 2
mapArbre :: (a -> b) -> Arbre c a -> Arbre c b
mapArbre _ Feuille  = Feuille
mapArbre f (Noeud val coul g d) =
 Noeud (f val) coul (mapArbre f g) (mapArbre f d)

foldArbre :: (a -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre _ v Feuille = v
foldArbre f v (Noeud val _ g d) = f val (foldArbre f v g) (foldArbre f v d)

-- 3
hauteur :: Arbre c a -> Int
hauteur Feuille  = 0
hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)

taille :: Arbre c a -> Int
taille Feuille  = 0
taille (Noeud _ _ g d) = 1 + taille g + taille d

arbTest = Noeud 14 "vert" (Noeud 18 "vert" (Noeud 42 "vert" Feuille Feuille) Feuille) (Noeud 51 "vert" Feuille Feuille)

hauteur' :: Arbre c a -> Int
hauteur' = foldArbre (\_ y z -> 1 + max y z) 0

taille' :: Arbre c a -> Int
taille' = foldArbre (\_ y z -> 1 + y + z) 0

-- 4
peigneGauche :: [(c,a)] -> Arbre c a
peigneGauche [] = Feuille
peigneGauche ((coul,v):xs) = Noeud v coul (peigneGauche xs) Feuille

-- 5
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)

-- 6
prop_taillePeigne xs = length xs == taille (peigneGauche xs)
-- prop_map f = sum (mapArbre f a) == mapArbre f (sum a)

-- 7
estComplet :: Arbre c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = (taille g == taille d) && estComplet g && estComplet d


arbCompletTest  = Noeud 18 "vert" Feuille Feuille
arbCompletTest2 = Noeud 14 "vert" (Noeud 18 "vert" Feuille Feuille) (Noeud 51 "vert" Feuille Feuille)

estComplet' :: Arbre c a -> Bool
estComplet' arbre = fst (foldArbre (\ _ (jeSuisComplet, h_g) (jeSuisComplet', h_d) -> (h_g == h_d && jeSuisComplet && jeSuisComplet', fromInteger (h_g + 1) )) (True, 0) arbre)

arbPasCompletTest = Noeud 14 "vert" (Noeud 18 "vert" (Noeud 182 "vert" Feuille Feuille) Feuille) (Noeud 51 "vert"(Noeud 512 "vert" Feuille Feuille)  Feuille)

-- 8
-- Il y a 2 peignes à gauche complets, quand l'arbre est une Feuille et quand l'arbre a 1 Noeud
prop_estCompletPeigne [] = estComplet (peigneGauche [])
prop_estCompletPeigne [x] = estComplet (peigneGauche [x])
prop_estCompletPeigne xs = not (estComplet (peigneGauche xs))

-- 9
complet :: Int -> [(c, a)] -> Arbre c a
complet 0 [] = Feuille
complet 1 [(coul, val)] = Noeud val coul Feuille Feuille
complet n xs = Noeud val coul g d
  where g          = complet (n-1) (take (n-1) xs)
        d          = complet (n-1) (drop n xs)
        (coul,val) = xs !! (n-1)


complet2 = Noeud "b" "red" (Noeud "a" "yellow" Feuille Feuille) (Noeud "c" "blue" Feuille Feuille)

complet3 = Noeud "d" "orange" (Noeud "b" "orange"  (Noeud "a" "orange" Feuille Feuille) (Noeud "c" "orange" Feuille Feuille)) (Noeud "f" "orange"  (Noeud "e" "orange" Feuille Feuille) (Noeud "g" "orange" Feuille Feuille))

complet4 = Noeud "h" "orange" (Noeud "d" "orange" (Noeud "b" "orange"  (Noeud "a" "orange" Feuille Feuille) (Noeud "c" "orange" Feuille Feuille)) (Noeud "f" "orange"  (Noeud "e" "orange" Feuille Feuille) (Noeud "g" "orange" Feuille Feuille))) (Noeud "l" "orange" (Noeud "j" "orange"  (Noeud "i" "orange" Feuille Feuille) (Noeud "k" "orange" Feuille Feuille)) (Noeud "n" "orange"  (Noeud "m" "orange" Feuille Feuille) (Noeud "o" "orange" Feuille Feuille)))


-- 10
-- La fonction en question s'appelle repeat
repeat' :: a -> [a]
repeat' = iterate id

-- 11
bizarre :: [a] -> [((), a)]
bizarre = map (\x ->((),x))

l = bizarre ['a'..]

-- 12
aplatit :: Arbre c a -> [(c,a)]
aplatit Feuille = []
aplatit (Noeud val coul g d) = concat [aplatit g, [(coul,val)], aplatit d]

-- 13
element :: Eq a => a -> Arbre c a -> Bool
element _ Feuille = False
element x (Noeud val _ g d) | x==val = True
							| otherwise = element x g || element x d

-- 14
noeud :: (c -> String) -> (a -> String) -> (c,a) -> String
noeud f g (c,a) = g a ++ f c

coul2S coul = " [color=" ++ coul ++", fontcolor=" ++ coul ++"]"
val2S val = ""++val

noeudSpec = noeud coul2S val2S

-- 15
arcs :: Arbre c a -> [(a,a)]
arcs Feuille = []
arcs (Noeud val coul Feuille Feuille) = []
arcs (Noeud val coul Feuille d@(Noeud vald could gd dd)) = concat [[(val,vald)], arcs d]
arcs (Noeud val coul g@(Noeud valg coulg gg dg) Feuille) = concat [[(val,valg)], arcs g]
arcs (Noeud val coul g@(Noeud valg coulg gg dg) d@(Noeud vald could gd dd)) = concat [[(val,valg)], [(val,vald)], arcs g, arcs d]

-- 16
arc :: (a -> String) -> (a,a) -> String
arc f (valM,valF) = f valM ++ " -> " ++ f valF

-- 17
dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String

{-
dotise "" _ h Feuille = "Test chaine vide Feuille"
dotise nameArb _ h Feuille = "Test nameArb = " ++ nameArb ++ " Feuille"
dotise "" f h (Noeud val coul g d) = "Test chaine vide Noeud"

dotise nameArb f h a@(Noeud val coul g d) = unlines ["digraph \""++nameArb++"\" {","node [fontname=\"DejaVu-Sans\", shape=circle]","","/* Liste des noeuds */",map noeudSpec (val,coul),"","/* Liste des arcs */", "map arc (arcs a)"]
-}

dotise nameArb f h a = unlines [ "digraph \""++nameArb++"\" {"
                               , "node [fontname=\"DejaVu-Sans\", shape=circle]"
                               , ""
                               , "/* Liste des noeuds */"
                               , fonction1 f h a
                               , "/* Liste des arcs */"
                               , fonction2 h a]

fonction1 :: (c -> String) -> (a -> String) -> Arbre c a -> String
fonction1 _ _ Feuille = ""
fonction1 f h (Noeud val coul Feuille Feuille) =  noeud f h (coul,val)
fonction1 f h (Noeud val coul Feuille d) = unlines [noeud f h (coul,val), fonction1 f h d]
fonction1 f h (Noeud val coul g Feuille) = unlines [noeud f h (coul,val), fonction1 f h g]
fonction1 f h (Noeud val coul g d) = unlines [noeud f h (coul,val), fonction1 f h g, fonction1 f h d]

fonction2 h a = unlines (map (arc h) (arcs a))
