# Two-sample t-test
# Verizani page 69 example: Recovery time fo new drug
# H0: mu_x >= mu_y
# Ha: mu_x < mu_y (the pharmaceutical company wants to prove its drug is good)
# we assume that var_x = var_y

x = c(15, 10, 13, 7, 9, 8, 21, 9, 14, 8)
y = c(15, 14, 12, 8, 14, 7, 16, 10, 15, 12)
t.test(x, y, alt="less", var.equal = TRUE)
# => with or without the drug, there is no difference

t.test(x, y, alt = "less")

wilcox.test(x, y, alt = "less", conf.int = TRUE)

# matched samples
# Verizani page 70 example: Dilemma of two graders
x = c(3, 0, 5, 2, 5, 5, 5, 4, 4, 5)
y = c(2, 1, 4, 1, 4, 3, 3, 2, 3, 5)

t.test(x-y, mu = 0, alt="two.sided", sig.level=0.05)
# 0 not in CI => reject the null hypothesis => the two graders don't grade equally
# t.test(x, y, mu = 0, alt="two.sided", sig.level=0.05, paired=TRUE) is the same

# Chi-squared tests
x = c(15, 14, 20, 10, 21, 20)
th_prob = rep(1/6, 6)
chisq.test(x, p=th_prob)

obs = x
expected = th_prob * 100
sum(((obs-expected)^2) / expected)

# Chi-squared test for independence
# Veizani page 75
yesbelt = c(12813,647,359,42)
nobelt = c(65963,4000,2642,303)
belt = data.frame(yesbelt,nobelt)
belt
chisq.test(belt)
