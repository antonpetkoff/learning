
member(X, [X | _]).
member(X, [_ | L]) :- member(X, L).

append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

len([], 0).
len([_ | T], Len) :- len(T, LenTail), Len is LenTail + 1.

sum([], 0).
sum([H | T], Sum) :- sum(T, SumTail), Sum is SumTail + H.

prefix(L, P) :- append(P, _, L).

suffix(L, S) :- append(_, S, L).

sublist(List, Sub) :- suffix(List, Suff), prefix(Suff, Sub).

subset([], []).
subset(L, [H | T]) :- suffix(L, [H | S]), subset(S, T).

remove(X, L, R) :- append(A, [X | B], L), append(A, B, R).

min2(A, B, A) :- A < B.
min2(A, B, B) :- not(A < B).

min([X], X).
min([H | T], M) :- min(T, TMin), min2(H, TMin, M).

%% selection sort
ssort([X], [X]).
ssort(L, [Min | Sorted]) :-
  min(L, Min),
  remove(Min, L, Rest),
  ssort(Rest, Sorted).

perm([], []).
perm(L, [Elem | Perm]) :- remove(Elem, L, Rest), perm(Rest, Perm).

splits([], []).
splits(L, [H | Splits]) :- append(H, Rest, L), H \= [], splits(Rest, Splits).

between(A, B, A) :- A =< B.
between(A, B, X) :- A < B, A1 is A + 1, between(A1, B, X).

sums(0, []).
sums(N, [X | Sums]) :- between(1, N, X), Rest is N - X, sums(Rest, Sums).
