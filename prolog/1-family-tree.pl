likes(alice, bob).
likes(bob, carol).
likes(james, mary).
likes(mary, james).
likes(mary, jane).
love_compatible(X, Y) :- likes(X, Y), likes(Y, X).

father(shefket, ali).
father(ali, kuzei).
father(ali, dingo).

mother(hairie, fikret).
mother(fikret, kuzei).
mother(fikret, dingo).
mother(ali, sedef).

parent(X, Y) :- mother(X, Y).
parent(X, Y) :- father(X, Y).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

sibling(X, Y) :- parent(Z, X), parent(Z, Y), not(X = Y).

cousin(X, Y) :- grandparent(Z, X), grandparent(Z, Y), not(X = Y).

descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Z, X), descendant(Z, Y).
