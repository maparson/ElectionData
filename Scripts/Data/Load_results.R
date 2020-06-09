#----------------------#
# Load - results       #
#----------------------#

#----------------------#
## Get the federal election results for 2015
#----------------------#

#----------------------#
# Load the raw data
#----------------------#

### This looks just at the winners & total votes cast

dat_results_2015_raw <- read_csv("./Data/Results/2015_federal_overall.csv", # manually change the variable names
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

### This looks at each candidate's performance by riding, regardless of winning or not.

dat_results_2015_individual_raw <- read_csv("./Data/Results/2015_federal_individual.csv") 

colnames(dat_results_2015_individual_raw) <- if_else(grepl("/",colnames(dat_results_2015_individual_raw)),
                                                     substr(colnames(dat_results_2015_individual_raw), 
                                                            1, 
                                                            gregexpr("/", 
                                                                     colnames(dat_results_2015_individual_raw))),
                                                     colnames(dat_results_2015_individual_raw))

colnames(dat_results_2015_individual_raw) <- gsub("[ ]?[//]", "", colnames(dat_results_2015_individual_raw))


#----------------------#
# Clean the data
#----------------------#

dat_results_2015_overall <- dat_results_2015_raw %>%
  mutate(party = substr(dat_results_2015_raw$winner, 
                        regexpr("/", dat_results_2015_raw$winner)+1, 
                        length(dat_results_2015_raw$winner))) %>%
  mutate(party = recode(party, 
                        `Bloc Québécois` = "BQ",
                        `Conservateur` = "CON",
                        `Libéral` = "LIB",
                        `NPD-Nouveau Parti démocratique` = "NDP",
                        `Parti Vert` = "GR")) %>%
  mutate(FEDUID = as.factor(districtno))

dat_results_2015_individual <- dat_results_2015_individual_raw %>%
  mutate(party = substr(Candidate, 
                        regexpr("/", Candidate)+1, 
                        length(dat_results_2015_individual_raw$Candidate))) %>%
  mutate(party = case_when(
    party == "Bloc Québécois" ~ "BQ",
    party == "Conservateur" ~ "CON",
    party == "Libéral" ~ "LIB",
    party == "NPD-Nouveau Parti démocratique" ~ "NDP",
    party == "Parti Vert" ~ "GR",
    party == "Indépendant" ~ "IND",
    TRUE ~ "OTH")) %>%
  dplyr::select(Province, `Electoral District Number`, party, `Votes Obtained`) %>%
  group_by(`Electoral District Number`, party) %>%
  summarise(votes = sum(`Votes Obtained`)) %>% ungroup() %>%
  pivot_wider(names_from = party,
              values_from = votes) %>%
  rename(districtno = `Electoral District Number`)





