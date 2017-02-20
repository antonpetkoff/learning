function nonLinearPhasePortret
clc; clf;
tmax = 3;
a = 0.1;

    function z = rhs(t, y)
        z = [-y(2) + a * y(1)^2; y(1) + a * y(2)^3];
    end

%k = 1; % lineino priblijenie focus
k = 2; % lineino priblijenie - sedlo

J = [0, -1; 1, 0];
ak = 0; bk = 0;

    function z = Lrhs(t, y)
        z = J * (y - [ak; bk]);
    end

x = ak - 5 : 1 : ak + 5;
y = bk - 5 : 1 : bk + 5;
[X, Y] = meshgrid(x, y);
for i = 1:length(X)
    for j = 1:length(Y)
        [T, Z] = ode45(@rhs, [0, tmax], [X(i, j), Y(i, j)]);
        [T1, Z1] = ode45(@rhs, [0, -tmax], [X(i, j), Y(i, j)]);
        [T2, L] = ode45(@Lrhs, [0, tmax], [X(i, j), Y(i, j)]);
        [T3, L1] = ode45(@Lrhs, [0, -tmax], [X(i, j), Y(i, j)]);

        % phase portret 1
        subplot(2, 1, 1);
        plot(ak, bk, 'm*', ak-pi, bk, 'm*', ak+pi, bk, 'm*');
        hold on;
        plot(Z(:, 1), Z(:, 2), Z1(:, 1), Z1(:, 2), 'b');
        axis([ak-6, ak+6, bk-6, bk+6]);

        % phase portret 2
        subplot(2, 1, 2);
        hold on;
        plot(L(:, 1), L(:, 2), L1(:, 1), L1(:, 2), 'b');
        axis([ak-6, ak+6, bk-6, bk+6]);
    end
end

% vektorno pole
X1 = -Y + a*X.^2; Y1 = X + a*Y.^2;
D1 = sqrt(X1.^2 + Y1.^2);
subplot(2, 1, 1);
quiver(X, Y, X1./D1, Y1./D1);

X2 = J(1, 1) * (X - ak) + J(1, 2) * (Y - bk);
Y2 = J(2, 1) * (X - ak) + J(2, 2) * (Y - bk);
D2 = sqrt(X2.^2 + Y2.^2);
subplot(2, 1, 2);
quiver(X, Y, X2./D2, Y2./D2, 0.5, 'r');

end