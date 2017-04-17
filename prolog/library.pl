
member(X, [X | _]).
member(X, [_ | L]) :- member(X, L).

append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

len([], 0).
len([_ | T], Len) :- len(T, LenTail), Len is LenTail + 1.

sum([], 0).
sum([H | T], Sum) :- sum(T, SumTail), Sum is SumTail + H.

splits([], []).
splits(L, [H | M]) :- append(H, T, L), H \= [], splits(T, M).

between(A, A, B) :- A =< B. %% Ensure that the input is correct
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).

sums(0, []).
sums(N, [H | T]) :- between(H, 1, N), Nrest is N - H, sums(Nrest, T).

out(L, X, R) :- append(H, [X | T], L), append(H, T, R).

perm([], []).
perm(L, [X | P]) :- out(L, X, Rest), perm(Rest, P).

prefix(L, P) :- append(P, _, L).

suffix(L, S) :- append(_, S, L).

sublist(List, Sub) :- suffix(List, Suff), prefix(Suff, Sub).

subset([], []).
subset(L, [H | T]) :- suffix(L, [H | S]), subset(S, T).
