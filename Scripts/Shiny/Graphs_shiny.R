#----------------------#
# R Shiny - Test App   #
#----------------------#

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

library(shiny)
library(dplyr)
library(ggplot2)

source("./Scripts/Data/Load_polls.R")

ui <- fluidPage(
  fluidRow(column(3, align = "center",
    selectInput('RegionChoice', 'Region', 
                choices = unique(dat_poll_fed$Region),
                selected = "CAN",
                multiple = FALSE)),
    column(9, headerPanel('Federal Voting Intentions'))
  ), 
  plotOutput('plot1',
               hover = hoverOpts(id = "plot_hover"))
)
server <- function(input, output) {
  
  selectedData <- reactive({
    dat_poll_fed %>% filter(Region == input$RegionChoice)
  })

  output$plot1 <- renderPlot({
    
    ggplot(data = selectedData(),
                          aes(group = ID, colour = Party, x = Date, y = Vote)) +
      geom_point(size = 3.5, 
                 position = position_jitter(width=10000), # This jitter helps diff. btwn ties
                 alpha = 0.5) + 
      geom_spline(aes(group = Party), spar = 0.5,
                  size = 1, alpha = 0.5) +
      scale_colour_manual(limits = parties_federal_abv_oth, values = colours_federal) +
      theme_minimal(base_size = 15) +
      theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
      scale_x_datetime(date_labels = "%d %h") +
      xlab("") +
      ylab("%") +
      ylim(c(0,NA))

  })

}

shinyApp(ui = ui, server = server)