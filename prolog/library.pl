
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

between(A, A, B) :- A =< B. %% TODO: why doesn't it work when there isn't A =< B?
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).

sums(0, []).
sums(N, [H | T]) :- between(H, 1, N), Nrest is N - H, sums(Nrest, T).
