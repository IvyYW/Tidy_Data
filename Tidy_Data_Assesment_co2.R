library(tidyverse)
library(dslabs)

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997)) 

co2_tidy <- co2_wide %>% gather(month, co2, -year)
co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()
