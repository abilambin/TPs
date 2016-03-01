-- Fabre Loïc - Lambin Abigaïl - TP5

module Interprete where
import Parser

type Nom = String

data Expression = Lam Nom Expression
                | App Expression Expression
                | Var Nom
                | Lit Litteral
                deriving (Show,Eq)

data Litteral = Entier Integer
              | Bool   Bool
              deriving (Show,Eq)

-- 1
espacesP :: Parser ()
espacesP = do zeroOuPlus (car ' ')
              return ()

-- 2
lettreMin :: Parser Char
lettreMin = carCond (`elem` ['a'..'z'])

nomP :: Parser Nom
nomP = do cs <- unOuPlus lettreMin
          espacesP
          return cs

-- 3
varP :: Parser Expression
varP = do cs <- unOuPlus lettreMin
          _ <- espacesP
          return (Var cs)

-- 4
applique :: [Expression] -> Expression
applique [e] = e
applique (e1:e2:es) = applique ((App e1 e2):es)

-- 5
exprP :: Parser Expression
exprP = varP

exprsP :: Parser Expression
exprsP = do exp <- unOuPlus exprP
            return (applique exp)

-- 6
lambdaP :: Parser Expression
lambdaP = do car '\\'
             espacesP
             x <- nomP
             espacesP
             chaine "->"
             _ <- espacesP
             exp <- exprsP
             return (Lam x exp)




--f
