%% Generators

%% Infinite generators

nat(0).
nat(X) :- nat(Y), X is Y + 1.

