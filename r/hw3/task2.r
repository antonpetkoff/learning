library(UsingR)
brightness

# разпределението на извадката изглежда симетрично и наподобява нормалното разпределение
simple.eda(brightness)

# не знаем теоретичната дисперсия, затова използваме t.test
t.test(brightness, conf.level = 0.93)


# Допълнителен анализ на данните:
# понеже разпределението е симетрично, медианата почти съвпада със средното аритметично
wilcox.test(brightness, conf.int = TRUE, conf.level = 0.93)

# from Wikipedia Skewness#Relationship of mean and median:
# If the distribution is symmetric, then the mean is equal to the median,
# and the distribution has zero skewness. If, in addition,
# the distribution is unimodal, then the mean = median = mode.

mode = function(x) {
  ux = unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# медианата, модата и средното аритметично са доста близки
median(brightness) # 8.5
mode(brightness) # 8.55
mean(brightness) # 8.417743
