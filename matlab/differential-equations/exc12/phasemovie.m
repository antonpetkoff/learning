function phasemovie
clc; clf;
tmax = 10;
x = -6:0.5:6;
y = -4:0.5:4;
axis([-7, 7, -5, 5]);
hold on;
plot(0, 0, 'm*', -pi, 0, 'm*', pi, 0, 'm*');

% chertaem vektorno pole
[X, Y] = meshgrid(x, y);
X1 = Y; Y1 = sin(X + Y);
D1 = sqrt(X1.^2 + Y1.^2);
quiver(X, Y, X1./D1, Y1./D1, 0.5, 'r');
%daspect([1, 1, 1]);

    function z = rhs(t, y)
        z = [y(2); sin(y(1) + y(2))];
    end

[x0, y0] = ginput(1);
plot(x0, y0, 'g*')
[T, Z] = ode45(@rhs, [0, tmax], [x0, y0]);
for k=1:length(T)
    plot(Z(1:k, 1), Z(1:k, 2));
    M(k) = getframe;
end
movie(M, 2);

end