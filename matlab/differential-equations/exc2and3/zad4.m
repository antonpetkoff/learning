function zad4
    y = dsolve('Dy = 3*y^(2/3)', 'y(x0) = y0', 'x');
    x = -5:0.01:5;
    axis([-5, 5, -5, 5]);
    [x0, y0] = ginput(1);
    plot(x, eval(y(1)), x, eval(y(2)));
    grid on;
end