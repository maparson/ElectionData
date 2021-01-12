#----------------------#
# Load - polls         #
#----------------------#

#----------------------#
# Get the federal polling data
#----------------------#

#----------------------#
# Load the raw data
#----------------------#

dat_poll_fed_raw <- read_xlsx("./Data/Polls/federal.xlsx") 


# Get the weighted federal averages

dat_poll_fed_raw <- dat_poll_fed_raw  

## Filter out the parties that are not LIB, CON, NDP, GRN, BQ

dat_poll_fed <- dat_poll_fed_raw %>%
  mutate(notmain = if_else(Party %in% parties_federal == FALSE, 1, 0)) %>%
  group_by(ID, Region) %>%
  mutate(othervote = if_else(notmain == 1, sum(Vote*notmain, na.rm = TRUE), 0)) %>%
  filter(Party %in% parties_federal | Party == "OTH") %>%
  mutate(Vote = if_else(notmain == 1, othervote, Vote)) %>%
  ungroup() %>% dplyr::select(-notmain, -othervote)
  
