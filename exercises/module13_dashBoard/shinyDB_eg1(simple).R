library(shiny)
library(shinydashboard)

ui=dashboardPage(
  
dashboardHeader(title="Dwight First Dashboard"),

dashboardSidebar(
  sidebarMenu(text="mytabs",
      menuSubItem(text="histogram", tabName="first", icon=icon("dashboard")),
      menuSubItem(text="scatterplot", tabName="second", icon=icon("th"))
    )
  ),
  

dashboardBody(
          tabItems(
             
            tabItem(tabName="first",
             fluidRow(
                  h2("This is a histogram")),
             fluidRow(
                  box(plotOutput("plot1"),
                           box(title="Controls",
                               sliderInput("slider1", "number of bins:",
                                           min=1, max=10, value=50)
                           )))
            ),
          
            tabItem(tabName="second",
                    fluidRow(
                            h2("This is a scatterplot")),
                    fluidRow(
                      box(plotOutput("plot2"),
                                  box(title="Controls",
                                      sliderInput("slider2", "points to plot:",
                                            min=50, max=200, value=100)
                                      )))
                        )
                      )  
                    )
                )


server=function(input,output){
  
output$plot1=renderPlot({hist(faithful$eruptions,
                        probability = TRUE,
                        breaks = as.numeric(input$slider1),
                        xlab = "Duration (minutes)",
                        main = "Geyser eruption duration")
                       })
                        
output$plot2=renderPlot({
  plot(x=rnorm(input$slider2),y=rnorm(input$slider2)
  ) 
})

}

shinyApp(ui=ui, server=server)