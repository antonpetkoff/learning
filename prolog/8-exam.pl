%% group 2
%% task 1
%% p(L, X) generate all X which are elements of L
%% and their predecesors have a smaller length than X
%% solution: just write it down formally

p1(L, X) :-
    append(A, [X | _], L),  %% A is the prefix before element X
    length(X, N),   %% find the length of X
    not((   %% ¬∃ Y ∈ A: len(Y) > len(X)
        member(Y, A),   %% generate all members Y of A
        length(Y, M),   %% take the length of Y
        M > N   %% and compare the lengths
    )).

%% TODO: now generate a list of all such "visible" elements in X

%% task 2
%% p2(X, N), X is a list of naturals, N is the sum of X's elements
q(0, _, 0).
q(N, L, K) :-   %% K counts how many numbers we need to form a sum N
                %% because we want K to be at least 2
    member(X, L),   %% take any element X from L
    X =< N, %% ensure that X doesn't overflow the sum N
    M is N - X, %% subtract X from the sum N
    q(M, L, K1),    %% generate the rest of the possible sums by decrementing M
    K is K1 + 1.    %% increment K, because we have used another number in the sum

p2(L, X) :-
    member(X, L),
    q(X, L, N),
    N >= 2. %% we want sums with at least 2 numbers from L

%% the solution for group 1 task 2 is analogous, but with append, instead of subtraction

q2([], _, 0).
q2(S, L, K) :-   %% S is a list
    member(X, L),   %% take any element X from L
    append(X, Y, S),
    q(Y, L, K1),
    K is K1 + 1.    %% K counts how many elements we have used

