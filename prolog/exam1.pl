%% task 1
%% p(L, X) generates in X a list of all lists in L
%% which are "visible" which means that all lists before
%% that "visible" list have a smaller length than it
%% L is a list of lists

%% length([], 0).
%% length([H | T], N) :- length(T, N1), N is N1 + 1.

longest(X, [X | _]).
longest(X, [H | T]) :-
    length(X, L1),
    length(H, L2),
    L1 > L2,
    longest(X, T).

p(_, [], []).
p(L, [H | T], [H | R]) :- longest(H, L), p(L, T, R).
p(L, [H | T], R) :- not(longest(H, L)), p(L, T, R).

p(L, X) :- p(L, L, X).

%% task 2
%% q(X, Y) generates in Y all lists from X which are
%% a concatenation of at least 2 lists in X (repetitions are allowed)

member(H, [H | _]).
member(X, [_ | T]) :- member(X, T).

append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

%% concat(S, L, K) :: S is a concatenation of K elements from L
concat([], _, 0).
concat(S, L, K) :-
    member(X, L),
    append(X, R, S),
    concat(R, L, K1),
    K is K1 + 1.

q(L, X) :- member(X, L), concat(X, L, N), N > 1.

%% task 2-2 (analogous to the previous task)
%% r(L, N) generates all numbers N from L which
%% are formed by the sum of at least 2 numbers in L

sum(0, _, 0).
sum(S, L, K) :-
    member(X, L),
    R is S - X,
    R >= 0,
    sum(R, L, K1),
    K is K1 + 1.

r(L, N) :- member(X, L), sum(X, L, N), N > 1.
