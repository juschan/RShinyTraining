library(shiny)

ui=fluidPage(
  
  titlePanel("Demonstration of widgets"),
  sidebarLayout(
    sidebarPanel(("Enter personal information"),
                 textInput("name","Enter your Name",""),
                 textInput("age", "Enter your Age",""),
    radioButtons("gender","Select the gender",list("Male","Female"),"")),
    
    mainPanel(("Personal Information"),
              textOutput("myname"),
              textOutput("myage"),
              textOutput("mygender"))
  )
)


server=function(input,output,session){
       output$myname=renderText(input$name)	
       output$myage=renderText(input$age)
       output$mygender=renderText(input$gender)
  
}

shinyApp(ui=ui, server=server)