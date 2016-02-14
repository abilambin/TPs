:- use_module(library(clpfd)).

grille([[_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,3,_,8,5],
        [_,_,1,_,2,_,_,_,_],
        [_,_,_,5,_,7,_,_,_],
        [_,_,4,_,_,_,1,_,_],
        [_,9,_,_,_,_,_,_,_],
        [5,_,_,_,_,_,_,7,3],
        [_,_,2,_,1,_,_,_,_],
        [_,_,_,_,4,_,_,_,9]]).

% Q1

printline([]):- writeln('|').
printline([X|XS]):- integer(X), write('|'), write(X), printline(XS),!.
printline([_|XS]):- write('|'), write(' '), printline(XS).

% Q2

print([]).
print([X|XS]):- printline(X), print(XS).

% Q3

bonnelongueur([],0).
bonnelongueur([_|XS],L):- bonnelongueur(XS,L2), L is L2+1.

% Q4

bonnetaille([X],L):- bonnelongueur(X,L), !.
bonnetaille([X|XS],L):- bonnelongueur(X,L), bonnetaille(XS,L).

% Q5

verifie([]).
verifie([X|XS]):- X ins 1..9, all_distinct(X), verifie(XS).

% Q6

eclate([X],[],[[X]]):-!.
eclate([X],[Y|_],[[X|Y]]):-!.
eclate([X|XS],[],[[X]|L]):- eclate(XS,[],L),!.
eclate([X|XS],[YS|YSS],[[X|YS]|L]):- eclate(XS,YSS,L).

% Q7

transp([X],L):- eclate(X,[],L),!.
transp([X|XS],L):-  transp(XS,L2), eclate(X,L2,L).

% Q8

decoupe([],[],[],[]).
decoupe([X1|[X2|[X3|XS]]],[Y1|[Y2|[Y3|YS]]],[Z1|[Z2|[Z3|ZS]]],[[X1|[X2|[X3|[Y1|[Y2|[Y3|[Z1|[Z2|[Z3]]]]]]]]]|L]):- decoupe(XS,YS,ZS,L).

% Q9
concatene([],YS,YS).
concatene([X|XS],YS,[X|L]) :- concatene(XS,YS,L).

carres([],[]).
carres([X1|[X2|[X3|XS]]],L3):- decoupe(X1,X2,X3,L), carres(XS,L2), concatene(L,L2,L3).

% Q10
solution(XS) :- bonnetaille(XS,9), verifie(XS),
transp(XS,YS), bonnetaille(YS,9), verifie(YS),
carres(XS,ZS), verifie(ZS).


% Q11
grilleCross([[1,7,_,5,9,_,_,_,4],
             [_,2,_,_,7,_,_,9,_],
             [9,_,3,_,4,_,8,_,_],
             [_,_,_,4,2,7,_,_,_],
             [2,3,4,1,5,9,6,7,8],
             [_,_,_,3,8,6,_,_,_],
             [_,_,2,_,6,_,7,1,_],
             [_,1,_,_,3,_,_,8,_],
             [6,_,_,2,1,_,_,_,9]]).

diagonaleg([[X|[]]|[]],[X]):- !.
diagonaleg([[X|_]|XSS],[X|L]):- transp(XSS,[_|YSS]),diagonaleg(YSS,L).

retourne([],[],[]).
retourne([X],YS,[X|YS]).
retourne([X|XS],YS,A) :- retourne(XS,[X|YS],A).

retournetous([],[]).
retournetous([X|XS],[Y|L]):- retourne(X,[],Y), retournetous(XS,L), !.

diagonaled(XS,L):- retournetous(XS,L1), diagonaleg(L1,L).

solutiondiag(XS) :- bonnetaille(XS,9), verifie(XS),
transp(XS,YS), bonnetaille(YS,9), verifie(YS),
carres(XS,ZS), verifie(ZS),
diagonaleg(XS,DG), verifie([DG]),
diagonaled(XS,DD), verifie([DD]).

% Pour tester
% grilleCross(L), solutiondiag(L), print(L).


% Q12
grille4([[2,_,_,3],
        [_,_,2,_],
        [_,4,1,_],
        [1,_,_,_]]).

solution4(XS) :- bonnetaille(XS,4), verifie4(XS),
transp(XS,YS), bonnetaille(YS,4), verifie4(YS),
carres2(XS,ZS), verifie4(ZS).

verifie4([]).
verifie4([X|XS]):- X ins 1..4, all_distinct(X), verifie4(XS).

decoupe2([],[],[]).
decoupe2([X1|[X2|XS]],[Y1|[Y2|YS]],[[X1|[X2|[Y1|[Y2]]]]|L]):- decoupe2(XS,YS,L).

carres2([],[]).
carres2([X1|[X2|XS]],L3):- decoupe2(X1,X2,L), carres2(XS,L2), concatene(L,L2,L3).


% Q13
% TODO
