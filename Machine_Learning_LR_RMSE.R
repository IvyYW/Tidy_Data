library(caret)

createdata <- function(n){

Sigma <- 9*matrix(c(1.0, 0.5, 0.5, 1.0), 2, 2)
dat <- MASS::mvrnorm(n = n, c(69, 69), Sigma) %>%
  data.frame() %>% setNames(c("x", "y"))
y <- dat$y

B <- 100

result <- replicate(B, {
  test_ind <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
  test_set <- dat %>% slice(test_ind)
  train_set <- dat %>% slice(-test_ind)
  
  fit <- lm(y ~ x, data = train_set)
  y_hat <- predict(fit, test_set)
  sqrt(mean((y_hat - test_set$y)^2))
})

mean(result)

}

set.seed(1, sample.kind="Rounding")
n <- c(100, 500, 1000, 5000, 10000)
sapply(n, createdata)
