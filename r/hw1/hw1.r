library(UsingR)
setwd("/home/tony/Documents/Code/FMI/R/hw1")
pokemons = read.csv("pokemon.csv")
attach(pokemons)

set.seed(61793)
sampleRows = sample(nrow(pokemons), 600)

data = pokemons[sampleRows,]
head(data)

pie(summary(Type1), main = "Type1")
pie(summary(Type2), main = "Type2")
hist(Attack, xlim = c(1,200))
boxplot(Defense, horizontal = TRUE, main = "Defense")
boxplot(Height, horizontal = TRUE, main = "Height")
simple.hist.and.boxplot(Weight)

lightest = data[data$Weight == min(Weight),]
tallest = data[data$Height == max(Height),]
above220 = data[data$Attack + data$Defense > 220,]
dragonsCount = nrow(data[(data$Type1 == "Dragon" | data$Type2 == "Dragon") & data$Height > 1.0,])

type2weights = data[data$Type2 != "",]$Weight
hist(type2weights, prob=T)
lines(density(type2weights))

normalOrFighting = data[data$Type1 == "Normal" | data$Type1 == "Fighting",]
boxplot(normalOrFighting$Height~normalOrFighting$Type1)

correlation = cor(Height, Weight)
correlation
model = simple.lm(Height, Weight)
summary(model)
