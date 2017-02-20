function phaseportret
clc; clf;

tmax = 50;
A = [3, 1; 4, 3]; b = [-3;, -4];

eqp = A \ (-b) % 1) namirame ravnovesnoto polojenie
plot(eqp(1), eqp(2), 'm*')
hold on;
[T, D] = eig(A); % 2) sobstveni vektori (stalbovete na T) i sobstveni stoinosti (diagonala na D)

if imag(D(1, 1)) == 0   % ako imaginernata chast na parvata sobstv. stoinost e == 0
    xx = -10:1:10;
    for j=1:2
        if T(1, 1) ~= 0
            plot(xx + eqp(1), T(2, j)/T(1, j) * xx + eqp(2), 'k');
        else
            plot(0 * xx + eqp(1), xx, 'k');
        end
    end
end

% dva vektora okolo ravnovesnata tochka
x = eqp(1)-4:1:eqp(1)+4;
y = eqp(2)-4:1:eqp(2)+4;
axis([eqp(1) - 5, eqp(1) + 5, eqp(2) - 5, eqp(2) + 5]);
[X, Y] = meshgrid(x, y);
for i=1:length(x)
    for k=1:length(y)
        [T, Z] = ode45(@rhs, [0, tmax], [X(i, k), Y(i, k)]);
        [T1, Z1] = ode45(@rhs, [0, -tmax], [X(i, k), Y(i, k)]);
        plot(Z(:, 1), Z(:, 2), 'b', Z1(:, 1), Z1(:, 2), 'b');
    end
end

    function z = rhs(t, y)
        z = A * y + b;
    end

x1 = A(1, 1)*X + A(1, 2)*Y + b(1);
y1 = A(2, 1)*X + A(2, 2)*Y + b(2);
d = sqrt(x1.^2 + y1.^2);
quiver(X, Y, x1./d, y1./d, 0.5, 'g')

% smqtame tangencionalnite vektori s quiver()


end