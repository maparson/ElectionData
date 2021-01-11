# Map file.

# Load the shapefiles.

#Shp.Can1 <- st_read("./Data/Geographic/federal_electoral_districts_boundaries_2015_shp_en/FED_CA_2_2_ENG.shp")
Shp.Can2 <- st_read("./Data/Geographic/lfed000b16a_e/lfed000b16a_e.shp")

# Province name list.

prov_names <- tibble(
  full = unique(Shp.Can2$PRNAME),
  abbr = c("QC", "ON", "NL", "PEI", "NS", "NB", "AB", "MB", "SK", "BC", "YK", "NT", "NV")
)

# Get provincial simple provincial shapefiles.

for (num in unique(Shp.Can2$PRUID)) {
  
  temp.dat <- Shp.Can2 %>%
    filter(PRUID == num) 
  temp.abbr = prov_names[prov_names$full == unique(temp.dat$PRNAME),][,2]
  
  assign(paste0("Shp.", temp.abbr), temp.dat)
}
rm(list=ls(pattern="temp."))


# Get regional groups by province.

temp.completeprovs <- # List of completed provinces for regional groupings
  c("BC") 

for(prov in temp.completeprovs) {
  temp.dat1 <- 
    get(paste0("Shp.", prov))
  
  temp.dat2 <-  # change the dashes to match my riding names
    temp.dat1 %>%
    mutate(fedname = gsub("--", " - ", FEDENAME))
  
  temp.merge <- get(paste0("index_", tolower(prov))) # Get the groupings from Grids-province.R

  temp.dat3 <- # Merge to the Grids-province.R data
    temp.dat2 %>%
    left_join(temp.merge,
              by = c("fedname" = "FED"))
  
  temp.dat4 <- # Collapse along the regions
    temp.dat3 %>% group_by(R) %>% summarise()
  
  temp.dat5 <- # Smooth the regions
    smooth(drop_crumbs(temp.dat4, threshold = units::set_units(1000, km^2)), method = "chaikin")
    
  assign(paste0("Shp.", prov), temp.dat3)
  assign(paste0("Shp.", prov, ".Reg"), temp.dat4)
  assign(paste0("Shp.", prov, ".Reg.Sm"), temp.dat5)
}

rm(list=ls(pattern="temp."))










