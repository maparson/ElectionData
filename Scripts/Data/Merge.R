#-------------------------#
# Merge - demog & results #
#-------------------------#

# Merge 2015 overall results and 2015 income estimates.

dat_results_demog3_2015_overall <- dat_results_2015_overall %>%
  left_join(dat_demog3, by = c("districtno" = "FED ID")) %>%
  dplyr::select(province, district, districtno,
         pop, electors, valid, total, turnout,
         winner, party, MeanIncome)

# Merge 2015 individual results and 2015 income estimates.

dat_results_demog3_2015_individual <- dat_results_2015_individual %>%
  left_join(dat_demog3, by = c("districtno" = "FED ID")) 
