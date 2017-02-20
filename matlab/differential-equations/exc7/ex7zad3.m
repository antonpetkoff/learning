% реш. зад на коши
% y = dsolve('D3y+4*D2y+13*Dy=0', 'Dy(-1)=13', 'D2y(-1)=0', 'x')
y = simplify(dsolve('D2y+3*Dy+2*y=1/(1-exp(x))+12*exp(x)', 'x'))

% уравнение на Ойлер
y = dsolve('x^2*D2y')