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

#Backward elimination

regressor <- lm(formula = Profit~R.D.Spend + Administration + Marketing.Spend + State, data = dataset) 
#Replacing training_set with dataset is optional
#We are just doing it to get an insight of the entire data
summary(regressor)

#Removing the state independent variable since it has the highest p value
#The lower the P value, the better the variable is 
regressor <- lm(formula = Profit~R.D.Spend + Administration + Marketing.Spend, data = dataset) 
summary(regressor)
#Removing the Administration independent variable since it has the highest p value

regressor <- lm(formula = Profit~R.D.Spend + Marketing.Spend, data = dataset) 
summary(regressor)
#Now we see that Marketing spend is 6% significant but this is not the final word as setting significance level to 5% was an arbitrary choice. We have better parameters to assist us with the decision but since we have set the significance level to 5%, we will remove marketing spend from our model
regressor = lm(formula = Profit ~ R.D.Spend, data=training_set)
summary(regressor)
