%% get the first element of a list
first(F, [F | _]).

%% second(S, [_, S | _]).
second(S, [_ | T]) :- first(S, T).

%% last(X, L)
%% note that the lines are swapped for performance
last(X, [_ | T]) :- last(X, T).
last(X, [X]).

%% just change the base for the second last
secondLast(X, [X, _]).
secondLast(X, [_ | T]) :- secondLast(X, T).

%% member(X, L)
%% member(X, [X | _]).
%% member(X, [_ | T]) :- member(X, T).

%% append(A, B, AB), append B to A to construct AB
append([], B, B).
append([H | A], B, [H | AB]) :- append(A, B, AB).

%% _ denotes that such a variable exists that the list L
%% is constructed (with append) in such
%% a way that X in some position
%% last(X, L) :- append(_, [X], L).
%% member(X, L) :- append(_, [X | _], L).

%% remove(X, L, NewList) - remove one occurence of X from list L and return NewList
%% like member but with removing the element
remove(X, [X | T], T).
remove(X, [H | T], [H | N]) :- remove(X, T, N).
%% notice how we reused the result of the next iteration of the recursion

%% member implemented with remove
%% does a such list exist with the element X removed from it?
member(X, L) :- remove(X, L, _).

add(X, L, N) :- remove(X, N, L).

%% generate all permutations of a list
perm([], []).
perm([H | P], L) :-
    remove(H, L, N),    %% get the rest
    perm(P, N).         %% permute the rest

%% less(X, Y). X is less than Y
less(X, Y) :- X < Y.

%% sorted(L).
%% sorted([]).
%% sorted([_]).
%% sorted([A, B | T]) :- less(A, B), sorted([B | T]).

%% sorted with Exists
sorted(L) :- not(
    append(_, [A, B | _], L),
    not(less(A, B))
).

%% task from exam:
%% X is a list of numbers
%% Y is a list of lists of numbers
%% define the 4 predicates:
%% p1(X, Y) := Съществува елемент на X, който е в елемент на Y.
%% p2(X, Y) := Съществува елемент на X, който е във всеки елемент на Y.
%% p3(X, Y) := Всеки елемент на X е в някой елемент на Y.
%% p4(X, Y) := Всеки елемент на X е във всеки елемент на Y.

%% ∃ A ∈ X ∃ B ∈ Y (A ∈ B)
p1(X, Y) :-
    member(A, X),   % take some element A from the first list
    member(B, Y),   % take some element B from the second list
    member(A, B).   % check if A is a member of B

%%    ∃ A ∈ X ∀ B ∈ Y (A ∈ B)
%% ≡ ∃ A ∈ X ¬∃ B ∈ Y ¬(A ∈ B)
p2(X, Y) :-
    member(A, X),   % take some element A from the first list
    not(
        member(B, Y),   % there doesn't exist an element B in Y
        not(member(A, B))   % and A is not a member of B
    ).

%%     ∀ A ∈ X ∃ B ∈ Y (A ∈ B)
%% ≡ ¬∃ A ∈ X ¬∃ B ∈ Y (A ∈ B)
p3(X, Y) :- not(
    member(A, X),
    not(member(B, Y)),
    member(A, B)
).

%%    ∀ A ∈ X ∀ B ∈ Y (A ∈ B)
%% ≡ ¬∃ A ∈ X ¬¬∃ B ∈ Y ¬(A ∈ B)
%% ≡ ¬∃ A ∈ X ∃ B ∈ Y ¬(A ∈ B)
p4(X, Y) :- not(
    member(A, X),
    member(B, Y),
    not(member(A, B))
).
