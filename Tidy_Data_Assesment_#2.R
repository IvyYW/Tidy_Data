library(tidyverse)
library(dslabs)

data(admissions)

dat <- admissions %>% select(-applicants)

dat_tidy <- dat %>% spread(gender, admitted) 

tmp <- gather(admissions, key, value, admitted:applicants)
tmp2 <- unite(tmp, column_name, c(gender, key))
tmp2