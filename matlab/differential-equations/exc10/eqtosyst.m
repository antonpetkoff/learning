function eqtosyst

[y1, y2, y3] = dsolve('Dy1=y2', 'Dy2=y3', 'Dy3=-13*y2-4*y3',...
    'y1(0)=-1', 'y2(0)=13', 'y3(0)=0')
t = -1:0.01:2.5;
% y1 is the solution
% y3 is the third derivative
plot(t, eval(y1), 'b', t, eval(y2), 'm');
hold on;
[m, tm] = min(eval(y1)); % no need to specify t, because by default MATLAB uses t to denote points
[M, tM] = max(eval(y1));
plot(t(tm), m, 'go', t(tM), M, 'k*');

% finding the local extremals analytically led us to this plot
t = fzero(@(t) sin(3*t), 0)
plot(t, eval(y2), '*')

% infleksna tochka varhu y1
plot(t, eval(y1), 'o')

end