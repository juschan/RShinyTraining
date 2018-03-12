library(shiny)
library(datasets)

server=function(input, output, session) {
  datasetInput=reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  output$caption = renderText({
    input$caption
  })
  output$summary = renderPrint({
    dataset = datasetInput()
    summary(dataset)
  })
  output$view = renderTable({
    head(datasetInput(), n = input$obs)
  })
}  


ui=pageWithSidebar(
  headerPanel("Reactivity"),
  
  sidebarPanel(
    textInput("caption", "Caption:", "Data Summary"),
    selectInput("dataset", "Choose a dataset:", choices = c("rock", "pressure", "cars")
    ),
    numericInput("obs", "Number of observations to view:", 10)
  ),
  
  mainPanel(
    h3(textOutput("caption")),     
    verbatimTextOutput("summary"),     
    tableOutput("view")
  )
)


shinyApp(ui=ui, server=server)
