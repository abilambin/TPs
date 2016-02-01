% Premiere salle

% Q1
contenu(tigre).
contenu(princesse).

% Q2
pancarte1(tigre,_).
pancarte1(_,princesse).

pancarte2(princesse,_).

% Q3
salle1(X,Y) :- pancarte1(X,Y), pancarte2(X,Y).
salle1(X,Y) :- contenu(X), contenu(Y), not(pancarte1(X,Y)), not(pancarte2(X,Y)).


/*
Q4
Solution :
Il y a une princesse derriere chacune des deux portes
salle1(Y,X).
Y = X, X = princesse .

[trace]  ?- salle1(X,Y).
 Call: (6) salle1(_G2723, _G2724) ? creep
 Call: (7) pancarte1(_G2723, _G2724) ? creep
 Exit: (7) pancarte1(tigre, _G2724) ? creep
 Call: (7) pancarte2(tigre, _G2724) ? creep
 Fail: (7) pancarte2(tigre, _G2724) ? creep
 Redo: (7) pancarte1(_G2723, _G2724) ? creep
 Exit: (7) pancarte1(_G2723, prQuelle pancarte disait la vérité ?incesse) ? creep
 Call: (7) pancarte2(_G2723, princesse) ? creep
 Exit: (7) pancarte2(princesse, princesse) ? creep
 Exit: (6) salle1(princesse, princesse) ? creep
 X = Y, Y = princesse .


 Q5 : Arbre decisionnel


 Deuxieme salle

 Q6 */
pancarte3(princesse,tigre).
pancarte4(princesse, tigre).
pancarte4(tigre,princesse).

salle2(X,Y) :- contenu(X), contenu(Y), pancarte3(X,Y), not(pancarte4(X,Y)).
salle2(X,Y) :- contenu(X), contenu(Y), pancarte4(X,Y), not(pancarte3(X,Y)).

/*
Q7
Il y a un tigre derriere la porte 1
et une princesse derriere la porte 2.

?- salle2(X,Y).
X = tigre,
Y = princesse ;

Q8 : Arbre decisonnel

Q9
La seconde pancarte disait la verité, la premiere mentait.

Q10 */
affiche1 :- salle1(X,Y), write('Salle 1 :\n Porte 1 : '), write(X),
			   write('\n Porte 2 : '), write(Y).
affiche2 :- salle2(X,Y), write('Salle 2 :\n Porte 1 : '), write(X),
			   write('\n Porte 2 : '), write(Y).

