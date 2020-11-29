dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]
library(e1071) #importing e1071 package as it contains svr and svm
regressor = svm(formula = Salary ~ ., data = dataset, type = 'eps-regression', kernel = 'radial')
#since we are making model for regression, we used eps classification (eps and nu both can be used) but eps is
#more common so we use eps 
#if we were making model for classification, we could have used c classification
#in short we use eps-regression for regression and c-classification for classification
# we are using radial kernel
y_pred = predict(regressor, data.frame(Level = 6.5))
y_pred
library(ggplot2)
ggplot() + geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),colour = 'blue') +
  ggtitle('Truth or Bluff (SVR)') + xlab('Level') + ylab('Salary')
#it predicts accurately for most of the observations but for level 10 it fails as level 10 is an outlier
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +geom_point(aes(x = dataset$Level, y = dataset$Salary),colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),colour = 'blue') +
  ggtitle('Truth or Bluff (SVR)') + xlab('Level') + ylab('Salary')
