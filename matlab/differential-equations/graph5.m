% y'=xy+x^3 :: начертаийте 5 интегрални криви на това уравнение
% в -6<=x<=6, -6<=y<=6

function graph5
clc;
x=-6:0.01:6;
axis([-6,6,-6,6]);
hold on;
grid on;

b = -2:1:2;
a = [0, 0, 0, 0, 0];
for k=1:5
    y=dsolve('Dy=x*y+x^3','y(x0)=y0','x');  % we find a general solution
    x0 = a(k);
    y0 = b(k);
    plot(x, eval(y));   % x0 and y0 are replaced in the solution
end

end