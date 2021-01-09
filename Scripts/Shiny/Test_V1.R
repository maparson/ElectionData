#----------------------#
# R Shiny - Test App   #
#----------------------#

# 01-kmeans-app

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

library(shiny)

ui <- fluidPage(
  headerPanel('British Columbia Electoral Map'),
  sidebarPanel(
    selectInput('party', 'Party', 
                choices = parties_federal_abv,
                selected = parties_federal_abv,
                multiple = TRUE),
    selectInput('region', 'Region', 
                choices = unique(map_bc_dat$R),
                selected = unique(map_bc_dat$R),
                multiple = TRUE)
  ),
  mainPanel(
    plotOutput('plot1',
    hover = hoverOpts(id = "plot_hover")
    ),
    plotOutput('plot2')
  )
)

server <- function(input, output) {
  
  selectedData <- reactive({
    map_bc_dat %>% filter(PARTY %in% input$party & R %in% input$region)
  })

  output$plot1 <- renderPlot({
    ggplot() + 
    geom_polygon_interactive(data = selectedData(),
                 aes(x = long, y = lat, group = id, fill = PARTY,
                     data_id = id), 
                 colour = "white", size = 1) + 
    scale_fill_manual(limits = parties_federal_abv, values = colours_federal) +
    theme_void() +
    coord_sf()
  })
  
  output$plot2 <- renderPlot({
    ggplot(Shp.Can2 %>% filter(grepl("British", PRNAME))) + geom_sf()
  })
  
  output$hover_info <- renderPrint({
    cat("input$plot_hover$id:\n")
    str(input$plot_hover)
  })
}

shinyApp(ui = ui, server = server)