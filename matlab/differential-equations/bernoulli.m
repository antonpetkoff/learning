function bernoulli
clc;
y=dsolve('3*x*Dy+4*x^5*y^4=2*y', 'y(1)=1/2', 'x');
x=0.5:0.01:6;
plot(x, eval(y), 'k');
hold on;

dy = diff(y);
a = solve(dy);
x = a(1);
plot(x, eval(y), 'mo');

d2y = diff(y, 2);
b = solve(d2y);
x = b(2);
plot(x, eval(y), 'r*');

x=0.5:0.01:6;
plot(x, eval(dy), 'm');  % first derivative
plot(x, eval(d2y), 'r'); % second derivative

end