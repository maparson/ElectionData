#----------------------------#
# Make html grid map         #
#----------------------------#

require(plotly)

source("./Scripts/Admin/Packages.R")
source("./Scripts/Admin/Custom_Functions.R")
source("./Scripts/Data/Load_results.R")
source("./Scripts/Graphs/Map.R")
source("./Scripts/Graphs/Graph.R")

#-----------------------#
# Make map              #
#-----------------------#

## Practice Edmonton map

### Remove axis lines
ax <- list(
  title = "",
  zeroline = FALSE,
  showline = FALSE,
  showticklabels = FALSE,
  showgrid = FALSE
)

### Make the plot
plotly_ab_ed <- ggplotly(gg_ab_ed) %>%
  layout(xaxis = ax, yaxis = ax)















