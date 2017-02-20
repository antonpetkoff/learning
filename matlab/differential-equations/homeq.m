function homeq
clc
axis([-8, 8, -8, 8]);
hold on;
grid on;
[x0, y0] = ginput(1);
plot(x0, y0, 'm*');
if x0 * y0 < 0
    text(x0 + 0.1, y0, 'no solution');
else
    y = dsolve('Dy=y*(1+log(y/x))/x', 'y(x0)=y0', 'x');
    x = -8:0.1:8;
    plot(x, eval(y));
end
end