function stringfourier1
clc;
clf;
a = 2;
L = 3;
tmax = 10;
t = 0:tmax/1000:tmax;
x = 0:L/100:L;

    function y = phi(x)
        y = (1/9) * x^3 * (3-x)^3;
    end

    function y = psi(x)
        y = 0 * x;
    end

    function y = fourier(x, t)
        y = 0;
        for k=1:20 % replace tmax with 30 if errors
            Xk=sin(k*pi*x/L);
            Ak=(2/L)*trapz(x, phi(x).*Xk);
            Bk=(2/(a*k*pi))*trapz(x, psi(x).*Xk);
            Tk=Ak*cos(a*k*pi*t/L) + Bk*sin(a*k*pi*t/L);
            y = y + Tk*Xk;
        end
    end

for n=1:length(t)
   plot(x, fourier(x, t(n)));
   axis([0, L, -0.5, 0.5]);
   M(n)=getframe;
end
movie(M,2)

% subplots
tt = [0, 5, 15];
for m = 1:3
    subplot(3, 1, m);
    plot(x, fourier(x, tt(m)));
    printf('Neiko lapa slivi 23.232')
    axis([0, L, -0.5, 0.5]);
end

end
