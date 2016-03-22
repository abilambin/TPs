{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
--- Fabre Loïc - Lambin Abigaïl - TP5

module InterpreteSimple where
import Interprete
import Data.Maybe
import System.IO

main::IO()
main = do putStr "philanthrope> "
          expr <- getLine
          putStrLn expr
          putStrLn (" -> " ++ show (interpreteE envM (ras expr)))
          main

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
       , ("quot",  releveBinOpEntierA quot) 
       , ("if",    ifthenelseA)]

releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA op = (VFonctionA (\(VLitteralA (Entier a)) -> VFonctionA (\(VLitteralA (Entier b)) -> (VLitteralA (Entier (a `op` b))))))

-- 19
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA (\(VLitteralA (Bool b)) -> (VFonctionA (\(VLitteralA (Entier t)) -> (VFonctionA (\(VLitteralA (Entier e)) ->
  case b of
    True -> (VLitteralA (Entier t))
    False -> (VLitteralA (Entier e)))))))


-- 20
-- voir main en début de fichier


-- Question 21
data ValeurB = VLitteralB Litteral
             | VFonctionB (ValeurB -> ErrValB)

type MsgErreur = String
type ErrValB   = Either MsgErreur ValeurB


instance Show ValeurB where
    show (VFonctionB _) = show '^'
    show (VLitteralB (Entier a)) = show a
    show (VLitteralB (Bool b)) = show b

-- Question 22
interpreteB :: Environnement ValeurB -> Expression -> ErrValB
interpreteB _ (Lit a) = Right (VLitteralB a)
interpreteB envi (Var a)| isJust (lookup a envi)= Right (fromJust (lookup a envi))
interpreteB _ (Var a) = Left ("la variable " ++ a ++ " n'est pas definie")
interpreteB envi (Lam nom expr) = Right (VFonctionB (\var -> interpreteB ((nom,var):envi) expr))
interpreteB envi (App e e') = case interpreteB envi e of
                                Left a -> Left a
                                Right (VFonctionB f)-> case interpreteB envi e' of
                                                            Left a -> Left a
                                                            Right a -> f a
                                Right v -> Left (show v ++ " n'est pas une fonction, application impossible.")
                                
-- Question 23
envB :: Environnement ValeurB
envB = [("add",   addB)
       , ("quot", quotB)]

addB :: ValeurB
addB = VFonctionB (\param -> case param of
                                VLitteralB (Entier e) -> Right (VFonctionB (\param' -> case param' of                                
                                                                                                VLitteralB (Entier e') -> Right (VLitteralB (Entier (e+e')))
                                                                                                x' -> Left (show x' ++ " n'est pas un entier.")))
                                x -> Left (show x ++ " n'est pas un entier."))

-- Question 24
quotB :: ValeurB
quotB = VFonctionB (\param -> case param of
                                VLitteralB (Entier e) -> Right (VFonctionB (\param' -> case param' of       
                                                                                                VLitteralB (Entier 0) -> Left "division par zero"                         
                                                                                                VLitteralB (Entier e') -> Right (VLitteralB (Entier (quot e e')))
                                                                                                x' -> Left (show x' ++ " n'est pas un entier.")))
                                x -> Left (show x ++ " n'est pas un entier."))

-- Question 25
data ValeurC = VLitteralC Litteral
             | VFonctionC (ValeurC -> OutValC)

type Trace   = String
type OutValC = (Trace, ValeurC)

   
instance Show ValeurC where
    show (VFonctionC _) = show '^'
    show (VLitteralC (Entier a)) = show a
    show (VLitteralC (Bool b)) = show b

