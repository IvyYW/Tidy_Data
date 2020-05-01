library(caret)
library(dslabs)
library(tidyverse)
library(genefilter)

set.seed(1996, sample.kind="Rounding") #if you are using R 3.6 or later
n <- 1000
p <- 10000
x <- matrix(rnorm(n*p), n, p)
colnames(x) <- paste("x", 1:ncol(x), sep = "_")
y <- rbinom(n, 1, 0.5) %>% factor()

tt <- colttests(x, y)

tt_sig <- tt[which(tt$p.value <0.01),]
x_sig <- row.names(tt_sig)
x_subset <- x [, x_sig]

fit <- train(x_subset, y, method = "knn", tuneGrid = data.frame(k = seq(101, 301, 25)))
ggplot(fit)