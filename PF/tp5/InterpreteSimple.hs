-- Fabre Loïc - Lambin Abigaïl - TP5

module InterpreteSimple where
import Interprete
import Data.Maybe
import System.IO

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
interpreteA _ (Lit a) = VLitteralA a
interpreteA env (Var a) = fromJust (lookup a env)
interpreteA env (Lam nom expr) = VFonctionA (\var -> interpreteA ((nom,var):env) expr)
interpreteA env (App x y) =
  case interpreteA env x of
    VFonctionA f -> f (interpreteA env y)
    VLitteralA _ -> error "Erreur VLitt"


-- 16
negA :: ValeurA
negA = (VFonctionA (\(VLitteralA (Entier a)) -> (VLitteralA (Entier (negate a)))))

-- 17
addA :: ValeurA
addA = (VFonctionA (\(VLitteralA (Entier a)) -> VFonctionA (\(VLitteralA (Entier b)) -> (VLitteralA (Entier (a + b))))))

-- 18
envA :: Environnement ValeurA
envA = [ ("neg",   negA)
       , ("add",   releveBinOpEntierA (+))
       , ("soust", releveBinOpEntierA (-))
       , ("mult",  releveBinOpEntierA (*))
       , ("quot",  releveBinOpEntierA quot) ]

releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA op = (VFonctionA (\(VLitteralA (Entier a)) -> VFonctionA (\(VLitteralA (Entier b)) -> (VLitteralA (Entier (a `op` b))))))

-- 19
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA (\(VLitteralA (Bool b)) -> (VFonctionA (\(VLitteralA (Entier t)) -> (VFonctionA (\(VLitteralA (Entier e)) ->
  case b of
    True -> (VLitteralA (Entier t))
    False -> (VLitteralA (Entier e)))))))


-- 20
main :: IO ()








-- end
