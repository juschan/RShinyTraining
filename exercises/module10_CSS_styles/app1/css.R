library(shiny)


ui=fluidPage(theme = "bootstrap.css",
                  
                  headerPanel("New Application"),
                  
                  sidebarPanel(
                    sliderInput("bins", "Number of bins:", 
                                min = 1, max = 30, value = 10)
                  ),
                  
                  mainPanel(plotOutput("distPlot"))
)



server=function(input, output) {
  
  output$distPlot = reactivePlot(function() {
    
    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$bins),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    
  })
}


shinyApp(ui=ui, server=server)