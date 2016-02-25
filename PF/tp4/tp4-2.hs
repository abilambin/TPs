-- Fabre Loïc - Lambin Abigaïl - TP4 (Suite)

module Tp4_2 where
import Test.QuickCheck

hauteur :: Arbre c a -> Int
hauteur Feuille  = 0
hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)

taille :: Arbre c a -> Int
taille Feuille  = 0
taille (Noeud _ _ g d) = 1 + taille g + taille d

data Arbre coul val = Noeud { valeur :: val
                              , couleur :: Couleur
                              , gauche :: Arbre coul val
                              , droit  :: Arbre coul val }
                    | Feuille
                      deriving Show

-- 18
elementR ::(Eq a, Ord a) => a -> Arbre c a-> Bool
elementR _ Feuille = False
elementR e (Noeud val coul g d) | e == val  = True
                                | e < val   = elementR e g
                                | otherwise = elementR e d

-- 19
data Couleur = N | R
                      deriving Show
-- 20
equilibre :: Arbre c a -> Arbre c a
equilibre Feuille = Feuille
equilibre (Noeud val coul Feuille Feuille) = Noeud val coul Feuille Feuille
equilibre (Noeud val N (Noeud val2 R (Noeud val3 R ggg ggd) gd) d) = Noeud val2 R (Noeud val3 N ggg ggd) (Noeud val N gd d)
equilibre (Noeud val N (Noeud val2 R gg (Noeud val3 R gdg gdd)) d) = Noeud val3 R (Noeud val2 N gg gdg) (Noeud val N gdd d)
equilibre (Noeud val N g (Noeud val2 R (Noeud val3 R dgg dgd) dd)) = Noeud val3 R (Noeud val N g dgg) (Noeud val2 N dgd dd)
equilibre (Noeud val N g (Noeud val2 R dg (Noeud val3 R ddg ddd))) = Noeud val2 R (Noeud val N g dg) (Noeud val3 N ddg ddd)

arbA = Noeud 'A' N Feuille Feuille
arbB = Noeud 'B' N Feuille Feuille
arbC = Noeud 'C' N Feuille Feuille
arbD = Noeud 'D' N Feuille Feuille

arbTestEqui1 = Noeud 'z' N (Noeud 'y' R (Noeud 'x' R arbA arbB) arbC) arbD
arbTestEqui2 = Noeud 'z' N (Noeud 'x' R arbA (Noeud 'y' R arbB arbC)) arbD
arbTestEqui3 = Noeud 'x' N arbA (Noeud 'z' R (Noeud 'y' R arbB arbC) arbD)
arbTestEqui4 = Noeud 'x' N arbA (Noeud 'y' R arbB (Noeud 'z' R arbC arbD ))

-- 21
insertion ::(Eq a, Ord a) =>  a -> Arbre c a -> Arbre c a
insertion v a | elementR v a = a
insertion v Feuille = Noeud v R Feuille Feuille
insertion v (Noeud val coul g d) | v < val = equilibre (Noeud val coul (insertion v g) d)
                                 | otherwise = equilibre (Noeud val coul g (insertion v d))
                                               
arbTestI = Noeud 2 N Feuille Feuille