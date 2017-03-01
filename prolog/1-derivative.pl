
d(x, 1).
d(X, 0) :- number(X).
d(X + Y, DX + DY) :- d(X, DX), d(Y, DY).
d(X * Y, X * DY + Y * DX) :- d(X, DX), d(Y, DY).
%% d(sin(X), cos(X) * DX) :- d(X, DX).
d((X), (DX)) :- d(X, DX).
