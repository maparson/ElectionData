#----------------------#
# Graph file - Federal #
#----------------------#

#--------------------------------------------#
# Get the parameters

colours_federal <-
  c("steelblue1", # Bloc Quebecois
    "royalblue4", # Conservatives
    "green3",     # Greens
    "red3",       # Liberals
    "orange2",    # NDP
    "grey")       # Independent/Other


parties_federal_abv <-
  c("BQ", "CON", "GRN", "LIB", "NDP", "IND")

parties_federal_abv_oth <-
  c("BQ", "CON", "GRN", "LIB", "NDP", "OTH")

#--------------------------------------------#

# Subset the data to use for the graphs.

dat_poll_fed_gg <- dat_poll_fed %>%
  filter(Region == "CAN")

npolls = length(unique(dat_poll_fed_gg$ID))

#--------------------------------------------#

# Get the graph of federal polling over time
## (need the polling data loaded for this)

gg_fed_line <- ggplot(data = dat_poll_fed_gg,
                      aes(group = ID, colour = Party, x = Date, y = Vote)) +
  geom_point(size = 3, 
             position = position_jitter(width=10000), # This jitter helps diff. btwn ties
             alpha = 0.5) + 
  geom_smooth(aes(group = Party), method = "loess", se = FALSE,
              span = 31*2) +
  scale_colour_manual(limits = parties_federal_abv_oth, values = colours_federal) +
  theme_minimal() +
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
  scale_x_datetime(date_labels = "%d %h") +
  xlab("") +
  ylab("%") +
  ylim(c(0,NA))










