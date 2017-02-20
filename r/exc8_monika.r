# CLT for Binomial distro
n = 10
p = 0.25
Sn = rbinom(500, n, p)
Xn = (Sn - n*p)/sqrt(n * p * (1-p))
hist(Xn, prob=TRUE)

y = dnorm(seq(from = -3, to = 3, by = 0.1), mean = 0, sd = 1)
lines(seq(from = -3, to = 3, by = 0.1), y, type = "l") # type="l" connects the dots

CLT_binom_iter = function(rep, n, p) {
  Sn = mat.or.vec(rep, 1);
  Xn = mat.or.vec(rep, 1);
  for (i in 1:rep) {
    Sn[i] = rbinom(1, n, p); # generate one observable
    Xn[i] = (Sn[i] - n * p)/sqrt(n * p * (1-p));
  }
  hist(Xn, prob=T);
  interval = seq(from = -3.5, to = 3, by = 0.1);
  y = dnorm(interval, mean = 0, sd = 1);
  lines(interval, y, type = "l");
}

CLT_binom_iter(5000, 1000, 0.25)

library(UsingR)
f = function(n, mu, sigma) {
  X = rnorm(n, mu, sigma)
  return(mean(X) - mu)/(sigma/sqrt(n))
}
hist(simple.sim(5000, f, 10, 2, 5), prob = T) # binomial

x = rnorm(300, 2, 10);
qqnorm(x, main = 'normal(2, 10)');
qqline(x);

# TODO: simple.eda generates a histogram, a box plot and a normal Q-Q plot

x = rbinom(300, 10, 0.5);
qqnorm(x, main = 'normal(2, 10)');
qqline(x);

library(StatDA)
x = rexp(300, 10)
qqplot.das(x, "exp") # approximate a sample with arbitrary distribution
