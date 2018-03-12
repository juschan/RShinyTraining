library(shiny)

ui=fluidPage(
  
  titlePanel("Demonstration of slider widget"),
  sidebarLayout(
    sidebarPanel("this is a side bar panel"),
    sliderInput("slide","Select a value from slider", min=0, max=5, step=0.5, value=1)),
    
    mainPanel(textOutput("sliderout")
              
    )
  )
  
  server=function(input,output,session){
    output$sliderout=renderText(paste("You selected value as:",(input$slide)))		
    
  }
  
  
  shinyApp(ui=ui, server=server)