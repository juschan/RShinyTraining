library(shiny)

server=function(input,output){
  
}


ui=fluidPage(
  
  titlePanel("This is my first shiny app"),
  sidebarLayout(
    sidebarPanel("this is a side bar panel"),
    
    mainPanel("this is the main panel text, output displayed here")
    
  )
)


shinyApp(ui=ui, server=server)