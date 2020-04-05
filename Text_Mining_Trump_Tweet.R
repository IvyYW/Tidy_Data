library(tidyverse)
library(ggplot2)
library(lubridate)
library(tidyr)
library(scales)
library(tidytext)
set.seed(1)

library(dslabs)
data("trump_tweets")

campaign_tweets <- trump_tweets %>% 
  extract(source, "source", "Twitter for (.*)") %>%
  filter(source %in% c("Android", "iPhone") &
           created_at >= ymd("2015-06-17") & 
           created_at < ymd("2016-11-08")) %>%
  filter(!is_retweet) %>%
  arrange(created_at)

pattern <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- campaign_tweets %>% 
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", ""))  %>%
  unnest_tokens(word, text, token = "regex", pattern = pattern) %>%
  filter(!word %in% stop_words$word &
           !str_detect(word, "^\\d+$")) %>%
  mutate(word = str_replace(word, "^'", "")) 

tweet_words %>% 
  count(word) %>%
  arrange(desc(n))

android_iphone_or <- tweet_words %>%
  count(word, source) %>%
  spread(source, n, fill = 0) %>%
  mutate(or = (Android + 0.5) / (sum(Android) - Android + 0.5) / 
           ( (iPhone + 0.5) / (sum(iPhone) - iPhone + 0.5)))

android_iphone_or %>% filter(Android+iPhone > 100) %>%
  arrange(desc(or))

