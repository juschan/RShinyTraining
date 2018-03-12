library(shiny)

server=function(input,output,session){}

ui=fluidPage(
  
  titlePanel("This is my first shiny app"),
  sidebarLayout(
    sidebarPanel("this is a side bar panel"),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Tab1","First Tab"),
        tabPanel("Tab2","Second Tab"),
        tabPanel("Tab3","Third Tab")
      )
    )            
  )
)

shinyApp(ui=ui, server=server)