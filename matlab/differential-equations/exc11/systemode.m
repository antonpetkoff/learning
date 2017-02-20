function systemode
clc; clf;

    function z = rhs(t, y)
        z = [y(2); -10 * y(1) - y(2)]; % vektor stalb
    end

x0 = 1; y0 = -1;
[T, Y] = ode45(@rhs, [0:0.01:5], [x0; y0]);
plot(T, Y(:, 1), T, Y(:, 2));

hold on;
grid on;

% global maximum of the second solution
t1 = 100; t2 = 200;
[M, tM] = max(Y(t1:t2, 2));
t = t1 + tM;    % we use an offset to find the elemend in Y
plot(T(t), Y(t, 2), 'mo');
plot(T(t), Y(t, 1), 'm*'); % infleksna tochka na parvoto reshenie

end