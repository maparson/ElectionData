#----------------------------#
# Province by province grids #
#----------------------------#

#---------#
# Alberta #
#---------#

index_ab <- tribble(
  ~x, ~y, ~R,  ~FED,
  
  2,  1,  "So",  "Medicine Hat - Cardston - Warner",
  1,  1,  "So",  "Foothills",
  2,  2,  "So",  "Lethbridge",
  3,  1,  "So",  "Bow River",
   
  1,  3,  "Ca",  "Calgary - Heritage",
  2,  3,  "Ca",  "Calgary - Midnapore",
  3,  2,  "Ca",  "Calgary - Shepard",
   
)

# Edmonton

index_ed <- tribble(
   ~x, ~y, ~R,  ~PARTY,  ~FED,
   
   1,  1,  "ED",  "CON",  "Edmonton Riverbend",  
   1,  2,  "ED",  "CON",  "Edmonton West",
   2,  1,  "ED",  "CON",  "Edmonton - Wetaskiwin",
   2,  2,  "ED",  "NDP",  "Edmonton Strathcona",
   3,  1,  "ED",  "CON",  "Edmonton Millwoods",
   3,  2,  "ED",  "CON",  "Sherwood Park - Fort Saskatchewan",
   2,  3,  "ED",  "CON",  "Edmonton Centre",
   1,  3,  "ED",  "CON",  "St. Albert - Edmonton",
   2,  4,  "ED",  "CON",  "Edmonton Griesbach",
   3,  3,  "ED",  "CON",  "Edmonton Manning"
   
)

#------------------#
# British Columbia #
#------------------#

# Vancouver

index_vc <- tribble(
   ~x, ~y, ~R,  ~PARTY,  ~FED,
   
   1,  2,  "VC",  "LIB",  "Vancouver Quadra",
   2,  2,  "VC",  "IND",  "Vancouver Granville",
   2,  3,  "VC",  "LIB",  "Vancouver Centre",
   3,  1,  "VC",  "LIB",  "Vancouver South",
   3,  2,  "VC",  "NDP",  "Vancouver Kingsway",
   3,  3,  "VC",  "NDP",  "Vancouver East",
   1,  1,  "VC",  "CON",  "Richmond Centre",
   2,  1,  "VC",  "CON",  "Steveston - Richmond East",
   4,  1,  "VC",  "NDP",  "New Westminster - Burnaby",
   4,  2,  "VC",  "NDP",  "Burnaby South",
   2,  4,  "VC",  "LIB",  "North Vancouver",
   4,  3,  "VC",  "LIB",  "Burnaby North - Seymour", 
   1,  3,  "VC",  "LIB",  "West Vancouver - Sunshine Coast - Sea to Sky Country"
   
)

# Lower mainland

index_lm <- tribble(
   ~x, ~y, ~R,  ~PARTY,  ~FED,
   
   1,  2,  "LM",  "LIB",  "Delta",
   2,  4,  "LM",  "LIB",  "Surrey Centre",
   3,  4,  "LM",  "LIB",  "Fleetwood - Port Kells", 
   2,  5,  "LM",  "CON",  "Port Moody - Coquitlam",
   2,  3,  "LM",  "LIB",  "Surrey - Newton",
   2,  2,  "LM",  "CON",  "South Surrey - White Rock",
   3,  3,  "LM",  "CON",  "Cloverdale - Langley City",
   3,  2,  "LM",  "CON",  "Langley - Aldergrove",
   4,  4,  "LM",  "LIB",  "Coquitlam - Port Coquitlam",
   4,  3,  "LM",  "CON",  "Pitt Meadows - Maple Ridge",
   4,  2,  "LM",  "CON",  "Abbotsford",
   5,  2,  "LM",  "CON",  "Mission - Matsqui - Fraser Canyon",
   5,  1,  "LM",  "CON",  "Chilliwack - Hope"
)

# Vancouver Island

index_vi <- tribble(
   ~x, ~y, ~R,  ~PARTY,  ~FED,
   
   1,  3,  "VI",  "NDP",  "Courtenay - Alberni",
   1,  4,  "VI",  "NDP",  "North Island - Powell River",
   2,  1,  "VI",  "NDP",  "Esquimalt - Saanich - Sooke",
   2,  2,  "VI",  "NDP",  "Cowichan - Malahat - Langford",
   2,  3,  "VI",  "GRN",  "Nanaimo - Ladysmith",
   3,  1,  "VI",  "NDP",  "Victoria",
   3,  2,  "VI",  "GRN",  "Saanich - Gulf Islands"
   
)

# Interior

index_in <- tribble(
   ~x, ~y, ~R,  ~PARTY,  ~FED,
   
   2,  3,  "IN",  "CON",  "Kamloops - Thompson - Cariboo",
   2,  4,  "IN",  "CON",  "Cariboo - Prince George",
   2,  5,  "IN",  "NDP",  "Skeena - Bulkley Valley",
   3,  1,  "IN",  "CON",  "Central Okanagan - Similkameen - Nicola",
   3,  2,  "IN",  "CON",  "Kelowna - Lake Country",
   3,  3,  "IN",  "CON",  "North Okanagan - Shuswap",
   3,  4,  "IN",  "CON",  "Prince George - Peace River - Northern Rockies",
   4,  2,  "IN",  "NDP",  "South Okanagan - West Kootenay",
   4,  3,  "IN",  "CON",  "Kootenay - Columbia"
   
)

# Merge BC together #

index_bc <- (index_lm %>% mutate(x = x + 6)) %>%
   add_row(index_vc %>% mutate(y = y + 2,
                               x = x + 0)) %>%
   add_row(index_in %>% mutate(y = y + 6,
                               x = x + 6)) %>%
   add_row(index_vi %>% mutate(y = y + 7,
                               x = x + 0))
   

