library(shiny)

ui=fluidPage(
  
  titlePanel("Demonstration of checkBox Input widget"),
  sidebarLayout(
    sidebarPanel("This is a side bar panel"),
    checkboxInput("mycheckbox","Factor Y")
  ),
  
  mainPanel(textOutput("checker")
            
  )
)

server= function(input,output,session){
  output$checker=renderText(input$mycheckbox)
}


shinyApp(ui=ui, server=server)