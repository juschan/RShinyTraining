
library(shiny)

ui=fluidPage(
  
  titlePanel("Demonstration of select Input widget"),
  sidebarLayout(
    sidebarPanel("This is a side bar panel"),
    selectInput("statenames", "Select the state", c("CA","NY","FL","AZ","TX"), selected="TX")
  ),
  
  mainPanel(textOutput("state")
            
  )
)

server= function(input,output,session){
  output$state=renderText(input$statenames)
}


shinyApp(ui=ui, server=server)
