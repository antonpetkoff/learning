
member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

%% append(A, B, AB), append B to A to construct AB
append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

%% TODO:
% prefix(P, L) - is the list P a prefix of the list L
%% prefix([], L).
%% prefix([H | T], [H | T2]) :- prefix(T, T2).

% if we can append something _ to P which results in L
prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).

%% sublist(S, L) :- suffix(C, L), prefix(S, L).


%% TODO: swap the appends and see what happens
%% sublist(S, L) :- append(S, _, C), append(_, C, L).
% the first append has an infinite number of solutions and we will run out of stack
% if we swap the appends the first will be finite and thus the sublist predicate will be finite

%% this is correct
sublist(S, L) :- append(_, C, L), append(S, _, C).

%% subset(S, L)
%% first try. this infinitely grows
%% subset([], _).
%% subset([H | T], L) :- member(H, L), subset(T, L).
%% TODO: interpret with backtracking

%% second try (almost correct), this makes the arguments smaller
%% subset([], _).
%% subset(S, [H | T]) :- subset(S, T). % the head is not in the tail
%% subset([H | S], [H | T]) :- subset(S, T).   % the head is in the tail

%% this is correct
subset([], _).
subset([H | T], L) :- suffix([H | S], L), subset(T, S).

% issubset(S, L) - this predicate cannot generate!
% ∀x(x in S => x in L)
% ¬∃x ¬(¬ x in S or x in L)
% ¬∃x (x in S and ¬ x in L)
issubset(S, L) :- not((
    member(X, S),
    not(member(X, L))
)).

equal(A, B) :- issubset(A, B), issubset(B, A).

intersection(X, A, B) :- member(X, A), member(X, B).

union(X, A, _) :- member(X, A).
union(X, _, B) :- member(X, B).

difference(X, A, B) :- member(X, A), not(member(X, B)).

%% reverse(R, L) reverse list L to result into R
%% this relation is symmetric
%% this solution is very slow because of the append
%% reverse([], []).
%% reverse([H], [H]).
%% reverse(L, [H | T]) :- reverse(R, T), append(R, [H], L).

%% can we reverse the list with a stack?
%% we can remove the head from the list and push it to the reversed list as its new head
%% we use a helper function r
%% the first argument is the reversed, and the second argument is the initial list which
%% is empty after we have transferred it to the stack
r(S, [], S).  % the third argument is the result
r(S, [H | T], R) :- r([H | S], T, R).

reverse(R, L) :- r([], L, R).

%% min(M, [M]).
%% min(M, [H | T]) :- min(M, T), M < H.
%% min(H, [H | T]) :- min(M, T), M >= H.

min(M, [M]).
min(M, [H | T]) :- min(N, T), min2(M, N, H).
min2(A, A, B) :- A < B.
min2(B, A, B) :- not(A < B).

remove(X, [X | T], T).
remove(X, [H | T], [H | N]) :- remove(X, T, N).

%% Selection Sort, ssort(sorted, input_list)
ssort([], []).
ssort([M | S], L) :- min(M, L), remove(M, L, T), ssort(S, T).

%% QuickSort
%% split(L, X, A, B)

%% split([], X, A, B). % A and B are empty
split([], _, [], []). % A and B are empty
split([H | T], X, [H | A], B) :- H < X, split(T, X, A, B).
split([H | T], X, A, [H | B]) :- not(H < X), split(T, X, A, B).

qsort([], []).
qsort(S, [X | T]) :-
    split(T, X, A, B),
    qsort(SA, A),
    qsort(SB, B),
    append(SA, [X | SB], S).
