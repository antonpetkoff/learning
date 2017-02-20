
# random uniform distribution
x = runif(10000)  # by default min=0, max=1
hist(x, probability = TRUE)
curve(dunif(x, 0, 1), add = TRUE) # find the theoretical line of distribution

# bernoulli distribution, a special case of the binomial distro -> use {r,d,q}binom
# rbinom(number, n_trials, p)
rbinom(1, 1, 0.5)

# exc.6.1
range(runif(10, 1, 10))

# exc.6.2
x = rnorm(10, 5, 5)
length(x[x < 0])
10 * pnorm(0, 5, 5) # theoretical count of 10 numbers x being < 0 where x ~ N(5, 5)

# exc.6.3
x = rnorm(100, 100, 10)
length(x[x < 80 | x > 120])

pnorm(80, 100, 10, lower.tail=TRUE)
pnorm(120, 100, 10, lower.tail=FALSE)
# it is the same as 2*pnorm(80, 100, 10) because the interval is symmetric
sampleSize = 100
sampleSize * (2 * pnorm(80, 100, 10))

# exc.6.6
sample(1:49, 6)

# exc.6.7
qnorm(0.05, 0, 1) # the inverse of pnorm

# exc.6.8
# P(-z* <= Z <= z*) = P(-z* <= Z) + P(Z <= z*) = 2 * P(-z* <= Z), because of symmetry
2 * qnorm(0.05, 0, 1)

# TODO: what does sd = 1:5 mean?
rnorm(5, mean = 0, sd = 1:10)
?rnorm
