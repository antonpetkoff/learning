/*
sums(N, L) where L are all lists which have a sum of N non-zero integers
if N is 3
[3]
[2, 1]
[1, 2]
[1, 1, 1]

splits(L, M) generate all possible sequential partitions of L into non-empty sublists
if L is [1, 2, 3] then M can be
[[1, 2, 3]]
[[1, 2], [3]]
[[1], [2, 3]]
[[1], [2], [3]]

there is a reduction from one task to the other
notice that sums(N, L) generates the lengths of the partitions
*/

append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

%% Desi's attempt :)
%% append2(H, [H1|T1], M) :- append([[H]], [H1|T1], M).
%% append2(H, [H1|T1], M) :- append([H], H1, M1), append(M1, T1, M).
%% splits([], []).
%% splits([H | T], M) :- splits(T, [H1|T1]), append2(H, [H1|T1], M).

splits([], []).
%% splits(L, [H | M]) :- append(H, K, L), splits(K, M).    %% the head H could be an empty list!
splits(L, [H | M]) :- append(H, K, L), H \= [], splits(K, M).   %% we don't want to generate empty sublists!

between(A, A, B) :- A =< B.
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).

sums(0, []).
sums(N, [X | L]) :- between(X, 1, N), M is N - X, sums(M, L).

%% define a 6-argument predicate
%% p(X1, Y1, X2, Y2, X3, Y3) is true if
%% all 3 points construct a triangle with a 90 degrees angle at (X2, Y2)

%% how to generate 6-tuples?
%% generate some n(S)
%% generate 6 numbers between [0, S], [0, S - N1], [0, S - N1 - N2] ,...
%% use s(Z1), ... s(Z6) to generate 6 signs where
%% s(X, Y) generates the signed and unsigned integer Y of X.
s(X, X).
s(X, Y) :- X > 0, Y is -X.  %% we won't repeat the zero this way!

%% another approach is to use sums(S, [X1, ..., X6]) but we would have to
%% decrement by 1 each number because they are non-zero

%% another approach is to generate an n(X) and then decode it with
%% decode(X, X1, X2, X3, X4, X5, X6).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

%% d(D, L) where L is a list of sets, then D is the Cartesian product of all sets in L.
d([], []).
d([H | T], [HL | TL]) :- member(H, HL), d(T, TL).

%% p(X, Y) is true if the natural numbers X and Y have the same prime divisors
%% generator of a prime divisor?
