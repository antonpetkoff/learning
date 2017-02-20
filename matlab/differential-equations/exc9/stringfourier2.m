function stringfourier2
clc;
clf;
a = 0.5;
L = pi * sqrt(2);
tmax = 30;
t = 0:tmax/100:tmax;
x = 0:L/100:L;

    function y = phi(x)
        for i=1:length(x)
            if 1 < x(i) && x(i) < 2
                y(i) = 10 * exp(4/((2*x(i)-3)^2 -1));
            else
                y(i) = 0;
            end
        end

    end

    function y = psi(x)
        y = 0*x;    
    end

    function y = fourier(x, t)
        y = (trapz(x, phi(x))/L) + t * trapz(x, psi(x))/L;
        for k=1:30;
            Xk=cos(k*pi*x/L);
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

end
