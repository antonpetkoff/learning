[x, y] = dsolve('Dx=y', 'Dy=-20*x-y', 'x(0)=1', 'y(0)=1')
t = -3:0.01:3;
plot(t, eval(x), t, eval(y))