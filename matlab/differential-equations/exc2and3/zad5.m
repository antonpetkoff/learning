function zad5
    % da minava prez (1, 0.5), (1, 1), (1, 2), (-1, -0.5), (-1, -1), (-1, -2)
    y = dsolve('Dy = (y/x)*(1+log(y/x))', 'y(1) = 1', 'x')
    x = 0:0.01:5;
    axis([-5, 5, -5, 5]);
    hold on;
    plot(x, eval(y));
    grid on;
end