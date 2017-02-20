function eulermeth
clc; clf;
hold on;
x0 = 0; y0 = -1;
xmax = 2;
yy = dsolve('Dy = -y * tan(t) + cos(t)^2', 'y(x0) = y0');
t = x0:0.01:xmax;
plot(t, eval(yy));

mycolors = ['y', 'g', 'm'];
h = [0.5, 0.1, 0.01];
y(1) = y0;
for j = 1:length(h)
    x = x0:h(j):xmax;
    for k = 1:length(x) - 1
        y(k+1) = y(k) + h(j) * (cos(x(k))^2 - y(k)*tan(x(k)));
    end
    plot(x, y, 'Color', mycolors(j));
end

end