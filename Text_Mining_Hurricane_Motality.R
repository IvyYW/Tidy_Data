library(tidyverse)
library(pdftools)
options(digits = 3) 

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
txt <- pdf_text(fn)
x <- txt[[9]] %>% str_split("\n")
s <- x[[1]]
s <- str_trim(s)
header_index <- str_which(s, "2015")
head_row <- str_split(s[2], "\\s+", simplify = FALSE)
month <- head_row[[1]][1]
header <- head_row[[1]][2:5]

tail_index <- str_which(s, "Total")
n <- str_count(s, "\\d+")
ind <- which(n %in% 1)

rm_index <- c(1:header_index[1], ind, tail_index:length(s))
s <- s[-rm_index]
s <- str_remove_all(s, "[^\\d\\s]")
s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
colnames(s) <- c("day", header)
class(s) <- "numeric"
tab <- as.data.frame(s)

tab <- tab %>% gather(year, deaths, -day) %>%
  mutate(deaths = as.numeric(deaths))
tab

tab %>% ggplot(aes(day, deaths, color = year)) + geom_line() + geom_vline(xintercept = 20)



