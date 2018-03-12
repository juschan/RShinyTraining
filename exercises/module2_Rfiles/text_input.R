library(shiny)

ui=fluidPage(
  
  titlePanel("Demonstration of widgets"),
  sidebarLayout(
    sidebarPanel(("Enter personal information"),
                 textInput("name","Enter your Name",""),
                 textInput("age", "Enter your Age","")),
    
    mainPanel(("Personal Information"),
              textOutput("myname"),
              textOutput("myage"))
    
  )
)


server=function(input,output,session){
  output$myname=renderText(input$name)	
  output$myage=renderText(input$age)
  
}


shinyApp(ui=ui, server=server)
