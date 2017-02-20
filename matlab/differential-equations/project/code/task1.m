function task1
axis([1, 2, 1, 2]);
hold on;
x = 1:0.1:2;
y = 1:0.1:2;
delta = 0.05;

    function z = ff(x,y)
        z = ((1 + y^2) * atan(y)) / sin(x);
    end

for k=1:length(x)
    for m=1:length(y)
        plot(x(k), y(m), 'k.');
        eps = delta / sqrt(1 + ff(x(k), y(m))^2);
        plot([x(k)-eps, x(k)+eps],...
             [y(m)-eps*ff(x(k), y(m)), y(m)+eps*ff(x(k), y(m))],...
             'k');
    end
end

plot(pi/2, 1, 'ro');
y = dsolve('Dy * sin(x) = (1 + y^2) * atan(y)', 'y(pi/2)=1', 'x');
plot(x, eval(y), 'r', 'LineWidth', 2);

plot(1, 1, 'bo');
[x, y] = ode45(@ff, [1, 2], 1);
plot(x, y, 'b', 'LineWidth', 2);

end