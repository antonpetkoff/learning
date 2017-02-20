setwd("/home/tony/Desktop")
data = read.csv("SoftwareEngineering.csv")
attach(data)
Height
mean(Height)
hist(Height)
median(Height)
quantile(Height, 0.3) # look up the formula for calculating quantiles
quantile(Height) # by default gives you the quartiles
fivenum(Height) # get hinges, hinges =/= quartiles

# box with whiskers
d = c(Height, 400) # 1000 here is an outlier and messes up the box plot
boxplot(d, horizontal = TRUE)

# smooth approximations of discrete data
hist(Height, 15, prob=T) # prob=T gives relative frequencies, where F gives absolute
lines(density(Height, bw="SJ"))
lines(density(Height, bw=0.9)) # smooth approximation of the histogram

table(Gender, HairColor) # absolute frequency

# 100% for the whole table
prop.table(table(Gender, HairColor)) * 100 # gives relative frequencies

# 100% on each row, with margin=1
prop.table(table(Gender, HairColor), 1) * 100 # gives relative frequencies

# now we can make a useful barplot
barplot(table(HairColor, Gender)) # we can use colors

library("UsingR")
simple.freqpoly(Height)

hist(Height)
rug(jitter(Height)) # depends on the previous line
