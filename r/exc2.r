setwd("/home/tony/Desktop")
data = read.csv("SoftwareEngineering.csv")
View(data)
data = data[-1] # remove the first row
attach(data)
# without attach you would have to write data$Gender
table(Gender)
table(Region)
table(HairColor)
table(EyesColor)

# relative frequency
genderFreq = table(Gender)/length(Gender)
table(Region)/length(Region)
round(table(HairColor)/length(HairColor), 2) # round to the second digit

# check the type
class(genderFreq) # returns "table"

# qunatitive data representation
barplot(table(Gender)) # in absolute frequency

color = c("red", "blue")
barplot(table(Gender), col=color)

# why do we write `table` ? table is like Python's Counter, thus we use table to count
Gender
rbow = rainbow(7)
pie(table(Gender), col=rbow)

pie(table(Region), col=rbow)

Weight[13] = 100 # normalize 100+ to 100
hist(Weight)
hist(Height) # use histograms instead of barplots for data like heights

hist(AverageGrade)
