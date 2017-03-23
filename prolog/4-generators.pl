%% Generators

%% Infinite generators

n(0).
n(X) :- n(Y), X is Y + 1.

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
z(Y) :- n(X), s(Z), Y is X * Z.
%% z(X) :- n(X), member(Y, [1, -1]), Y is X * Y.  % is the same

%% TODO: another approach is to encode/decode the integers as natural numbers
%% z(X) :- n(Y), decode(Y, X).


%% part 2

n100(X) :- n(X), X < 100.   %% generates all naturals up to 100, but then it loops

%% finite generator
%% between(X, A, B) :: generate all integers X in [A, B]
%% interpret the interval as a list which has a head and a tail
between(A, A, B) :- A =< B.
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).
%% TODO: you cannot pass A + 1 instead of A1 in standard Prolog

%% tuple generator
%% idea: generate all tuples with sum 0, with sum 1, 2, 3 ...

%% n(X, Y) :- n(X), n(Y). this won't work, because it will generate (0, 1), (0, 2)...
%% think of n(X) as an infinite loop and n(Y) as a nested infinite loop

n(X, Y) :- n(S), between(X, 0, S), Y is S - X.

%% p(X) generates all naturals less than 1000 which are the sum of squares of 4 numbers

p(X) :-
    between(X1, 0, 32),
    between(X2, 0, 32),
    between(X3, 0, 32),
    between(X4, 0, 32),
    X is X1 * X1 + X2 * X2 + X3 * X3 + X4 * X4,
    X < 1000.
%% https://en.wikipedia.org/wiki/Lagrange's_four-square_theorem
%% each natural can be represented as a sum of squares of 4 naturals


