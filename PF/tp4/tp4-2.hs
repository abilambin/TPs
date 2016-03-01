-- Fabre Loïc - Lambin Abigaïl - TP4 (Suite)

module Tp4_2 where
import Test.QuickCheck 
import Data.Char
import Control.Concurrent (threadDelay)

data Arbre coul val = Noeud { valeur :: val
                              , couleur :: Couleur
                              , gauche :: Arbre coul val
                              , droit  :: Arbre coul val }
                    | Feuille
                      deriving Show
-- 14
noeud :: (Couleur -> String) -> (a -> String) -> (Couleur,a) -> String
noeud f g (c,a) = g a ++ f c

coul2S N = " [color= black, fontcolor=black]"
coul2S R = " [color=red, fontcolor=red]"
valInt2S val = (intToDigit val):[]
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
dotise :: String -> (Couleur -> String) -> (a -> String) -> Arbre Couleur a -> String
dotise nameArb f h a = unlines [ "digraph \""++nameArb++"\" {"
                               , "node [fontname=\"DejaVu-Sans\", shape=circle]"
                               , ""
                               , "/* Liste des noeuds */"
                               , noeudValCoul f h a
                               , "/* Liste des arcs */"
                               , arcList h a
                               , "}"]
                       
noeudValCoul :: (Couleur -> String) -> (a -> String) -> Arbre Couleur a -> String
noeudValCoul _ _ Feuille = ""
noeudValCoul f h (Noeud val co Feuille Feuille) =  noeud f h (co,val)
noeudValCoul f h (Noeud val coul Feuille d) = unlines [noeud f h (coul,val), noeudValCoul f h d]
noeudValCoul f h (Noeud val coul g Feuille) = unlines [noeud f h (coul,val), noeudValCoul f h g]
noeudValCoul f h (Noeud val coul g d) = unlines [noeud f h (coul,val), noeudValCoul f h g, noeudValCoul f h d]

arcList h a = unlines (map (arc h) (arcs a))

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
equilibre (Noeud z N (Noeud y R (Noeud x R a b) c) d) = Noeud y R (Noeud x N a b) (Noeud z N c d)
equilibre (Noeud z N (Noeud x R a (Noeud y R b c)) d) = Noeud y R (Noeud x N a b) (Noeud z N c d)
equilibre (Noeud x N a (Noeud z R (Noeud y R b c) d)) = Noeud y R (Noeud x N a b) (Noeud z N c d)
equilibre (Noeud x N a (Noeud y R b (Noeud z R c d))) = Noeud y R (Noeud x N a b) (Noeud z N c d)
equilibre (Noeud val coul g d) = Noeud val coul (equilibre g) (equilibre d)
equilibre _ = Feuille

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
insertion v Feuille = Noeud v N Feuille Feuille
insertion v (Noeud val coul g d) | v < val = equilibre (Noeud val coul (insertion v g) d)
                                 | otherwise = equilibre (Noeud val coul g (insertion v d))
                                               
arbTestI = Noeud 2 N Feuille Feuille


-- 23
arbresDot :: String -> [String]
arbresDot xs = arbresDot' xs Feuille

arbresDot' :: [Char] -> Arbre Couleur Char -> [String]
arbresDot' [] _ = []
arbresDot' (x:xs)  arbre = (dotise "arbre" coul2S (\v-> [v]) newArbre) : (arbresDot' xs newArbre)
        where newArbre = insertion x arbre

main = mapM_ ecrit arbres
    where ecrit a = do writeFile "arbre.dot" a
                       threadDelay 1000000
          arbres  = arbresDot "gcfxieqzrujlmdoywnbakhpvst"