-- Question 26
interpreteC :: Environnement ValeurC -> Expression -> OutValC
interpreteC _ (Lit a) = ("", VLitteralC a)
interpreteC envi (Var a) = ("", fromJust (lookup a envi))
interpreteC envi (Lam nom expr) = ("", VFonctionC (\var -> interpreteC ((nom,var):envi) expr))
interpreteC envi (App e e') = case interpreteC envi e of
                                (trace, VFonctionC f) -> ('.':fst fonc++trace, snd fonc)
                                        where fonc = f (snd (interpreteC envi e'))
                                v -> error (show v ++ "should be a function")

-- Question 27
pingC::ValeurC
pingC = VFonctionC (\val -> ("p",val))

-- Question 28
data ValeurM m = VLitteralM Litteral
               | VFonctionM (ValeurM m -> m (ValeurM m))
               
 
instance Show (ValeurM m) where
                                show (VFonctionM _) = show '^'
                                show (VLitteralM (Entier a)) = show a
                                show (VLitteralM (Bool b)) = show b

-- Question 29
data SimpleM v = S v
               deriving Show
                              
interpreteSimpleM :: Environnement (ValeurM SimpleM) -> Expression -> SimpleM (ValeurM SimpleM)
interpreteSimpleM _ (Lit a) = S (VLitteralM a)
interpreteSimpleM envi (Var a) = S (fromJust (lookup a envi))
interpreteSimpleM envi (Lam nom expr) = S (VFonctionM (\var -> interpreteSimpleM ((nom,var):envi) expr))
interpreteSimpleM envi (App e e') = case interpreteSimpleM envi e of
                                S (VFonctionM f) -> f x
                                        where (S x) = interpreteSimpleM envi e'
                                v -> error (show v ++ "should be a function")

-- Question 30
instance Monad SimpleM where
    return      = S
    (S v) >>= f = f v

interpreteM :: Monad m => Environnement (ValeurM m) -> Expression -> m (ValeurM m)
interpreteM _ (Lit a) = return (VLitteralM a)
interpreteM envi (Var a) = return (fromJust (lookup a envi))
interpreteM envi (Lam nom expr) = return (VFonctionM (\var -> interpreteM ((nom,var):envi) expr))
interpreteM envi (App e e') = do (VFonctionM var) <- interpreteM envi e
                                 interpreteM envi e' >>= var
                                 
-- Question 31
type InterpreteM m = Environnement (ValeurM m) -> Expression -> m (ValeurM m)

interpreteS :: InterpreteM SimpleM
interpreteS = interpreteM
-- Oui il se comporte comme il le faut :D

-- Question 32
data TraceM v = T (Trace, v)
              deriving Show
              
instance Monad TraceM where
        return v     = T ("", v)
        T (t, v) >>= f = T (t ++ft, v')
                                where (T (ft, v')) = f v
                                
interpreteMT :: InterpreteM TraceM
interpreteMT = interpreteM

pingM :: ValeurM TraceM
pingM = VFonctionM (\v -> T ("p", v))
 
-- Question 33
interpreteMT' :: InterpreteM TraceM     
interpreteMT' env (App e e') = T ("." ++ traceApp ++ traceFonc, result) 
                                        where T (traceApp, result) = f a
                                              T (traceFonc, VFonctionM f) = interpreteMT' env e
                                              T (_, a) = interpreteMT' env e'
interpreteMT' env entre = interpreteMT env entre  

--Question 34
data ErreurM v = Succes v
               | Erreur String
               deriving Show
               
instance Monad ErreurM where
    fail = Erreur
    return = Succes
    err >>= f = case err of
                    Succes e -> f e
                    Erreur e -> Erreur e
    
 -- Question 35
interpreteE :: InterpreteM ErreurM
interpreteE env (Var a) | isNothing (lookup a env) = fail ("La varible " ++ a ++ " n'est pas definie.")
interpreteE env (App e e') = case interpreteE env e of
                                (Erreur a) -> fail a
                                (Succes (VFonctionM f)) -> case interpreteE env e' of
                                                              (Erreur a) -> fail a
                                                              (Succes a) -> f a  
                                (Succes x) -> fail (show x ++" n'est pas une fonction, application impossible")
interpreteE env entre = interpreteM env entre

pingE :: ValeurM ErreurM
pingE = VFonctionM Succes

-- Question 36
class Monad m => Injectable m t where
    injecte :: t -> ValeurM m
    
instance Monad m => Injectable m Bool where
    injecte bool = VLitteralM (Bool bool)
    
instance Monad m => Injectable m Integer where
    injecte = VLitteralM . Entier
    
-- Question 37
instance (Monad m, Injectable m t) => Injectable m (Bool -> t) where
    injecte f= VFonctionM (\(VLitteralM (Bool bool)) -> return (injecte (f bool)))

instance (Monad m, Injectable m t) => Injectable m (Integer -> t) where
    injecte f = VFonctionM (\(VLitteralM (Entier e)) -> return (injecte (f e)))

-- Question 38

envM :: Monad m => Environnement (ValeurM m)
envM = [ ("add",    injecte ((+) :: Integer -> Integer -> Integer))
       , ("sous",   injecte ((-) :: Integer -> Integer -> Integer))
       , ("mult",   injecte ((*) :: Integer -> Integer -> Integer))
       , ("quot",   injecte (quot :: Integer -> Integer -> Integer))
       , ("et",     injecte (&&))
       , ("ou",     injecte (||))
       , ("non",    injecte not)
       , ("neg",    injecte (negate :: Integer -> Integer))]
