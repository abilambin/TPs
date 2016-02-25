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

% Pour tester : grilleCross(L), solutiondiag(L), print(L).


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
grillehex([[b,2,_,7,_,_,_,f,6,e,_,_,_,3,_,d],
           [_,_,_,9,b,_,2,_,_,_,_,_,f,1,_,6],
           [_,a,_,c,_,_,7,_,4,_,8,_,_,_,e,_],
           [_,8,_,3,_,_,1,_,_,_,f,c,a,_,4,2],
           [_,_,e,_,_,_,_,_,1,6,a,_,_,_,3,_],
           [3,_,_,_,_,_,_,_,_,4,_,f,8,_,6,b],
           [_,_,_,d,2,_,_,_,_,b,_,_,7,4,_,_],
           [_,b,8,4,0,_,_,d,7,_,9,3,e,_,_,_],
           [_,_,_,f,3,7,_,4,5,_,_,9,0,d,c,_],
           [_,_,c,8,_,_,a,_,_,_,_,b,4,_,_,_],
           [4,9,_,5,e,_,d,_,_,_,_,_,_,_,_,a],
           [_,d,_,_,_,6,c,1,_,_,_,_,_,7,_,_],
           [9,1,_,e,7,4,_,_,_,f,_,_,3,_,d,_],
           [_,3,_,_,_,9,_,2,_,1,_,_,5,_,0,_],
           [f,_,4,b,_,_,_,_,_,3,_,d,1,_,_,_],
           [5,_,d,_,_,_,f,e,9,_,_,_,2,_,b,4]]).


% Pour tester : grillehex(L), transfalltodec(L,L1), solutionhex(L1), transfalltohex(L1,L2), printhex(L2).

solutionhex(XS) :- bonnetaille(XS,16), verifiehex(XS),
transp(XS,YS), bonnetaille(YS,16), verifiehex(YS),
carres4(XS,ZS), verifiehex(ZS).


% Pour tester2 : grillehex(L), solutionhex2(L), transfalltohex(L,L1) , printhex(L1).

solutionhex2(XS) :-  transfalltodec(XS,L1), bonnetaille(L1,16), verifiehex(L1),
transp(L1,YS), bonnetaille(YS,16), verifiehex(YS),
carres4(L1,ZS), verifiehex(ZS).



% Pour tester3 : grillehex(L), solutionhex3(L,L1) , printhex(L1).

solutionhex3(XS,R) :-  transfalltodec(XS,L1), bonnetaille(L1,16), verifiehex(L1),
transp(L1,YS), bonnetaille(YS,16), verifiehex(YS),
carres4(L1,ZS), verifiehex(ZS), transfalltohex(XS,R).


transftodec(a,0xa).
transftodec(b,0xb).
transftodec(c,0xc).
transftodec(d,0xd).
transftodec(e,0xe).
transftodec(f,0xf).

transftohex(10,a):- !.
transftohex(11,b):- !.
transftohex(12,c):- !.
transftohex(13,d):- !.
transftohex(14,e):- !.
transftohex(15,f):- !.
transftohex(X,X):- !.


valHex([0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f]).

isInValHex(V) :- valHex(XS), member(V,XS), !.
isInValHexTous([]).
isInValHexTous([X|XS]) :- isInValHex(X), isInValHexTous(XS), !.


printlinehex([]):- writeln('|').
printlinehex([X|XS]):- integer(X), write('|'), write(X), printlinehex(XS),!.
printlinehex([X|XS]):- atom(X), isInValHex(X), write('|'), write(X), printlinehex(XS),!.
printlinehex([_|XS]):- write('|'), write(' '), printlinehex(XS).

printhex([]).
printhex([X|XS]):- printlinehex(X), printhex(XS).

 

transflignetodec([],[]).
transflignetodec([X|XS],[X1|L]):- atom(X), isInValHex(X), transftodec(X,X1), transflignetodec(XS,L), !.
transflignetodec([X|XS],[X|L]):- transflignetodec(XS,L), !.

transfalltodec([],[]).
transfalltodec([X|XS],[X1|L]) :- transflignetodec(X,X1), transfalltodec(XS,L), !.


transflignetohex([],[]).
transflignetohex([X|XS],[X1|L]) :- transftohex(X,X1), transflignetohex(XS,L), !.

transfalltohex([],[]).
transfalltohex([X|XS],[X1|L]) :- transflignetohex(X,X1), transfalltohex(XS,L), !.


verifiehex([]).
verifiehex([X|XS]):- X ins 0..15, all_distinct(X), verifiehex(XS).

decoupe4([],[],[],[],[]).
decoupe4([X1|[X2|[X3|[X4|XS]]]],[Y1|[Y2|[Y3|[Y4|YS]]]],[Z1|[Z2|[Z3|[Z4|ZS]]]],[V1|[V2|[V3|[V4|VS]]]],[[X1|[X2|[X3|[X4|[Y1|[Y2|[Y3|[Y4|[Z1|[Z2|[Z3|[Z4|[V1|[V2|[V3|[V4]]]]]]]]]]]]]]]]|L]):- decoupe4(XS,YS,ZS,VS,L).

carres4([],[]).
carres4([X1|[X2|[X3|[X4|XS]]]],L3):- decoupe4(X1,X2,X3,X4,L), carres4(XS,L2), concatene(L,L2,L3).
