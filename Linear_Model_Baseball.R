library(Lahman)

bat_02 <- Batting %>% filter(yearID == 2002) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  select(playerID, singles, bb)

bat_01 <- Batting %>% filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) %>%
  select(playerID, singles, bb) %>%
  group_by(playerID) %>%
  summarise(mean_single = mean(singles), mean_bb = mean(bb))

fit_s <- lm(singles ~ mean_single, bat)
summary(fit_s)

fit_b <- lm(bb ~ mean_bb, bat)
summary(fit_b)
