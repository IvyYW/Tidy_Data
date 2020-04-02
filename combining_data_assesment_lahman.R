library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10

top %>% as_tibble()

Master %>% as_tibble()

top_names <- top %>% left_join(Master)%>%
  select(playerID, nameFirst, nameLast, HR)

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  right_join(top_names)%>%
  select(nameFirst, nameLast, teamID, HR, salary)

Award_2016 <- AwardsPlayers %>% filter(yearID == 2016) 

inner_join(top_names, Award_2016) %>% distinct(playerID)
anti_join(Award_2016, top_names) %>% arrange(playerID) %>% distinct(playerID)
