dataset <- read.csv('50_Startups.csv')
dataset$State <- factor(dataset$State, levels=c('New York', 'California', 'Florida'), labels=c(1,2,3))
dataset
library(caTools)
set.seed(123)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split==T)
test_set <- subset(dataset, split==F)
regressor <- lm(formula = Profit~., data = training_set) 
#The dot specifies that the profit is a linear function of all the other variables
summary(regressor)
#estimate is the coefficient in the linear regression equation 
#we interpret that the profit is mainly dependent on the R&D spend and the other variables are not that significant
#This means that we can re write the equation as profit~r&d 
y_pred = predict(regressor, newdata=test_set)
y_pred


#Trying modeling profit as a relation of only R&D spend (extra)

regressor_2 = lm(formula = Profit ~ R.D.Spend, data=training_set)
summary(regressor_2)
y_pred_2 = predict(regressor_2, newdata=test_set)
y_pred_2
