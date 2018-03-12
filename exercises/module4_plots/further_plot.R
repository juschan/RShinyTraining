library(shiny)
data(faithful)
data(airquality)

server=function(input, output, session) {
  
  output$main_plot <- reactivePlot(function() {
    
    if (input$dataset == "Geyeser"){
      dataset <- (faithful$eruptions)
    }
    if (input$dataset == "NYC Wind"){
      dataset <- (airquality$Wind)
    }
    
    if (input$dataset == "Geyeser"){
      dataName <- ("Eruption Duration (min)")
    }
    if (input$dataset == "NYC Wind"){
      dataName <- ("Wind Speed (mph)")
    }
    
    hist(dataset,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = dataName,
         main = "Histogram of Data")
    
    if (input$individual_obs) {
      rug(dataset)
    }
    
    if (input$density) {
      dens <- density(dataset,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
    
  })
}


ui=fluidPage(
  
  selectInput(inputId = "dataset",
              label="Dataset to visualize:",
              choices=c("Geyeser", "NYC Wind"),
              selected = "Geyeser"),
  
  selectInput(inputId = "n_breaks",
              label = "Number of bins in histogram (approximate):",
              choices = c(10, 20, 35, 50),
              selected = 20),
  
  checkboxInput(inputId = "individual_obs",
                label = strong("Show individual observations"),
                value = FALSE),
  
  checkboxInput(inputId = "density",
                label = strong("Show density estimate"),
                value = FALSE),
  
  plotOutput(outputId = "main_plot", height = "300px"),
  
  # Display this only if the density is shown
  conditionalPanel(condition = "input.density == true",
                   sliderInput(inputId = "bw_adjust",
                               label = "Bandwidth adjustment:",
                               min = 0.2, max = 2, value = 1, step = 0.2)
  )
  
)

shinyApp(ui=ui, server=server)