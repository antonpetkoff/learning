function kleroeq

clc;
axis([-8, 8, -8, 8]);
hold on;
syms x y z;
% F = z^2 + x*z - y; % a)
F = z^2 - x*z + 5*y - x^2;
Fz = diff(F, z);
[y, z] = solve(F, Fz, y, z);
x = -8:0.01:8;
plot(x, eval(y), 'b');
grid on;
[x0, y0] = ginput(1);
plot(x0, y0, 'm*');

%if y0 < -x0^2/4 % a)
if y0 > x0^2/4 % b
    text(x0+0.1, y0, 'no solution');
else
    % yy = dsolve('(Dy)^2 + x*Dy - y = 0', 'y(x0)=y0', 'x') % a)
    yy = dsolve('(Dy)^2-x*Dy+5*y-x^2=0', 'y(x0)=y0', 'x') % b)
    plot(x, eval(yy));
end

end