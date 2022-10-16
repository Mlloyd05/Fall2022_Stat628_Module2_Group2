library(car)
#read preprocessed data
bodydata = read.csv("adjusted_bodyfat.csv")
#first model is the full model with all original variables

#This first part is just linear regression by picking the most accurate variables
full_model_lm <- lm(bodydata$BODYFAT ~ . , bodydata)
#the full model has 0.9783 as R squared value, definitely has overfitting problem
summary(full_model_lm)
#Get VIF's
# VIFs start at 1 and have no upper limit. A value of 1 indicates that there is 
#no correlation between this independent variable and any others. VIFs between 1
#and 5 suggest that there is a moderate correlation, but it is not severe enough
#to warrant corrective measures. VIFs greater than 5 represent critical levels 
#of multicollinearity where the coefficients are poorly estimated, and the 
#p-values are questionable.
vif(full_model_lm)
#remove high p-value variables (higher than .2)
#so  remove height, chest, knee, ankle, biceps
#remaining variables are: age, weight, neck, abdomen, hip, thigh, forearm, wrist
bodydata1 <- bodydata[c(1,3,4,7,9,10,11,15,16)]
full_model_lm2 <- lm(bodydata$BODYFAT ~ . , bodydata1)
#the full model after we delete the varaiables that has too large p-value shows 
#0.7407 R squared value, the model could be used right now, but also can be improved 
summary(full_model_lm2)
#proposing models
#for simplicity this model is good as it's only 3 variables that are easy to get 
#Is better than just Age + Weight as it's R^2 is .3 higher 
#R^2 is only .02 less than full_model_lm2's R^2
summary(lm(BODYFAT ~ AGE + WEIGHT + ABDOMEN, bodydata1))
#proposing model 2 
#simpler but loses a lot of accuracy by missing one variable
summary(lm(BODYFAT ~ AGE + WEIGHT, bodydata1))
#Model w/ 3 most statistically significant values but is less accurate than Age + weight + abdomen
summary(lm(BODYFAT ~ FOREARM + WRIST + ABDOMEN, bodydata1))
#proposing model 4
#Seems like best
#highest R^2 of proposed ones w/ .7187 
#lower standard error than AGE + WEIGHT + ABDOMEN
summary(lm(BODYFAT ~ WEIGHT + ABDOMEN, bodydata1))
#R^2 is 0.7197
summary(lm(BODYFAT ~ (WEIGHT/HIP) + ABDOMEN, bodydata1))
#R^2 is 0.7303
summary(lm(BODYFAT ~ (WEIGHT/WRIST) + ABDOMEN, bodydata1))
#above two models are slightly accurate but not that much necessary

#This second part is quadratic regression
quad_model_lm <- lm(bodydata$BODYFAT ~ AGE+WEIGHT+HEIGHT+ADIPOSITY+NECK+CHEST+
                      ABDOMEN+HIP+THIGH+KNEE+ANKLE+FOREARM+WRIST +I(AGE^2)+
                      I(WEIGHT^2)+I(HEIGHT^2)+I(ADIPOSITY^2)+I(NECK^2)+I(CHEST^2)
                    +I(ABDOMEN^2)+I(HIP^2)+I(THIGH^2)+I(KNEE^2)+I(ANKLE^2)+
                      I(FOREARM^2)+I(WRIST^2)  , bodydata)
summary(quad_model_lm)
#R^2 is 0.7645, not too bad but could be improved

