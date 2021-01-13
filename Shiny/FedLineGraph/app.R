#--------------------------------#
# R Shiny - Federal Line Graph   #
#--------------------------------#

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

require(shiny)
require(httr)
require(openxlsx)
require(dplyr)
require(ggplot2)
require(lubridate)

# Get the parameters

colours_federal <-
    c("steelblue1", # Bloc Quebecois
      "royalblue4", # Conservatives
      "green3",     # Greens
      "red3",       # Liberals
      "orange2",    # NDP
      "grey")       # Independent/Other

parties_federal <-
    c("BQ", "CON", "GRN", "LIB", "NDP", "OTH")

# Load the data

dat_loaded_raw <- readWorkbook(
    loadWorkbook("https://github.com/maparson/ElectionData/blob/master/Data/Polls/federal.xlsx?raw=true")
)

dat_poll_fed <- tibble(dat_loaded_raw) %>%
    mutate(notmain = if_else(Party %in% parties_federal == FALSE, 1, 0)) %>%
    group_by(ID, Region) %>%
    mutate(othervote = if_else(notmain == 1, sum(Vote*notmain, na.rm = TRUE), 0)) %>%
    filter(Party %in% parties_federal | Party == "OTH") %>%
    mutate(Vote = if_else(notmain == 1, othervote, Vote)) %>%
    ungroup() %>% dplyr::select(-notmain, -othervote) %>%
    mutate(Date = as.Date(Date, origin = "1899-12-30"))

rm(dat_loaded_raw)

# Make the app

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
               aes(group = ID, colour = Party, x = as.POSIXct(Date), y = Vote)) +
            geom_point(size = 3.5, 
                       position = position_jitter(width=10000), # This jitter helps diff. btwn ties
                       alpha = 0.5) + 
            geom_spline(aes(group = Party), spar = 0.5,
                        size = 1, alpha = 0.5) +
            scale_colour_manual(limits = parties_federal, values = colours_federal) +
            theme_minimal(base_size = 15) +
            theme(axis.title.y = element_text(angle = 0, vjust = 0.5)) +
            scale_x_datetime(date_labels = "%d %h") +
            xlab("") +
            ylab("%") +
            ylim(c(0,NA))
        
    })
    
}

shinyApp(ui = ui, server = server)