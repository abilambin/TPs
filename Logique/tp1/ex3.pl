contenu(tigre).
contenu(princesse).
contenu(vide).


% Troisieme salle

% Q11

pancarte5(_,_,vide).
pancarte6(tigre,_,_).
pancarte7(_,_,vide).

porte1(princesse,Y,Z) :- contenu(Y), contenu(Z), pancarte5(princesse,Y,Z).
porte1(tigre,Y,Z) :- contenu(Y), contenu(Z), not(pancarte5(tigre,Y,Z)).
porte1(vide,Y,Z) :- contenu(Y), contenu(Z), pancarte5(vide,Y,Z).
porte1(vide,Y,Z) :- contenu(Y), contenu(Z), not(pancarte5(vide,Y,Z)).

porte2(X,princesse,Z) :- contenu(X), contenu(Z), pancarte6(X,princesse,Z).
porte2(X,tigre,Z) :- contenu(X), contenu(Z), not(pancarte6(X,tigre,Z)).
porte2(X,vide,Z) :- contenu(X), contenu(Z), pancarte6(X,vide,Z).
porte2(X,vide,Z) :- contenu(X), contenu(Z), not(pancarte6(X,vide,Z)).

porte3(X,Y,princesse) :- contenu(X), contenu(Y), pancarte7(X,Y,princesse).
porte3(X,Y,tigre) :- contenu(X), contenu(Y), not(pancarte7(X,Y,tigre)).
porte3(X,Y,vide) :- contenu(X), contenu(Y), pancarte7(X,Y,vide).
porte3(X,Y,vide):- contenu(X), contenu(Y), not(pancarte7(X,Y,vide)).

% Q12

salle3(X,Y,Z) :- porte1(X,Y,Z), porte2(X,Y,Z), porte3(X,Y,Z), not(X=Y), not(X=Z), not(Y=Z).

affiche3 :- salle3(X,Y,Z), write('Salle 3 :\n Porte 1 : '), write(X),
			   write('\n Porte 2 : '), write(Y),
			   write('\n Porte 3 : '), write(Z).
/*
% Q13
?- salle3(X,Y,Z).
X = princesse,
Y = tigre,
Z = vide ;


% Q14 : Arbre decisionnel
*/
