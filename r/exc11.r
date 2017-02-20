set.seed(1337)

# X = височина на хората, които са яли сирене
# H0: mu <= 185
# HA: mu > 185
x = rnorm(100, 180, 10)

t.test(x, mu = 185, alternative = "greater")

t.test(x, mu = 180.1, alternative = "greater")
# p-value = 0.01778 < alpha = 0.05 => reject the null hypothesis

x = rnorm(1e6, 180, 10)
t.test(x, mu = 180.1, alternative = "greater")

