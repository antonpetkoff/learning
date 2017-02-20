function plotslope
clc;
axis([-6, 6, -6, 6]);
hold on;
x = -5:0.5:5;
y = -5:0.5:5;
delta = 0.4;
for k=1:length(x)
    for m=1:length(y)
        plot(x(k), y(m), 'k.');
        eps = delta / sqrt(1 + ff(x(k), y(m))^2);
        plot([x(k)-eps, x(k)+eps], [y(m)-eps*ff(x(k), y(m)), y(m)+eps*ff(x(k), y(m))], 'k');
    end
end

function z = ff(x,y)
    % z = y; % y' = y
    z = x/y; % y' = x/y
    % try with -x/y, y/x, -y/x, (x+y)/(y-x)
end

[x0, y0] = ginput(1);
plot(x0, y0, 'go');
% symbol solution
y = dsolve('Dy=y', 'y(x0)=y0', 'x');
x=-6:0.01:6;
plot(x, eval(y));

% % numerical solution
% [x, y] = ode45(@ff, [x0, x0+6], y0);
% [x1, y1] = ode45(@ff, [x0, x0-6], y0);
% plot(x, y, x1, y1, 'b');

end