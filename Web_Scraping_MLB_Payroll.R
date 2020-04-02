library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

nodes <- html_nodes(h, "table")

tab_1 <- html_table(nodes[[10]]) 
tab_1 <- tab_1 [-1,]
tab_1 <- tab_1 %>% select(X2, X3, X4) %>% setNames(c("Team", "Payroll", "Average"))

tab_2 <- html_table(nodes[[19]])
tab_2 <- tab_2 [-1,]
tab_2 <- tab_2 %>% setNames(c("Team", "Payroll", "Average"))

tab_1_2 <- full_join(tab_1, tab_2, by = "Team")
tab_1_2

