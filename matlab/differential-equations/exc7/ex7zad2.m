% уравнение на Бесел
y = dsolve('x^2*D2y+x*Dy+(x^2-n^2)*y=0', 'x')
% y=c1*besselj(n, x)+c2*bessely(n, x)

x = 0:0.01:15;
plot(x, besselj(0, x), x, besselj(1, x), x, besselj(-1/2, x), x, besselj(1/2, x));