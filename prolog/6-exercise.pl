
between(A, A, B) :- A =< B.
between(X, A, B) :- A < B, A1 is A + 1, between(X, A1, B).

%% generator
inrect(X, Y, X1, Y1, X2, Y2) :-
    between(X, X1, X2), between(Y, Y1, Y2).

%% filter
incircle(X, Y, X1, Y1, R) :-
    (X - X1) * (X - X1) + (Y - Y1) * (Y - Y1) =< R * R.

%% task 1
p(X, Y, X1, Y1, R, X2, Y2, X3, Y3) :-
    inrect(X, Y, X2, Y2, X3, Y3),
    incircle(X, Y, X1, Y1, R).


%% task 2
%% [] is a binary tree
%% if A and B are binary trees, then [A, B] is a binary tree
%% t(T) generates all binary trees T
%% note: we only have the structure, but no labels of the vertices
%% an empty leaf is just [[],[]]
%% [[[], []], []] is a root with a left leaf and no right child

%% 40% of the solutions followed the definition and were incorrect
%% t([]).
%% t([A, B]) :- t(A), t(B).
%% but this is incorrect because we have 2 infinite generators
%% and t(A) will never be satisfied,
%% it would generate only the first solution for A
%% i.e. this generator cannot walk left

%% rather take the idea from generating tuples - (1, N-1), (2, N-2)
%% where the 2 items in the tuple always sum to N
%% thus we could generate all trees with total height 1, 2, 3, ..., K

n(0).
n(X) :- n(Y), X is Y + 1.

%% vertex_count(A) + vertex_count(B) + 1 = N
t([], 0).
t([A, B], N) :- %% TODO: if you use [A | B], instead of [A, B], you will generate n-ary trees
    N > 0,
    N1 is N - 1,    %% remove the root
    between(NA, 0, N1), %% let NA = vertex_count(A)
    NB is N1 - NA,  %% NB is the rest
        %% thus, we solved the equation NA + NB + 1 = N
    t(A, NA),
    t(B, NB).
t(T) :- n(N), t(T, N).  %% the second argument of `t` is the number of vertices


%% task 3
%% s(M, L) is a generator where:
%% M are all lists which have elements from L
%% there could be repetitions of elements

%% a wrong solution which infinitely repeats the first element
%% s([], _).
%% s([H | T], L) :- member(H, L), s(T, L).

%% we have the freedom to fix the length of the generated list
%% also we can decide what is the order

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

%% s(M, L) :- n(N), s(N, M, L).
%% %% s(N, M, L) :- M has N elements from L
%% s(0, [], _).
%% s(N, [H | T], L) :-
%%     N > 0,
%%     N1 is N - 1,
%%     member(H, L),
%%     s(N1, T, L).

%% even a simpler solution
s([], _).
s([H | T], L) :- s(T, L), member(H, L).
%% note: member is finite
%% this way T gets over-satisfied with the base solution []
%% then it gets over-satisfied with [1] and [2]
%% then with [1, 1], [2, 1], [1, 2], [2, 2] and so on...
%% we just reuse what was previously generated

%% homework, like task 2
%% [] is a tree
%% a list of tree is a tree
%% generate all trees

