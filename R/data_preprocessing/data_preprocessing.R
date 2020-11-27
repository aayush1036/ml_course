dataset <- read.csv('Data.csv')
dataset$Age <- ifelse(is.na(dataset$Age), mean(dataset$Age, na.rm=T), dataset$Age)
# alternative way 
#dataset$Age <- replace(dataset$Age, c(is.na(dataset$Age)), mean(dataset$Age, na.rm=T))
dataset$Salary <-replace(dataset$Salary, c(is.na(dataset$Salary)), mean(dataset$Salary, na.rm=T))
dataset
dataset$Country <- factor(dataset$Country, levels = c('France', 'Spain', 'Germany'), labels=c(1,2,3))
dataset
dataset$Purchased <- factor(dataset$Purchased, levels = c('Yes', 'No'), labels=c(1,0))
dataset
install.packages('caTools')
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split==T)
test_set = subset(dataset, split==F)
training_set[2:3] <- scale(training_set[2:3])
test_set[2:3] <- scale(test_set[2:3])
training_set
