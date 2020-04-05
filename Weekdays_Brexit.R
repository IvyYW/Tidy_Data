library(dslabs)
library(lubridate)
options(digits = 3) 

data(brexit_polls) 

sum(month(brexit_polls$startdate) == 4)
sum(round_date(brexit_polls$enddate, unit = "week") == "2016-06-12") 

brexit_polls %>% mutate(weekday = weekdays(enddate)) %>% group_by(weekday) %>% summarise(n())