library(tidyverse)

path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename)
select(raw_dat, 1:5)

dat <- raw_dat %>% gather(key, value, -country)
dat %>% separate(key, c("year", "variable_name"), sep = "_", extra = "merge") %>% 
  spread(variable_name, value)
