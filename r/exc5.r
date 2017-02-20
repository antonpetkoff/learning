setwd("/home/tony/Desktop")
data = read.csv("SoftwareEngineering.csv")
attach(data)

table(Gender, HairColor, EyesColor) # for each value of the third argument make a table
ft = ftable(Gender, HairColor, EyesColor) # ftable makes a more readable output
# now we can even make a barplot from the output of ftable
barplot(ft, col=rainbow(8), beside=TRUE)

# boxplot of multidimenstional data with ~
boxplot(AverageGrade~Weight)

# scale standartizes and normalizes the data, so that we can make comparisons
stripchart(scale(Height))
stripchart(scale(AverageGrade))

plot(ecdf(scale(Height))) # create a distribution function with ecdf
