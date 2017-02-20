# x is a vector of observations
# EX and VarX must exist, and we know what is VarX
ci_known_variance = function (x, alpha, variance) {
  ci = mean(x) + qnorm(1 - alpha/2) * sqrt(variance) / sqrt(length(x)) * c(-1, 1);
  return(ci);
}

x = rnorm(100, 6, 2); # has a variance of 4
ci_known_variance(x, 0.05, 4);

caught = 0 # counter
for (i in 1:100) {
  y = rnorm(100, 6, 2);
  ci = ci_known_variance(y, 0.05, 4);
  if (ci[1] <= 6 && 6 <= ci[2]) { # & is for vectors - component-wise
    caught = caught + 1;
  }
}
caught

# conf.level = 1 - alpha
t.test(x, conf.level=0.95) # here the variance is unknown
# df = 99 е броят на степените на свобода, при n = 100, n-1 = 99 от Т~t(n-1)
# T=Z/sqrt(X/n), Z ~ N(0, 1), sqrt(X/n) ~ Chi^2(n)

# понеже x e нормално разпределена, то медианата и средно аритметичното съвпадат
wilcox.test(x, conf.level = 0.95, conf.int = TRUE)
# полезен тест при несиметрични разпределения

cauchy = rcauchy(100) # doesn't have an expectation, non-symmetric distribution
t.test(cauchy, conf.level = 0.95) # => няма статистически смисъл
wilcox.test(cauchy, conf.level = 0.95, conf.int = TRUE) # вече има смисъл, медианата е в нулата

# 60 гласували за Клинтън и 40 които не са гласували за Клинтън
prop.test(60, 100) # с 95% сигурност знаем, че успехът е в интервала 0.4970036 0.6952199
prop.test(600, 1000)
