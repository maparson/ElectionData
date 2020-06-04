#----------------------#
# Graph file - Federal #
#----------------------#

#--------------------------------------------#
# Get the parameters

colours_federal <-
  c("steelblue1", # Bloc Quebecois
    "royalblue4", # Conservatives
    "green3",     # Greens
    "red3",       # Liberal
    "orange2")    # NDP)

#--------------------------------------------#
# Map T1: Simple first try.
# Simple 
#--------------------------------------------#

Dat.T1 <- Shp.Can2 %>%
  left_join(dat2015, by = "FEDUID")

Graph.T1 <- ggplot(data = Dat.T1,
                   aes(fill = party)) +
  geom_sf(lwd = 0) +
  scale_fill_manual(values = colours_federal) + 
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        rect = element_blank())
  

#--------------------------------------------#
# Test of geogrid.
#--------------------------------------------#
# 
# Shp.Hex1 <- calculate_grid(shape = Shp.Can2,
#                            grid_type = "hexagon",
#                            seed = 1)



