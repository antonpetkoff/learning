function plotode
y=dsolve('Dy=1+y^2','y(x0)=y0','x')
axis([-4,4,-6,6])
hold on
grid on
[x0,y0]=ginput(1);
plot(x0,y0,'ro')
c=-x0+atan(y0);
x=-pi/2-c+0.01:0.01:pi/2-c-0.01;

% x=-4:0.01:4;
plot(x,eval(y))



end