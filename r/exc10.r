
# Verizani exercise 9.4
library(UsingR)
?exec.pay
data(exec.pay)
hist(exec.pay) # изглежда асиметрично => взимаме медиана

# за доверителен интервал на медиана ползваме wilcox.test
wilcox.test(exec.pay, conf.level = 0.95, conf.int = TRUE)
