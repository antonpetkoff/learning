% y=dsolve('x*Dy -2*y = 2*x^4', 'x')
% y = dsolve('Dy+y*tg(x)=cos(x)^2', 'x')
y = dsolve('2*x*y*Dy=y^2-x^2', 'x')
simplify(y)