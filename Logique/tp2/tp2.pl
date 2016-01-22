% Q1
longueur([],0).
longueur([_|XS],L) :- longueur(XS,L2), L is L2 + 1.

% Q2
somme([],0).
somme([X|XS],L) :- somme(XS,L2), L is L2 + X.

% Q3
membre(N,[X|_]) :- N==X, !.
membre(N,[_|XS]) :- membre(N,XS).

% Q4
ajoute_en_tete(N,[],[N]).
ajoute_en_tete(N,XS,[N|XS]).

% Q5
ajoute_en_queue(N,[],[N]).
ajoute_en_queue(N,[X|XS],[X|L]) :- ajoute_en_queue(N,XS,L).

% Q6
extraire_tete2([X|[]],X, []).
extraire_tete2([X|XS],X, XS).

extraire_tete(XS,N,L) :- ajoute_en_tete(N,L,XS).

% Q7
concatene([],YS,YS).
concatene([X|XS],YS,[X|L]) :- concatene(XS,YS,L).

