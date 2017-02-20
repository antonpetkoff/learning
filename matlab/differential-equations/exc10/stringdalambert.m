function stringdalambert
clc; clf;
x = -4:0.01:6;
t = 0:0.05:8;
a = 1/2; % skorost na dvijenie na valnite

    function y = phi(x)
        for i=1:length(x)
            if 1 <= x(i) && x(i) <= 2
                y(i) = sin(pi*x(i))^4;
            else
                y(i) = 0;
            end
        end
    end

    function y = psi(x)
        %y = 0*x;    % za da sme sigurni che e vektor
        y = (1/20)*sin(3*x);
    end

    function y = dalambert(x, t)
       for j=1:length(x)
           if t == 0
               integral = 0;
           else
               % razbivame intervala s
               s = x(j)-a*t:a*t/50:x(j)+a*t;
               integral=trapz(s, psi(s));
           end
           
           y(j) = (phi(x(j) - a*t) + phi(x(j) + a*t) )/2 + integral / (2*a);
       end
    end

    for k=1:length(t)
        plot(x, dalambert(x, t(k)), 'm', 'LineWidth', 2);
        axis([-4, 6, -1.05, 1.05]);
        xlabel('x');
        ylabel('u(x, t)');
        title('infinite string');
        M(k) = getframe;
    end

    movie(M, 2);
end