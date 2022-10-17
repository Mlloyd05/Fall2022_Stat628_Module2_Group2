library(car)
library(ggplot2 )
bodydata <- read.csv("BodyFat.csv")
#summary of bodydata shows that id col is not useful
bodydata <- bodydata[,-c(1)]
#preprocessing
sort(unique(bodydata$BODYFAT))
#check unrealistic body fat percentage, in lecture professor said Usian Bolt has like 5 percent bodyfat, 
#I googled it and it said 8%, and Bruce Lee has around 6 percent, so I would set the line to 3 percent
bodydata[which(bodydata$BODYFAT<3),]
#shows that id172 and id182 are suspicious, since no way to get the real number for now, just delete them
bodydata <- bodydata[-which(bodydata$BODYFAT<2),]
#now check for other abnormal data
#first convert the units(I don't like inchs and lbs)
bodydata$HEIGHT <- bodydata$HEIGHT *2.54
bodydata$WEIGHT <- (bodydata$WEIGHT/2.2)
#plot the bodyfat and data, they should be positive related
ggplot(bodydata, mapping = aes(x = HEIGHT, y = BODYFAT))+geom_point()
#there is one data has less than 100 cm height, should be a miss collected data, get its index
bodydata[which(bodydata$HEIGHT<100),]
#it's index 42, try to recalculate its real number
incorrect <- bodydata[which(bodydata$HEIGHT<100),]
#since BMI(adiposity) is calculated by weight/height^2, height is sqrt of weight/bmi
correct_height = (sqrt(incorrect$WEIGHT/incorrect$ADIPOSITY))*100
#answer is 176.53, looks normal now, put it back
bodydata$HEIGHT[which(bodydata$HEIGHT<100)] = correct_height
#check for abnormal weight
ggplot(bodydata, mapping = aes(x = WEIGHT, y = BODYFAT))+geom_point()
sort(unique(bodydata$WEIGHT))
bodydata[which(bodydata$WEIGHT>100),]
#some weight are too large, try to use BMI to get the real value
ggplot(bodydata, mapping = aes(x = ADIPOSITY, y = BODYFAT))+geom_point()
sort(unique(bodydata$ADIPOSITY))
#there is a value 48.9 BMI, generally not possible, we set the line to 45
incorrect1 <- bodydata[which(bodydata$ADIPOSITY>45),]
correct_bmi = 10000 * (incorrect1$WEIGHT)/(incorrect1$HEIGHT)^2
#the BMI is correct, try to verify all BMI values
#realized we could check all BMI with the formula
BMI =10000 * (bodydata$WEIGHT)/(bodydata$HEIGHT)^2#10000 is by using the 703 for pounds and inchs
ggplot(bodydata, mapping = aes(x = BMI, y = ADIPOSITY))+geom_point()
dif = BMI-bodydata$ADIPOSITY
max(dif)
min(dif)
#max BMI difference with adiposity in bodyfat data is 3.064518, within accpetable range
#for the data cleaning process we delete two data and correct one by using the BMI formula, save data
write.csv(bodydata,file = "adjusted_bodyfat.csv", row.names = FALSE)
