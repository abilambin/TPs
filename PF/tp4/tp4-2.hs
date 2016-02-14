-- Fabre Loïc - Lambin Abigaïl - TP4 (Suite)

data Arbre coul val = Noeud { valeur :: val
                              , couleur :: Couleur
                              , gauche :: Arbre coul val
                              , droit  :: Arbre coul val }
                    | Feuille
                      deriving Show

-- 18
elementR :: a -> Arbre -> Boolean
elementR _ Feuille = False
elementR e (Noeud val coul g d) | e == val  = True
                                | e < val   = elementR e g
                                | otherwise = elementR e d

-- 19
data Couleur = N | R

-- 20
equilibre :: Arbre c a -> Arbre c a
equilibre a@(Noeud val coul g d) = 
