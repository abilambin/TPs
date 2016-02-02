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
aux :: Config -> Mot -> Path -> Path
aux _ [] _ = error "Mot vide"
aux conf [x] points = fst(fst(interpreteSymbole conf (etatInitial conf,[]) x)):points
aux conf@(etat,l,ech,a,zs) (x:xs) points = aux ( fst(interpreteSymbole conf (etat, []) x),l,ech,a,zs) (xs) (fst(etat):points)

interpreteMot :: Config -> Mot -> Picture
interpreteMot conf xs = Line (aux conf xs [])

dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F"
main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin


-- 10
lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime sys config t = interpreteMot newConf (sys !! iteration)
        where iteration = round t `mod` 8
              newConf = (etatInitial config, longueurPas config * (facteurEchelle config) ^ iteration, facteurEchelle config, angle config, symbolesTortue config)

dessin2 sys t = lsystemeAnime sys (((-150,0),0),100,1,pi/3,"F+-") t
main2 sys t= display (InWindow "L-système" (1000, 1000) (0, 0)) white (dessin2 sys t)


vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
    where regles 'X' = "+YF-XFX-FY+"
          regles 'Y' = "-XF+YFY+FX-"
          regles  s  = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
    where regles 'X' = "X+YF+"
          regles 'Y' = "-FX-Y"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")

-- 11
type EtatDessin2 = ([EtatTortue], [Path])

-- 12
-- Adaptons tout d'abord l'interpretation des symboles. 
interpreteSymbole2 :: Config -> EtatDessin2 -> Symbole -> EtatDessin2
interpreteSymbole2 config (etat:xs, path:ys) symb | symb == '+' = (tourneAGauche config etat:xs , path:ys)
                                                  | symb == '-' = (tourneADroite config etat:xs , path:ys) 
                                                  | symb == '[' = (etat:etat:xs, [fst etat]:path:ys)
                                                  | symb == ']' = (xs, [fst (head xs)]:path:ys)
                                                  | otherwise = (avance config etat:xs , (path ++ [fst (avance config etat)]):ys)
interpreteSymbole2 _ _ _ = error "Not matching"


-- Maintenant on adapte l'interpretation des mots.

interpreteMots :: Config -> Mot -> Picture
interpreteMots config mot = interpreteMots2 config (filtreSymbolesTortue config mot)

interpreteMots2:: Config -> Mot -> Picture
interpreteMots2 config mot = pictures (map line (snd (foldl (interpreteSymbole2 config) (initi, [[fst (head initi)]]) mot)) )
        where initi = [etatInitial config]
        
lsystemeAnime' :: LSysteme -> Config -> Float -> Picture
lsystemeAnime' sys config t = interpreteMots newConf (sys !! iteration)
        where iteration = round t `mod` 6
              newConf = (etatInitial config, longueurPas config * (facteurEchelle config) ^ iteration, facteurEchelle config, angle config, symbolesTortue config)

brindille :: LSysteme
brindille = lsysteme "F" regles
    where regles 'F' = "F[-F]F[+F]F"
          regles  s  = [s]

broussaille :: LSysteme
broussaille = lsysteme "F" regles
    where regles 'F' = "FF-[-F+F+F]+[+F-F-F]"
          regles  s  = [s]

brindilleAnime :: Float -> Picture
brindilleAnime = lsystemeAnime' brindille (((0, -400), pi/2), 800, 1/3, 25*pi/180, "F+-[]")

broussailleAnime :: Float -> Picture
broussailleAnime = lsystemeAnime' broussaille (((0, -400), pi/2), 500, 2/5, 25*pi/180, "F+-[]")

mainBrindille t= display (InWindow "L-système" (1000, 1000) (0, 0)) white (brindilleAnime t)
mainBroussaille t= display (InWindow "L-système" (1000, 1000) (0, 0)) white (broussailleAnime t)
