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
    "grey")       # Independent

parties_federal_abv <-
  c("BQ", "CON", "GRN", "LIB", "NDP", "IND")

#--------------------------------------------#
# Set other graphical parameters

param_annotate_size <- 5  # The size of the text used to label the regions in hex maps

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

map_ab_ed_cent <- tibble(rownames(coordinates(map_ab_ed)), 
                         coordinates(map_ab_ed)[,1],
                         coordinates(map_ab_ed)[,2])
colnames(map_ab_ed_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_ab_ed_dat <- tibble(fortify(map_ab_ed)) %>% left_join(index_ed, by = c("id" = "FED"))

## Get centroids
map_ab_ed_cent <- coordinates(map_ab_ed)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_ab_ed_dat_labels <- tibble(FED = rownames(map_ab_ed_cent),
#                                lat = map_ab_ed_cent[,1],
#                                long = map_ab_ed_cent[,2])

gg_ab_ed <- ggplot(map_ab_ed_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_ab_ed_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()


#--------------------------------------------#
# Test of my grid map function
# British Columbia
#--------------------------------------------#

## Vancouver ## 

map_bc_vc <- hex.draw.coord(index_vc$x, index_vc$y, labl = index_vc$FED)
rownames(index_vc) <- index_vc$FED

map_bc_vc_cent <- tibble(rownames(coordinates(map_bc_vc)), 
                         coordinates(map_bc_vc)[,1],
                         coordinates(map_bc_vc)[,2])
colnames(map_bc_vc_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_bc_vc_dat <- tibble(fortify(map_bc_vc)) %>% left_join(index_vc, by = c("id" = "FED"))

## Get centroids
map_bc_vc_cent <- coordinates(map_bc_vc)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_bc_vc_dat_labels <- tibble(FED = rownames(map_bc_vc_cent),
#                                lat = map_bc_vc_cent[,1],
#                                long = map_bc_vc_cent[,2])

gg_bc_vc <- ggplot(map_bc_vc_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_bc_vc_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()


## Lower Mainland ## 

map_bc_lm <- hex.draw.coord(index_lm$x, index_lm$y, labl = index_lm$FED)
rownames(index_lm) <- index_lm$FED

map_bc_lm_cent <- tibble(rownames(coordinates(map_bc_lm)), 
                         coordinates(map_bc_lm)[,1],
                         coordinates(map_bc_lm)[,2])
colnames(map_bc_lm_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_bc_lm_dat <- tibble(fortify(map_bc_lm)) %>% left_join(index_lm, by = c("id" = "FED"))

## Get centroids
map_bc_lm_cent <- coordinates(map_bc_lm)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_bc_lm_dat_labels <- tibble(FED = rownames(map_bc_lm_cent),
#                                lat = map_bc_lm_cent[,1],
#                                long = map_bc_lm_cent[,2])

gg_bc_lm <- ggplot(map_bc_lm_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_bc_lm_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()


## Vancouver Island ## 

map_bc_vi <- hex.draw.coord(index_vi$x, index_vi$y, labl = index_vi$FED)
rownames(index_vi) <- index_vi$FED

map_bc_vi_cent <- tibble(rownames(coordinates(map_bc_vi)), 
                         coordinates(map_bc_vi)[,1],
                         coordinates(map_bc_vi)[,2])
colnames(map_bc_vi_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_bc_vi_dat <- tibble(fortify(map_bc_vi)) %>% left_join(index_vi, by = c("id" = "FED"))

## Get centroids
map_bc_vi_cent <- coordinates(map_bc_vi)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_bc_vi_dat_labels <- tibble(FED = rownames(map_bc_vi_cent),
#                                lat = map_bc_vi_cent[,1],
#                                long = map_bc_vi_cent[,2])

gg_bc_vi <- ggplot(map_bc_vi_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_bc_vi_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()


## BC Interior ## 

map_bc_in <- hex.draw.coord(index_in$x, index_in$y, labl = index_in$FED)
rownames(index_in) <- index_in$FED

map_bc_in_cent <- tibble(rownames(coordinates(map_bc_in)), 
                         coordinates(map_bc_in)[,1],
                         coordinates(map_bc_in)[,2])
colnames(map_bc_in_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_bc_in_dat <- tibble(fortify(map_bc_in)) %>% left_join(index_in, by = c("id" = "FED"))

## Get centroids
map_bc_in_cent <- coordinates(map_bc_in)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_bc_in_dat_labels <- tibble(FED = rownames(map_bc_in_cent),
#                                lat = map_bc_in_cent[,1],
#                                long = map_bc_in_cent[,2])

gg_bc_in <- ggplot(map_bc_in_dat) + 
  geom_polygon(aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_bc_in_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  coord_equal()




## Merge BC together ## 

map_bc <- hex.draw.coord(index_bc$x, index_bc$y, labl = index_bc$FED)
rownames(index_bc) <- index_bc$FED

map_bc_cent <- tibble(rownames(coordinates(map_bc)), 
                         coordinates(map_bc)[,1],
                         coordinates(map_bc)[,2])
colnames(map_bc_cent) <- c("FED", "lat", "long")

## Get data frame for shapefile
map_bc_dat <- tibble(fortify(map_bc)) %>% left_join(index_bc, by = c("id" = "FED"))

## Get centroids
map_bc_cent <- coordinates(map_bc)

## Get labels at the centroid coordinates
## NOT WORKING YET ##
## Also not necessary? ##
# map_bc_dat_labels <- tibble(FED = rownames(map_bc_cent),
#                                lat = map_bc_cent[,1],
#                                long = map_bc_cent[,2])

gg_bc <- ggplot() + 
  geom_polygon(data = map_bc_dat,
               aes(x = long, y = lat, group = id, fill = PARTY), 
               colour = "white", size = 1) + 
  # geom_text(data = map_bc_dat_labels,
  #           aes(x = long, y = lat, label = FED, group = FED),
  #           colour = "white", size = 3) +
  geom_sf(data = as(aggregate(map_bc), "sf"),
          fill = NA,
          colour = "white") +
  scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
  theme_void() +
  labs(fill = "") +
  annotate("text", x = 6, y = 19, label = "Vancouver Island\n & Central Coast", size = param_annotate_size) +
  annotate("text", x = 7.5, y = 10.5, label = "Central\n Vancouver", size = param_annotate_size) +
  annotate("text", x = 10.5, y = 13, label = "Interior\n & North", size = param_annotate_size) +
  annotate("text", x = 15, y = 9.5, label = "Lower\n Mainland", size = param_annotate_size) +
  coord_sf()


