library(shiny)
data(faithful)

server=function(input, output, session) {
  
  output$main_plot = reactivePlot(function() {
    
    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    
  })
}


ui=fluidPage(
  
  selectInput(inputId = "n_breaks",
              label = "Number of bins in histogram (approximate):",
              choices = c(10, 20, 35, 50),
              selected = 20),
  
  plotOutput(outputId = "main_plot", height = "300px")
  
)

shinyApp(ui=ui, server=server)