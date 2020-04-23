library(caret)
library(purrr)
data(iris)
iris <- iris[-which(iris$Species=='setosa'),]
y <- iris$Species

set.seed(2, sample.kind="Rounding")
test_index <- createDataPartition(y, times=1, list = FALSE)
test <- iris[test_index, ]
train <- iris[-test_index, ]

cutoff <- seq(min(train$Petal.Length), max(train$Petal.Length), 0.1)
acc <- function(x){
  y_hat <- ifelse(train$Petal.Length > x, "virginica", "versicolor") %>% 
    factor(levels = levels(train$Species))
  mean(y_hat == train$Species)
}
accuracy <- sapply(cutoff, acc)   
cutoff_PL <- cutoff[which.max(accuracy)]

cutoff <- seq(min(train$Petal.Width), max(train$Petal.Width), 0.1)
acc <- function(x){
  y_hat <- ifelse(train$Petal.Width > x, "virginica", "versicolor") %>% 
  factor(levels = levels(train$Species))
  mean(y_hat == train$Species)
  }
accuracy <- sapply(cutoff, acc)   
cutoff_PW <- cutoff[which.max(accuracy)]

y_hat_max <- ifelse(test$Petal.Length > cutoff_PL | test$Petal.Width > cutoff_PW, "virginica", "versicolor") %>%
  factor(levels = levels(test$Species))
mean(y_hat_max == test$Species)


    
