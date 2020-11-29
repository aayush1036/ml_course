dataset <- read.csv('Position_Salaries.csv')
dataset <- dataset[2:3]
library(ggplot2)
ggplot() + geom_point(aes(x=Level, y=Salary), data=dataset) +ggtitle('Level vs Salary')
#Here we see that the relation is non linear so we need to use polynomial regression 
#The position column is automatically encoded into the level column 
#because as the position increases, the level also increases
#we wont split the dataset into training set and the test set as the dataset is very small 
#comparing polynomial regression to linear regression
#creating linear regression model
lin_reg = lm(formula = Salary ~ ., data = dataset)
summary(lin_reg)
#here we see that level is not a bad predictor but the significance is 3.83% instead of <1%
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
dataset$Level4 <- dataset$Level^4
poly_reg = lm(formula = Salary ~ ., data=dataset)
summary(poly_reg)
#visualising the linar regression results 
ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red') + 
geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),colour = 'blue') + 
  ggtitle('Truth or Bluff (Linear Regression)') + xlab('Level') + ylab('Salary')
#here we see that the error is much higher for higher levels and we are getting errors for 
#almost every level. It is not fitting the data points well. Hence we need to use a polynomial
#regression model 
#visualising the polynomial regression results 
ggplot() + geom_point(aes(x=dataset$Level, y=dataset$Salary), colour='red') +
  geom_line(aes(x=dataset$Level, y=predict(poly_reg, newdata=dataset)), colour='blue')+
  ggtitle('Truth or Bluff (Polynomial Regression)') +xlab('Salary') + ylab('Salary')
#Here we see that the salary fits well for data points and there is less error
y_pred = predict(lin_reg, newdata = data.frame(Level=6.5))
y_pred
#predicting the new observation with linear regression 
y_pred = predict(poly_reg, newdata = data.frame(Level=6.5,Level2=6.5^2,Level3=6.5^3,Level4=6.5^4))
y_pred
