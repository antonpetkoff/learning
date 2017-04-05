
append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

list([]).
list([_ | _]).
%% list([_]) matches only a list with one element!

%% flatten list
%% [[[1, 2], [3]], [[4]]]
%% put the leafs into [1, 2, 3, 4]

%% flatten(L, F).
flatten([], []).
flatten([H | T], F) :-
    list(H),    %% is H a list?
    flatten(H, HF), %% then flatten H
    flatten(T, TF), %% we flatten T for sure
    append(HF, TF, F).  %% concatenate them together
flatten([H | T], [H | TF]) :-
    not(list(H)),   %% this is necessary, without
    flatten(T, TF).

%% predicate Cut
%% p :- a, b, !, c, d.
%% p :- e.
%% ?- p with some arguments
%% you can backtrack from c to d, but you won't backtrack from c to b
%% and also Prolog won't reach the next definition for p.
%% ! is uni-directional, i.e. allows execution to flow to right, but not to left

%% defining not(predicate)
%% not(A) :- call(A), !, fail. %% if call(A) is true, then not(A) will (fail) be false
%% not(A). %% when A is false, then not(A) is true

%% homework
%% generate all trees which have some given list L = [1, 2, 3, 4] as leaves

%% task 2
%% [1, 1, 1, 2, 2, 3, 3, 5]
%% [[1, 1, 1], [2, 2], [3, 3], [5]]
%% i.e. package together adjacent equal elements into a list

%% c(L, M). - cluster
c([], []).
c([A], [[A]]).

%% The Cluster is generated from A and T
c([A, A | T], [[A | ClusterA] | RestClusters]) :-
    c([A | T], [ClusterA | RestClusters]).

%% Rest will be generated from B and T
c([B, A | T], [[B] | RestClusters]) :-
    A \= B,
    c([A | T], RestClusters).


%% task 3
between(A, A, B) :- A =< B.
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).

div(A, B) :- B mod A =:= 0.  %% A is a divisor of B

prime(X) :- X > 1, X1 is X - 1, not((
    between(Y, 2, X1), div(Y, X)
)).

%% pd(X, A) generate all prime divisors of A into X
pd(X, A) :- between(X, 2, A), div(X, A), prime(X).
%% A's divisors can be between 2 and A, let's call them X
%% X must divide A
%% and X must be prime

%% p(A, B) true if A and B have the same prime divisors
%% p(A, B) :- pd(X, A), pd(Y, B), X is Y.


%% ∀x(pd(X, A) ⟹ div(X, B))
%% ¬∃x ¬(pd(X, A) ⟹ div(X, B))
%% ¬∃x (pd(X, A) and ¬div(X, B))
phelp(A, B) :- not((
    pd(X, A),
    not(div(X, B))
)).

p(A, B) :- phelp(A, B), phelp(B, A).


%% task 4 from a exam 2016, 16th of April
%% Generate all lists [X1, ..., Xn]
%% where ∀i from 1 to n: Xi is a list and has elements from [0, 99]
%% and Xi = prefix(Xi + 1)

n(0).
n(X) :- n(Y), X is Y + 1.

n(X, Y) :- n(S), between(X, 0, S), Y is S - X.

prefix(P, L) :- append(P, _, L).

%% generate all lists with naturals between 0 and 99
p99([]).
p99([H | T]) :- p99(T), between(H, 0, 99).

%% pl(L, 1) :- p99(L).
%% pl([H | T], N) :- N > 1, pl([S | T]) p99(H), prefix(H, S).

p99([], 0).
p99([H | T], N) :- N > 0, N1 is N - 1, p99(T, N1), between(H, 0, 99).

pl([]).
pl(L) :- n(M, N), p99(X, N), q(X, M, L).

q(X, 1, [X]).
q(X, N, [A | T]) :-
    N > 1,
    N1 is N - 1,
    q(X, N1, T),
    T = [B | _],
    prefix(A, B).

