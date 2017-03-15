%% binary ordered tree with terms
%% e is the empty tree term
%% t(L, T, R) is a term which represents the tree with root T

%% tsort(S, L)... sort list L as list S
%% maketree(L, T)... make tree T from list L
%% ltr(T, L) - left, root, right traversal (inorder)
%% add(X, T, N)... add element X to tree T and return the new tree N

tsort(S, L) :- maketree(L, T), ltr(T, S).

maketree([], e).
%% we assume that the rest of the list (L) is already a tree
%% and just insert the head (H) into it
maketree([H | L], T) :- maketree(L, T1), add(H, T1, T).

add(X, e, t(e, X, e)).
%% either L or R will be modified => 2 cases
add(X, t(L, T, R), t(L1, T, R)) :- not(X > T), add(X, L, L1).
add(X, t(L, T, R), t(L, T, R1)) :- X > T, add(X, R, R1).

ltr(e, []).
ltr(t(L, T, R), S) :-
    ltr(L, SL), % in order traversal of the left subtree
    ltr(R, SR), % in order traversal of the right subtree
    append(SL, [T | SR], S).    % construct
