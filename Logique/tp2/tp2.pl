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

% Q8
retourne([],[],[]).
retourne([X],YS,[X|YS]).
retourne([X|XS],YS,A) :- retourne(XS,[X|YS],A).

% Q9
insert_trie(N,[],[N]).
insert_trie(N,[X|XS],[N|[X|XS]]) :- N<X, !.
insert_trie(N,[X|XS],[X|L]) :- insert_trie(N,XS,L).

% Q10
tri_insert([X],[X]).
tri_insert([X|XS],L):- tri_insert(XS,L2), insert_trie(X,L2,L).

% Q11
divise([],[],[]).
divise([X],[X],[]).
divise([X|[Y|XS]],[X|L],[Y|L2]) :- divise(XS,L,L2).

% Q12
fusion(XS,[],XS).
fusion([],YS,YS).
fusion([X|XS],[Y|YS],[X|L]) :- X<Y, fusion(XS,[Y|YS],L).
fusion([X|XS],[Y|YS],[Y|L]) :- fusion([X|XS],YS,L).

% Q13
tri_fusion([X],[X]).
tri_fusion(ZS,L):- divise(ZS,XS,YS), tri_fusion(XS,P), tri_fusion(YS,P2), fusion(P,P2,L), !.

% Q14
balance(_,[],[],[]):- !.
balance(X,[Y|YS],[Y|L1],L2) :- Y<X, balance(X,YS,L1,L2),!.
balance(X,[Y|YS],L1,[Y|L2]) :- balance(X,YS,L1,L2),!.

% Q15
tri_rapide([],[]).
tri_rapide([X],[X]):- !.
tri_rapide([X|XS],L) :- balance(X,XS,L1,L2), tri_rapide(L1,L3), tri_rapide(L2,L4), concatene(L3,[X|L4],L).

% Q16
est_vide([]).

% Q17
ajoute_ensemble(X,[],[X]).
ajoute_ensemble(X,[Y|YS],[Y|YS]):- X=Y.
ajoute_ensemble(X,[Y|YS],[Y|L]):- ajoute_ensemble(X,YS,L).


