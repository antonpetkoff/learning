W = 1;
A = 7;
S = 9;
D = 3;

# а)
geomProb = (S + D + 9) / 90;
a = pgeom((W + 5) - 1, geomProb) - pgeom(min(c(2, A) - 1), geomProb);

# б)
lambda = D + 1.5;
b = ppois(W + 4, lambda) - ppois(min(c(3, A)), lambda);

# в)
zProb = (W + A + S + D + 11) / 111;
zStar = abs(qnorm((1 - zProb) / 2));
# проверка на коректността на zStar
testProb = 1 - pnorm(zStar, lower.tail = FALSE) - pnorm(-zStar);
abs(zProb - testProb) <= 1e-14;

# г)
midProb = (55 + W + A) / 100;
lowerTailProb = pt(-1.5, 33);
x = qt(lowerTailProb + midProb, 33);
# проверка на коректността на x
testProb = pt(x, 33) - pt(-1.5, 33);
abs(midProb - testProb) <= 1e-14; 

a
b
zStar
x
