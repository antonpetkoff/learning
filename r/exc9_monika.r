
for (n in 1:50) {
  curve(dchisq(x, n), -0.1, 50, ylim=c(-0.1, 1.0));
  Sys.sleep(0.1);
}

library(MASS)
head(survey)
attach(survey)

# 1) find the expectation of the height, оценка на средното на популацията
sigma = 10;
mean = mean(Height, na.rm = TRUE); # removes not available
# na.omit(vec) removes the NA values from the vector vec
n = length(na.omit(Height));
sem = sigma / sqrt(n); # standard error of mean
alpha = 0.05
z = qnorm(1 - alpha/2);
marginError = z * sem
ci = mean + c(-marginError, marginError) # confidence interval
ci

simple.z.test(na.omit(Height), sigma = sigma, conf.level = 0.95) # the same as the algorithm above

# TODO: library(TeachingDemos) z.test

# t.test is used when the variance is unknown
