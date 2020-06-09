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
    "orange2")    # NDP)

parties_federal_abv <-
  c("BQ", "CON", "GRN", "LIB", "NDP")

#--------------------------------------------#
# Map T1: Simple first try.
# Simple 
#--------------------------------------------#

# Dat.T1 <- Shp.Can2 %>%
#   left_join(dat2015, by = "FEDUID")
# 
# Graph.T1 <- ggplot(data = Dat.T1,
#                    aes(fill = party)) +
#   geom_sf(lwd = 0) +
#   scale_fill_manual(values = colours_federal) + 
#   theme(axis.text.x = element_blank(),
#         axis.text.y = element_blank(),
#         axis.ticks = element_blank(),
#         rect = element_blank())
  

#--------------------------------------------#
# Test of my grid map function
# Edmonton
#--------------------------------------------#

map_ab_ed <- hex.draw.coord(index_ed$x, index_ed$y, labl = index_ed$FED)
rownames(index_ed) <- index_ed$FED

map_ab_ed_dat <- tibble(fortify(map_ab_ed)) %>% left_join(index_ed, by = c("id" = "FED"))
map_ab_ed_dat_labels <- map_ab_ed_dat %>%
  group_by(id) %>%
  summarise(long = mean(long),
            lat = mean(lat))

ggplot(map_ab_ed_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 2) + 
  geom_text(data = map_ab_ed_dat_labels,
            aes(x = long, y = lat, label = id, group = id),
            colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()




