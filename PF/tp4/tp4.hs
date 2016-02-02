-- Fabre Loïc - Lambin Abigaïl - TP4

module Tp4 where

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

foldArbre :: (a -> b -> b -> b) -> Arbre c a -> b -> b
foldArbre _ Feuille v = v 
foldArbre f (Noeud val _ g d) v = f val (foldArbre f g v) (foldArbre f d v)

-- 3
hauteur Feuille  = 0
hauteur (Noeud _ _ g d) = 1 + (max (hauteur g) (hauteur d))

taille Feuille  = 0
taille (Noeud _ _ g d) = 1 + (taille g) + (taille d)

arbTest = Noeud 14 "vert" (Noeud 18 "vert" (Noeud 42 "vert" Feuille Feuille) Feuille) (Noeud 51 "vert" Feuille Feuille)

hauteur'  = 
 
-- 4
