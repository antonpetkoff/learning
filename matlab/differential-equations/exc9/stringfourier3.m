function stringfourier3
clc;
clf;
a = 0.5;
L = pi * sqrt(2);
tmax = 30;
t = 0:tmax/1000:tmax;
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
        y = 0;
        for k=0:30 % сметни първите 30 събираеми
            Xk=cos(((2*k+1)*pi*x)/(2*L));
            Ak=(2/L)*trapz(x, phi(x).*Xk);
            Bk=(1/((2*k+1)*a*pi))*trapz(x, psi(x).*Xk);
            Tk=Ak*cos(a*(2*k+1)*pi*t/(2*L)) + Bk*sin(a*(2*k+1)*pi*t/(2*L));
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
