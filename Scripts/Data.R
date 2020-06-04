# Data file

## Get the federal election results for 2015

dat2015_raw <- read_csv("./Data/Results/2015_election.csv",
                        col_names = c("province",
                                      "district",
                                      "districtno",
                                      "pop",
                                      "electors",
                                      "pollingstations",
                                      "valid",
                                      "valid_perc",
                                      "rej",
                                      "rej_perc",
                                      "total",
                                      "turnout",
                                      "winner"), skip = 1)

## Clean the data.

dat2015 <- dat2015_raw %>%
  mutate(party = substr(dat2015_raw$winner, 
                        regexpr("/", dat2015_raw$winner)+1, 
                        length(dat2015_raw$winner))) %>%
  mutate(party = recode(party, 
                        `Bloc Québécois` = "BQ",
                        `Conservateur` = "CON",
                        `Libéral` = "LIB",
                        `NPD-Nouveau Parti démocratique` = "NDP",
                        `Parti Vert` = "GR")) %>%
  mutate(FEDUID = as.factor(districtno))






