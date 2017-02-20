x = rbinom(100, 15, 0.4)
(x - 15 * 0.4)/sqrt(15*0.5*0.6)

CLT_binom = function (s, n, p) {
  x = rbinom(s, n, p)
  z = (x - n*p)/sqrt(n * p * (1-p))
  hist(z, prob=TRUE)
  return(z)
}

Z = CLT_binom(1000, 1000, 0.4)
curve(dnorm(x), -4, 4, add = TRUE)

qqnorm(Z) # срявнява извадката с теоретичните квантили на нормалното разпределение
qqline(Z) # свързва квантилите, отговарящи на първи и трети квартил?
shapiro.test(Z) # проверява дали числата идват от нормално разпеделение

# пример, който няма EX и VarX => ЦГТ не е в сила
# сега n е обема на извадката, location = 0, scale = 1
CLT_cauchy = function (n) {
  x = rcauchy(n)
  z = (x - 0)*sqrt(n)
  hist(z, prob=TRUE)
  return(z)
}
CLT_cauchy(10000)

CLT_binom(150, 15000, 0.1) # плътността на Биномното разпределение стана силно асиметрична при малка вероятност за успех
# има нужда от по-голямо n, за да важи CLT!

# защо това не ни вършеше работа?
CLT_exp_bad = function (n, lambda) {
  x = rexp(n, lambda);
  z = (x - 1/lambda)*lambda*sqrt(n);
  hist(z, prob=TRUE);
  return(z);
}

# с много малки извадки клони към N(0, 1)
CLT_exp = function (rep, n, lambda) {
  z = c(); # holds centralized and normalized values
  for (i in 1:rep) {
    x = rexp(n, lambda);
    z = c(z, (mean(x) - 1/lambda)*lambda*sqrt(n));
  }
  hist(z, prob=TRUE)
}

CLT_exp(100, 5, 10) # все още не е достатъчно центрирано разпределението!
CLT_exp(100, 3000, 10) # това вече прилича доста на N(0, 1)

CLT_unif = function (rep, n, a, b) {
  z = c();
  for (i in 1:rep) {
    x = runif(n, a, b);
    z = c(z, (mean(x) - (a+b)/2)/sqrt((b-a)^2/12)*sqrt(n));
  }
  hist(z, prob=TRUE);
  return(z);
}
CLT_unif(100, 50, 3, 7) # равномерното разпределение има симтерична плътност и затова при малко опити стигнахме бързо до N(0, 1)

curve(dchisq(x, 5), -0.1, 30)

for (n in 1:20){
  curve(dchisq(x, n), -0.1, 50, ylim=c(-0.1, 0.6));
  Sys.sleep(0.2);
} # прилича на нормално разпределение с доста висока дисперсия

for (n in 1:60) {
  curve(dnorm(x), -3.5, 3.5, ylim=c(-0.01, 0.45), col="blue")
  # dt = density of T-distribution
  curve(dt(x, n), -3.5, 3.5, add = TRUE, col="red")
  Sys.sleep(0.1)
}
