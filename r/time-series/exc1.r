library(TSA)
# install.packages('TSA')

data("larain")
plot(larain, type = 'o')

# the blue lines are the confidence interval for white noise
# all points are inside the CI, thus this is white noise
# this CI for white noise is the main criteria for assessing the residuals of the model
acf(larain)

data("hare")
hare
# we might have seasonality
plot(hare, type = 'o')

# we have seasonality, because the ACF mimics a sin/cos function
acf(hare)

# data with physical laws are nice
data("tempdub")
tempdub
plot(tempdub, type = 'o')
acf(tempdub, lag.max = 1000)

data("electricity")
electricity

# this data is heteroscedastic
plot(electricity)

# if the data is negative, we can shift it so that we can stabalize the series to become homoscedastic

homo_electricity <- log(electricity)
# now the series is homoscedastic
plot(homo_electricity)

# difference operator with 1 lag
# if the trend was quadratic, we would have to apply the diff operator twice
diff_electricity <- diff(homo_electricity)
# now we have removed the trend and see the seasonality
plot(diff_electricity)

acf(electricity, lag.max = 1000)
acf(homo_electricity, lag.max = 1000)
acf(diff_electricity, lag.max = 1000) # now it is a stationary process, but not yet white noise

# lag = 12 is the sub index for the nabla symbol
# lag = 12 is to account for annual values
plot(diff(homo_electricity, lag = 12))
acf(diff(homo_electricity, lag = 12), lag.max = 1000)

data("oil.price")
plot(oil.price)
# the trend becomes more linear with log and the variance is more stable
acf(oil.price, lag.max = 1000)

plot(log(oil.price))
acf(log(oil.price), lag.max = 1000)

plot(diff(log(oil.price)))
acf(diff(log(oil.price)), lag.max = 1000)

# annual comparison of the economic data
plot(diff(log(oil.price), lag = 12))
acf(diff(log(oil.price), lag = 12), lag.max = 1000)

data("CREF")
# has volatility clustering, this is common in economic data
plot(CREF)
acf(CREF, lag.max = 1000)

plot(log(CREF))
acf(log(CREF), lag.max = 1000)

# remove the trend
plot(diff(log(CREF)))
acf(diff(log(CREF)), lag.max = 1000)

# test the normality of data
shapiro.test(CREF)

# X _||_ Y => g(X) _||_ g(Y)
acf(diff(log(CREF)) ^ 2, lag.max = 1000)

set.seed(1)
# random walk -> white noise
n = 100
xs = rnorm(n)
series = ts(cumsum(xs), start = c(2019, 1), frequency = 12)
series

plot(series, type = 'o')
acf(series, lag.max = 1000)
pacf(series, lag.max = 1000)

plot(log(series + 100), type = 'o')
acf(log(series + 100), lag.max = 1000)
pacf(log(series + 100), lag.max = 1000)
