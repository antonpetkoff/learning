%% Generators

%% Infinite generators

nat(0).
nat(X) :- nat(Y), X is Y + 1.

even(0).
even(X) :- even(Y), X is Y + 2.

fib(0, 1).  % two adjacent Fibonacci values
%% X, Y
%% newX is Y, newY is X + Y
fib(Y, Z) :- fib(X, Y), Z is X + Y.
fib(X) :- fib(X, _).  % we take the first (left) projection of the relation f

%% a_0 = a_1 = a_2 = 1
%% a_n + 3 = 2 * a_(n + 2) + a_n

%% positional input    X, Y, Z
%% positional output   Y, Z, T = 2Z + X
p(1, 1, 1).
p(Y, Z, T) :- p(X, Y, Z), T is 2 * Z + X.
p(X) :- p(X, _, _).


%% Generate all integers: 0, 1, -1, 2, -2, 3, -3, ...

s(1).
s(-1).

z(0).
%% z(X) :- z(Y), X is Y + 1.
%% z(X) :- z(Y), X is Y - 1.    % this definition will never be reached!
z(X) :- nat(X), s(Z), Y is X * Z.
%% z(X) :- nat(X), member(Y, [1, -1]), Y is X * Y.  % is the same

%% TODO: another approach is to encode/decode the integers as natural numbers
%% z(X) :- nat(Y), decode(Y, X).
