-- Fabre Loïc - Lambin Abigaïl - TP3

module Tp3 where
import Graphics.Gloss

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

-- 1
motSuivant :: Regles -> Mot -> Mot
motSuivant r = foldr ((++) . r) []

motSuivant' :: Regles -> Mot -> Mot
motSuivant' r [] = []
motSuivant' r xs = concat [r x | x <- xs]

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' = concatMap

-- 2
flocon :: Symbole -> Mot
flocon s | s=='+' = "+"
         | s=='-' = "-"
         | s=='F' = "F-F++F-F"

-- 3
lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = a : lsysteme (motSuivant r a) r


type EtatTortue = (Point, Float)
type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue

-- 4
etatInitial :: Config -> EtatTortue
etatInitial (x,_,_,_,_) = x

longueurPas :: Config -> Float
longueurPas (_,x,_,_,_) = x

facteurEchelle :: Config -> Float
facteurEchelle (_,_,x,_,_) = x

angle :: Config -> Float
angle (_,_,_,x,_) = x

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_,_,_,_,x) = x


-- 5
avance :: Config -> EtatTortue -> EtatTortue
avance (_,d,_,_,_) ((x,y),cap) = ((x+d*cos(cap),y+d*sin(cap)),cap)

-- 6
tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche (_,_,_,a,_) (p,cap) = (p,cap+a)

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite (_,_,_,a,_) (p,cap) = (p,cap-a)

-- 7
filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue (_,_,_,_,s) mot = [ x | x <- mot, elem x s]


type EtatDessin = (EtatTortue, Path)
-- 8
interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole conf (etat,xs) s | s=='F' = (avance conf etat,fst(avance conf etat):xs)
                                   | s=='+' = (tourneAGauche conf etat,xs)
                                   | s=='-' = (tourneADroite conf etat,xs)
                                   | otherwise = (etat,xs)
-- 9
aux :: Config -> EtatDessin -> Mot -> EtatDessin
-- TODO : corriger : itérer la fonction interpretSymbole
aux _ _ [] = error "Mot vide"
aux conf _ [x] = interpreteSymbole conf (etatInitial conf,[]) x
aux conf@(etat,l,ech,a,zs) etatA (x:xs) = aux (( fst(interpreteSymbole conf (etat,[]) x),l,ech,a,zs) (fst(etat)) (xs))

interpreteMot :: Config -> Mot -> Picture
interpreteMot conf xs = Line (aux conf (etatInitial conf,fst(etatInitial conf)) xs)

dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F"
main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin



interpreteMot2 :: Config -> Mot -> Picture
interpreteMot2 _ _ = Line [(0,0),(10,10),(20,20),(30,10),(40,20),(50,10),(60,0)]

dessin2 = interpreteMot2 (((-150,0),0),100,1,pi/3,"F+-") ""
main2 = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin2
