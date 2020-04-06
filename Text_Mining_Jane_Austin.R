library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

id <- gutenberg_works(languages = "en", title == "Pride and Prejudice") 
words <- gutenberg_download(id) %>% unnest_tokens(word, text)  %>%
  filter(!word %in% stop_words$word & !str_detect(word, "\\d+")) 

words %>% group_by(word) %>% summarise(n = n()) %>% filter (n>100) %>% arrange(desc(n)) 

afinn <- get_sentiments("afinn")

afinn_sentiments <- inner_join(words, afinn)
afinn_sentiments %>% filter(value > 0)