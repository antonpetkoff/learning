library(UsingR)

# H_0: mu_m == mu_e
# H_a: mu_m != mu_e
alpha = 0.1
df = length(blood) - 1
qt(alpha / 2, df, lower.tail = FALSE)
# критична област: (-Inf, -6.313752) U (6.313752, Inf)

m = blood$Machine
e = blood$Expert

# дисперсиите се различават
var(m) # 180.5429
var(e) # 137.2571

# проверяваме дали данните идват от Нормални разпределения
simple.eda(m)
simple.eda(e)
# според мен и двете извадки идват от Нормални разпределения

# тестова статистика
ts = (mean(m - e) * sqrt(length(m)))/sd(m - e)

# p-value
2 * pt(q = ts, df = 14, lower.tail = FALSE)

t.test(blood$Machine, blood$Expert, paired = TRUE)
