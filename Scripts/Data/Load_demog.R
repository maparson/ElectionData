#----------------------#
# Load - demog         #
#----------------------#

## Get the FED profiles

dat_demog1_raw <- read_csv("./Data/Demographic/98-400-X2016243_ENG_CSV/98-400-X2016243_English_CSV_data.csv")
dat_demog2_raw <- read_csv("./Data/Demographic/98-401-X2016045_eng_CSV/98-401-X2016045_English_CSV_data.csv")
dat_demog3_raw <- read_csv("./Data/Demographic/Income/table1a-eng.csv")

## DAT_DEMOG 3
## INCOME TAX RETURNS

dat_demog3 <- dat_demog3_raw %>%
  dplyr::select(-starts_with("X")) %>%
  drop_na() %>%
  mutate(MeanIncome = round(`Total Income` / Total, 2))






