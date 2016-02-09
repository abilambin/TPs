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
carres([],[]).
carres([X1|[X2|[X3]]],L):- decoupe(X1,X2,X3,L).
  
% Q10
% TODO
solution(XS) :- bonnetaille(XS,9), verifie(XS).

























