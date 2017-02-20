function plotic1
    y = simplify(dsolve('x*Dy=k*y', 'y(x0)=y0', 'x'));
    k = -1;
    axis([-10, 10, -20, 20]);
    hold on;
    daspect([1, 1, 1]);     % maintain an aspect ratio
    [x0, y0] = ginput(1);   % ginput listens for clicks
    plot(x0, y0, 'm*');
    if x0 > 0
        x = 0:0.01:10;
    else
        x = -10:0.01:0;
    end
    plot(x, eval(y));
end