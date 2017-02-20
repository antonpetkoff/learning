function pikarmeth
clc; clf;
xmin = -4; xmax = 4;
x0 = 0; y0 = 1;
y = dsolve('Dy = y', 'y(x0) = y0');
t = xmin:0.01:xmax;
plot(t, eval(y), 'k');
hold on;
axis([xmin, xmax, -10, 20]);

x = x0:(xmin-x0)/100:xmin;
xx = x0:(xmax-x0)/100:xmax;
y_0 = y0 * ones(1, length(x));
yy_0 = y0 * ones(1, length(xx));
plot(x, y_0, 'b', xx, yy_0, 'b'); % first approximation
grid on;

a = [1, 3, 7, 15];
mycolors = ['r', 'g', 'm', 'y'];
N = 15;
counter = 1;
z = y_0; zz = yy_0;
for k=1:N
    y_k = y0 + cumtrapz(x, ff(x, z));
    yy_k = y0 + cumtrapz(xx, ff(xx, zz));
    if any(k == a) == 1
        plot(x, y_k, 'Color', mycolors(counter));
        plot(xx, yy_k, 'Color', mycolors(counter));
        counter = counter + 1;
    end
    z = y_k; zz = yy_k;
end

    function z = ff(x, y)
        z = x.^2 + y.^2;
    end

end