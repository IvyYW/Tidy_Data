library(dslabs)
data("research_funding_rates")

two_by_two <- data.frame("Awarded" = c(sum(research_funding_rates$awards_men), sum(research_funding_rates$awards_women)),
                         "Not" =  c(sum(research_funding_rates$applications_men) - sum(research_funding_rates$awards_men), sum(research_funding_rates$applications_women) - sum(research_funding_rates$awards_women)))
rownames(two_by_two) <- c("Men", "Women")

two_by_two %>% chisq.test(.)

dat <- research_funding_rates %>% 
  mutate(discipline = reorder(discipline, success_rates_total)) %>%
  rename(success_total = success_rates_total,
         success_men = success_rates_men,
         success_women = success_rates_women) %>%
  gather(key, value, -discipline) %>%
  separate(key, c("type", "gender")) %>%
  spread(type, value) %>%
  filter(gender != "total")

dat %>% ggplot(aes(success, discipline, color = gender)) +
  geom_point()
