set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")

female_heights <- GaltonFamilies%>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

m_m <- mean(female_heights$mother)
m_sd <- sd(female_heights$mother)
d_m <- mean(female_heights$daughter)
d_sd <- sd(female_heights$daughter)
corr <- cor(female_heights$mother, female_heights$daughter)
m <- corr* d_sd/m_sd
b <- d_m - m*m_m