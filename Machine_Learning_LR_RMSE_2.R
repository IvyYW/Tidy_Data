library(caret)
set.seed(1 , sample.kind="Rounding")

Sigma <- matrix(c(1.0, 0.75, 0.75, 0.75, 1.0, 0.95, 0.75, 0.95, 1.0), 3, 3)
dat <- MASS::mvrnorm(n = 100, c(0, 0, 0), Sigma) %>%
  data.frame() %>% setNames(c("y", "x_1", "x_2"))

y <- dat$y

set.seed(1 , sample.kind="Rounding")
test_ind <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
test_set <- dat %>% slice(test_ind)
train_set <- dat %>% slice(-test_ind)
  
fit_1 <- lm(y ~ x_1, data = train_set)
fit_2 <- lm(y ~ x_2, data = train_set)
fit_12 <- lm(y ~ x_1 + x_2, data = train_set)

y_hat_1 <- predict(fit_1, test_set)
y_hat_2 <- predict(fit_2, test_set)
y_hat_12 <- predict(fit_12, test_set)


sqrt(mean((y_hat_1 - test_set$y)^2))
sqrt(mean((y_hat_2 - test_set$y)^2))
sqrt(mean((y_hat_12 - test_set$y)^2))
  