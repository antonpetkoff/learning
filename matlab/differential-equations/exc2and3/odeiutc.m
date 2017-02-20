function odeiutc
    axis([-4, 4, -10, 10]);
    hold on;
    [x0, y0] = ginput(1);
    plot(x0, y0, 'm*');
    
    c = atan(y0) - x0;  % полагане
    
    function z = rhs(x, y)
        %z = y;     % let's solve y'=y
        z = 1 + y.^2;
    end

    %[x, y] = ode45(@rhs, [x0, 4], y0);      % solve for right interval
    %[x1, y1] = ode45(@rhs, [x0, -4], y0);   % solve for left interval
    [x, y] = ode45(@rhs, [x0, pi/2-c-0.01], y0);      % solve for right interval
    [x1, y1] = ode45(@rhs, [x0, -pi/2-c+0.01], y0);   % solve for left interval
    plot(x, y, x1, y1, 'b');
end