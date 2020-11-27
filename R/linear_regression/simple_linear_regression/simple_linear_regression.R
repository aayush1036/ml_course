dataset <- read.csv('Salary_Data.csv')
library(caTools)
set.seed(123)
split <- sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split==T)
test_set = subset(dataset, split==F)

regressor <- lm(formula=Salary~YearsExperience, data = training_set)
#Here we use the linear model function from R which builds a model on the basis of 
#The formula which we specify (here salary is a linear relation of YearsExperience) and the 
#dataset on whihc we wish to apply the model on 
summary(regressor)
# 3 stars ahead of the variable means that the variable is highly statstically significant
# The lower the P value is, the higher is the statistical significance
# Usually the threshold for p value is 5% or 0.05

y_pred <- predict(regressor, newdata = test_set)
y_pred
library(ggplot2)
ggplot()+geom_point(aes(x=training_set$YearsExperience, y=training_set$Salary),
                    colour = 'red')+
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor, training_set)), colour='blue')+
  ggtitle('Salary vs Experience for training set')+xlab('Years of experience')+
  ylab('Salary')


ggplot()+geom_point(aes(x=test_set$YearsExperience, y=test_set$Salary),
                    colour = 'red')+
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor, training_set)), colour='blue')+
  ggtitle('Salary vs Experience for test set')+xlab('Years of experience')+
  ylab('Salary')


