setwd("/home/tony/Desktop")
data = read.csv("SoftwareEngineering.csv")
attach(data)
Height
hist(Height)

# cutting data into intervals
breaks = seq(160, 200, 10)
heightsCut = cut(Height, breaks, right = FALSE) # right side of interval is open
heightsCut

# histogram with custom intervals
breaks = seq(160, 200, 20)
hist(Height, breaks)

# another example with custom intervals
breaks = seq(2, 6, 0.5)
hist(AverageGrade, breaks)

# recap: 2D frequencies
table(Gender, HairColor) # absolute frequencies
prop.table(table(Gender, HairColor), 2) # relative frequencies, proportions table
# third argument :: what parts of the table should sum to probability of 1  
  # no third argument -> the whole table should sum to 1
  # 3rd argument is 1 -> each row should sum to 1
  # 2 -> each column should sum to 1

# drawing frequency tables
barplot(table(Gender, HairColor), beside=TRUE, legend=c("female", "male"))
  # the `beside` parameter draws columns side by side or stacked
  # the `legend` parameter takes a parameter of strings

# another example of the above
barplot(table(Gender, Region), beside=TRUE, legend=c("female", "male"), col=c("pink", "blue"))
table(Gender, EyesColor)

# how does the gender (quality) influences the average grade (quantity)?
#   the quality property is independent (e.g. gender)
#   the quantity property is dependent (e.g. average grade)
#   quality~quantity, independent~dependent, response~predict
# let's draw 2 boxplots
boxplot(AverageGrade~Gender)

# quantity~quantity, when quantity depends on quantity
# Height~Weight, scatter plot (correlation field)
scatter.smooth(Height, Weight)
# linear regression finds the line which best fits the data
# correlation (корелация, cor()) :: dependence of on property based on the other
#   between -1 and 1, -1 means the opposite of a correlation
# covariation (ковариация, cov()) :: how many of the points are on the line
