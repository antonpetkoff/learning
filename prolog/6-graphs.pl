
%% graph = [V, E]
%% V = list of vertices
%% E = list of edges
%% where edge = [A, B], A -> B

%% predicates:
%% connected(G)
%% spantree(G, T) - create a spanning tree

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

r(S, [], S).  % the third argument is the result
r(S, [H | T], R) :- r([H | S], T, R).
reverse(R, L) :- r([], L, R).

%% edge(G, A, B)
edge([_, E], A, B) :- member([A, B], E).
edge([_, E], A, B) :- member([B, A], E).    %% if G is undirected

dfs(X) :- goal(X).  %% is the goal reached?
dfs(X) :- edge(X, Y), dfs(Y).

%% path(G, X, Y, P) - generate the path P in graph G between vertices X and Y

%% but we have to ignore the cycles!
%% so we define a helper function where V1 is a list of visited vertices
%% path(G, X, Y, V1, P)

path(_, X, X, V1, V1).  %% the path is just all the visited vertices V1
path(G, X, Y, V1, P) :-
    edge(G, X, Z),  %% visit a neighbour Z of X
    not(member(Z, V1)), %% where Z is not already visited
    path(G, Z, Y, [X | V1], P). %% mark X as visited and find the rest of the path
    %% we take the path P when we reach the goal Y

%% path(G, X, Y, P) :- path(G, X, Y, [], P).
%% note: the returned path is reversed and doesn't include the target Y

path(G, X, Y, Q) :- path(G, X, Y, [], P), reverse(Q, [Y | P]).

%% test with:
%% path([[x, a, b, c, y], [[x, a], [a, b], [b, y], [a, c], [c, b]]], x, y, P)

%% ∀X∀Y∃P: path(G, X, Y, P) is ok, but Prolog doesn't like ∀
%% ¬(∃X∃Y¬∃P: path(G, X, Y, P)) :: it is not true that G is not connected

connected([V, E]) :- not((
    member(X, V),
    member(Y, V),
    not(path([V, E], X, Y, _))
)).
