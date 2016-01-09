
% Premiere salle


contenu(tigre).
contenu(princesse).

pancarte1(tigre,_).
pancarte1(_,princesse).

pancarte2(princesse,_).

salle1(X,Y) :- pancarte1(X,Y), pancarte2(X,Y).
salle1(X,Y) :- contenu(X), contenu(Y), not(pancarte1(X,Y)), not(pancarte2(X,Y)).

% Solution :
% Il y a une princesse derriere chacune des deux portes
% salle1(Y,X).
% Y = X, X = princesse .

%[trace]  ?- salle1(X,Y).
%   Call: (6) salle1(_G2723, _G2724) ? creep
%   Call: (7) pancarte1(_G2723, _G2724) ? creep
%   Exit: (7) pancarte1(tigre, _G2724) ? creep
%   Call: (7) pancarte2(tigre, _G2724) ? creep
%   Fail: (7) pancarte2(tigre, _G2724) ? creep
%   Redo: (7) pancarte1(_G2723, _G2724) ? creep
%   Exit: (7) pancarte1(_G2723, princesse) ? creep
%   Call: (7) pancarte2(_G2723, princesse) ? creep
%   Exit: (7) pancarte2(princesse, princesse) ? creep
%   Exit: (6) salle1(princesse, princesse) ? creep
% X = Y, Y = princesse .


% Arbre decisionnel à finir


% Deuxieme salle

pancarte3(tigre,princesse).
pancarte4(princesse, tigre).

salle2(X,Y) :- contenu(X), contenu(Y), pancarte3(X,Y), not(pancarte4(X,Y)).
salle2(X,Y) :- contenu(X), contenu(Y), pancarte4(X,Y), not(pancarte3(X,Y)).
