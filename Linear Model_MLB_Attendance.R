library(tidyverse)
library(broom)
library(Lahman)

Teams_small <- Teams %>% 
  filter(yearID %in% 1961:2001) %>% 
  mutate(avg_attendance = attendance/G, avg_R = R/G, avg_HR = HR/G)
  
lm(avg_attendance ~ avg_R, data = Teams_small)
lm(avg_attendance ~ avg_HR, data = Teams_small)
lm(avg_attendance ~ W, data = Teams_small)
lm(avg_attendance ~ yearID, data = Teams_small)

Team_W <- Teams_small %>% mutate(W_stra = round(W/10)) %>% 
  filter(W_stra >= 5 & W_stra <= 10) %>% 
  group_by(W_stra) %>%
  do(tidy(lm(avg_attendance ~ avg_HR, data = . ))) %>%
  filter(term == "avg_HR")

Teams_2002 <- Teams %>% filter(yearID == 2002) %>% 
  mutate(avg_attendance = attendance/G, avg_R = R/G, avg_HR = HR/G)


mod <- Teams_small %>% lm(avg_attendance ~ avg_R + avg_HR + W + yearID, data = .)
Att_predict <- predict(mod, newdata = Teams_2002)
cor(Att_predict, Teams_2002$avg_attendance)