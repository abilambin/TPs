import Graphics.Gloss

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

-- 1
motSuivant :: Regles -> Mot -> Mot
motSuivant r [] = []
motSuivant r (x:xs) = (r x) ++ motSuivant r xs

motSuivant' :: Regles -> Mot -> Mot
motSuivant' r [] = []
motSuivant' r xs = concat [r x | x <- xs]

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' r xs = concatMap r xs

-- 2
flocon :: Symbole -> Mot
flocon s | s=='+' = ['+']
         | s=='-' = ['-']
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