function task21
a = 2; L = 3; tmax = 10; ymax = 1.5;
t = 0:tmax/500:tmax;
x = 0:L/100:L;

    function y = phi(x)
        y = ((x.*(3-x)).^3)/9;
    end

    function y = psi(x)
        y = 0 * x;
    end

    function y = fourier(x, t)
        y = 0;
        for k = 1:20
            Xk = sin(k*pi*x/L);
            Ak = (2/L)*trapz(x, phi(x).*Xk);
            Bk = (2/(a*k*pi))*trapz(x, psi(x).*Xk);
            Tk = Ak*cos(a*k*pi*t/L) + Bk*sin(a*k*pi*t/L);
            y = y + Tk*Xk;
        end
    end

for n=1:length(t)
    plot(x, fourier(x, t(n)));
    axis([0, L, -ymax, ymax]);
    M(n) = getframe;
    grid on;
end
movie(M, 2);

end
