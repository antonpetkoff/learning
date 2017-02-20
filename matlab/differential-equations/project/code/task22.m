function task22
a = 2; L = 3; ymax = 1.5;
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

moments = [0, 5, 15];
for i=1:length(moments)
    subplot(3, 1, i);
    plot(x, fourier(x, moments(i)), 'k');
    axis([0, L, -ymax, ymax]);
    title(['t = ' num2str(moments(i))]);
    grid on;
end

end
