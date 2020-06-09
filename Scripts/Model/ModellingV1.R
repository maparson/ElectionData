#----------------------#
# Modelling file -main #
#----------------------#

require(lme4)

#----------------------#
# Model 1 - Income overall
#----------------------#
# Method: Logistic -  regression
# Input : 2015 election results by FED - overall
#         2015 mean incomes
# Outpt : Coefficients for income
#----------------------#

model1 <- lmer(data = dat_results_demog3_2015_overall,
               MeanIncome ~ party | province)

#----------------------#
# Model 2 - Income - individual
#----------------------#
# Method: Logistic regression
# Input : 2015 election results by FED - individual
#         2015 mean incomes
# Outpt : Coefficients for income
#----------------------#

model2 <- glm(data = dat_results_demog3_2015_individual %>% replace(is.na(.), 0),
               MeanIncome ~ CON + LIB + NDP + GR + BQ)

