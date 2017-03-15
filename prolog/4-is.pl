%% Prolog assignment (is keyword): X is Y + Z
%% evaluates to true in 2 cases:
%% 1) when X is empty, then X becomes Y + Z
%% 2) when X is not empty and is equal to Y + Z
%% Thus, there are no side effects, because X becomes Y + Z only when X has no value.

%% e.g. the expression (X is 5, X is 6) evaluates to false

%% length(L, N)... N is the length of list L
len([], 0).
len([_ | T], N) :- len(T, Ntail), N is 1 + Ntail.

sum([], 0).
sum([H | T], S) :- sum(T, Stail), S is H + Stail.

%% once again...
%% member(X, N, L)... X is the Nth element in L.
member(X, 0, [X | _]).
%% expressed in the terms of list construction
%% we know the index of element X in the tail, so we add 1 to offset the head _
member(X, N, [_ | T]) :- member(X, IndexInTail, T), N is 1 + IndexInTail.
%% member(X, N, [_ | T]) :- N1 is N - 1, member(X, N1, T).  % this ain't correct
