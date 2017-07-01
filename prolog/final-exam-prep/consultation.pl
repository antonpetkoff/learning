% gcd(A, B, D) := D is the greatest common divisor of A and B
gcd(A, A, A).
gcd(A, B, N) :- A > B, A1 is A - B, gcd(A1, B, N).
gcd(A, B, N) :- not(A > B), B1 is B - A, gcd(A, B1, N).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

len([], 0).
len([_ | Xs], N) :- len(Xs, N1), N is 1 + N1.

append([], B, B).
append([HA | A], B, [HA | AB]) :- append(A, B, AB).

remove(X, List, Rest) :- append(A, [X | B], List), append(A, B, Rest).

subset([], []).
subset([X | Xs], [X | S]) :- subset(Xs, S).
subset([_ | Xs], S) :- subset(Xs, S).

% gcd(L, N) := is the greatest common divisor of all numbers in L
gcd([N], N).
gcd([H | T], N) :- gcd(T, Rest), gcd(H, Rest, N).

%% p(L, N) :- ∃ a1, ..., aN ∈ N: ...
p(L, N) :-
  N > 1,
  subset(L, S1), len(S1, N),
  N1 is N - 1,
  not((
    subset(L, S2), len(S2, N1),
    gcd(S1, G1), gcd(S2, G2), G1 =:= G2
  )).
