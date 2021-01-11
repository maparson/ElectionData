#----------------------#
# R Shiny - Test App   #
#----------------------#

# 01-kmeans-app

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

library(shiny)

ui <- fluidPage(
  titlePanel('British Columbia Electoral Map'),
  
  fluidRow(ggiraph::ggiraphOutput("plot1"),
    plotOutput('plot2'))
)

server <- function(input, output) {

  output$plot1 <- renderggiraph({
    p <- ggplot() + 
    geom_polygon_interactive(data = map_bc_dat,
                 aes(x = long, y = lat, group = id, fill = PARTY,
                     tooltip = id, data_id = id), 
                 colour = "white", size = 1) + 
    scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
    theme_void() +
    coord_sf()
    
    girafe(code = print(p))
  })
  
  
  output$plot2 <- renderPlot({
    ggplot(Shp.BC.Reg.Sm) + 
      geom_sf() +
      theme_void() +
      theme(legend.position = "none")
  })

}

shinyApp(ui = ui, server = server)