function zad3
    y = dsolve('y*Dy = -x', 'y(1) = 1', 'x');
    x = -sqrt(2):0.01:sqrt(2);
    plot(x, eval(y));
    axis([-4, 4, -4, 4])
end