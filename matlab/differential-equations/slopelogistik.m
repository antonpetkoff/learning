function slopelogitik
x = 0:0.4:15;
y = 0:0.05:1;
delta = 0.2;
axis([0, 15, -0.1, 1.1]);
% daspect([1, 1, 1]);
hold on;

for k=1:length(x)
    for m=1:length(y)
        plot(x(k), y(m), 'm.')
        eps = delta/sqrt(1+ff(x(k), y(m))^2);
        plot([x(k)-eps, x(k)+eps], [y(m)-eps*ff(x(k), y(m)), y(m)+eps*ff(x(k), y(m))], 'k');
    end
end

[x0, y0] = ginput(1);
plot(x0, y0, 'm*');

% numeric solution
%[x, y] = ode45(@ff, [x0, 15], y0);
%plot(x, y, 'c');

% symbol solution
y = dsolve('Dy=2*y*(1-y)', 'y(x0)=y0', 'x')
plot(x, eval(y));

function z=ff(x, y)
    eps0 = 0.2;
    z = eps0 * y * (1-y);
end

end