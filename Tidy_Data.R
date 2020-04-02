library(tidyverse)
library(dslabs)
data("gapminder")

tidy_data <- gapminder %>%
  filter(country %in% c("South Korea", "Germany")) %>%
  select(country, year, fertility)

path <- system.file("extdata", package="dslabs")
filename <- file.path(path,  "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

new_tidy_data <- wide_data %>% gather(year, fertility, -country, convert = TRUE)