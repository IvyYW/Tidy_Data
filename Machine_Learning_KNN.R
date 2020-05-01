library(caret)
library(tidyverse)
library(dslabs)

set.seed(1, sample.kind="Rounding") 

y <- heights$sex
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)

test_set <- heights %>% slice(test_index)
train_set <- heights %>% slice(-test_index)

k <- seq(1, 101, 3)
F_1 <- c(1:length(k))

f <- 1

for (i in k ){
  knn_fit <- knn3(sex ~ ., data = train_set, k = i)
  y_hat <- predict(knn_fit, newdata = test_set, type = "class")
  F_1[f] <- F_meas(y_hat, test_set$sex)
  f <- f+1
}

max(F_1)
k[which.max(F_1)]

