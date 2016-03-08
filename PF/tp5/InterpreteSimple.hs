-- Fabre Loïc - Lambin Abigaïl - TP5

module InterpreteSimple where
import Interprete

data ValeurA = VLitteralA Litteral
             | VFonctionA (ValeurA -> ValeurA)

-- 14

instance Show ValeurA where
    show (VFonctionA _) = "λ"
                       -- ^ ou "VFonctionA _", ou "<fun>" ou toute
                       --   autre représentation des fonctions
    show (VLitteralA a) = show a

type Environnement a = [(Nom, a)]

-- 15
interpreteA :: Environnement ValeurA -> Expression -> ValeurA
interpreteA [] (Lit a) = VLitteralA a
interpreteA [] (Lam _ y) = interpreteA [] y
interpreteA [] (App x y) =
  case interpreteA [] x of
    VFonctionA f -> f (interpreteA [] y)
    VLitteralA _ -> error "Erreur VLitt"


-- end
