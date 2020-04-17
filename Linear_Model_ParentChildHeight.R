library(tidyverse)
library(HistData)
library(broom)
data("GaltonFamilies")
set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later

galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

get_slope <- function(data){
  fit <- lm(childHeight ~ parentHeight, data = data)
  data.frame(slope = fit$coefficients[2], 
             se = summary(fit)$coefficient[2,2])
}

get_lse <- function(data){
  fit <- lm(childHeight ~ parentHeight, data = data)
  data.frame(term = names(fit$coefficients),
             slope = fit$coefficients, 
             se = summary(fit)$coefficient[,2])
}

dat <- galton %>% group_by(pair) %>% 
  do(tidy(lm(childHeight ~ parentHeight, data =.), conf.int = TRUE)) %>% 
  filter(term == "parentHeight")

dat %>% ggplot(aes(pair, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_errorbar()+
  geom_point()