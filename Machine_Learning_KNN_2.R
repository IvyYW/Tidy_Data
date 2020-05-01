library(dslabs)
library(tidyverse)
library(caret)

data("tissue_gene_expression")

set.seed(1, sample.kind="Rounding") 

y <- tissue_gene_expression$y
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)

test_set<- list( x= tissue_gene_expression$x[test_index, ], y = tissue_gene_expression$y[test_index])
train_set<- list( x= tissue_gene_expression$x[-test_index, ], y = tissue_gene_expression$y[-test_index])

test_set <- as.data.frame(test_set)
train_set <- as.data.frame(train_set)

k <- c(1, 3, 5, 7, 9, 11)
acc <- c(1:6)
a <- 1

for (i in k){
  knn_fit <- knn3(y ~., data = train_set, k = i)
  y_hat <- predict(knn_fit, newdata = test_set, type = "class")
  acc[a] <- mean(y_hat == test_set$y)
  a <- a+1
}
