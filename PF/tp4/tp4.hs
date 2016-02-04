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
{-
foldArbre :: (a -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre _ v Feuille = v 
foldArbre f v (Noeud val _ g d) = f val (foldArbre f v g) (foldArbre f v d)
-}
-- 3
hauteur :: Arbre c a -> Int
hauteur Feuille  = 0
hauteur (Noeud _ _ g d) = 1 + (max (hauteur g) (hauteur d))

taille :: Arbre c a -> Int
taille Feuille  = 0
taille (Noeud _ _ g d) = 1 + (taille g) + (taille d)

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
-- prop_map

-- 7
estComplet :: Arbre c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = ((taille g) == (taille d)) && (estComplet g) && (estComplet d)


arbCompletTest  = Noeud 18 "vert" Feuille Feuille
arbCompletTest2 = Noeud 14 "vert" (Noeud 18 "vert" Feuille Feuille) (Noeud 51 "vert" Feuille Feuille)

foldArbre :: (a -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre _ v Feuille = v 
foldArbre f v (Noeud val _ g d) = f val (foldArbre f v g) (foldArbre f v d)

estComplet' :: Arbre c a -> Bool
estComplet' = foldArbre (\_ y z -> y && z ) True

arbPasCompletTest = Noeud 14 "vert" (Noeud 18 "vert" (Noeud 182 "vert" Feuille Feuille) Feuille) (Noeud 51 "vert"(Noeud 512 "vert" Feuille Feuille)  Feuille)

-- 8
