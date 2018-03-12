library(shiny)
data(faithful)

server=function(input, output, session) {
            
            output$distPlot=renderPlot(
                hist(faithful$eruptions,
                     breaks = 50,
                     xlab = "Eruptions",
                     main = "Geyser eruption count")
                   )
            
            output$timePlot=renderPlot(
              hist(faithful$waiting,
                   breaks=30,
                   xlab="Waiting(minutes)",
                   main="Geyser eruption duration")
                  )
  
            output$summary=renderPrint(
                 summary(faithful)
                )
  
             output$table=renderTable(
               data.frame(x=faithful$eruptions)
               )
}



ui=fluidPage(
        navbarPage("Dwight NavBar",

            navbarMenu("Analysis1",
                  tabPanel("Analysis2",
                    headerPanel("Analysis3"),
                           sidebarPanel("text"),
                              mainPanel(tabsetPanel(id="tab1",
                                        tabPanel("tab1-1", 
                                                 plotOutput("distPlot")),
                                        tabPanel("tab1-2",
                                                 plotOutput("timePlot"))
                                 ))
                              ),
                                                 
                    tabPanel("Analysis4",
                            headerPanel("Analysis5"),
                                  sidebarPanel("text"),
                                       mainPanel(tabsetPanel(id="tab2",
                                            tabPanel("tab2-1", 
                                                      tableOutput("table")),
                                            tabPanel("tab2-2",
                                                    verbatimTextOutput("summary"))
                                       ))
                              )
       )
))
                   
shinyApp(ui=ui, server=server)