%y=dsolve('x*Dy=y','x');
%y=dsolve('Dy=y','y(0)=1','x'); %задача на коши с начално условие
%y = dsolve('Dy=4*x^2+(y^4)/2', 'x') % explicit solution could not be found
%y = dsolve('Dy=4*x^2+y^2', 'x') % bessel is a special function
%y = dsolve('Dy=1+y^2')
y = dsolve('x*Dy=y/2', 'y(-1)=1', 'x')