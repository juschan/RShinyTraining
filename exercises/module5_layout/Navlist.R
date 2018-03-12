library(shiny)
data("faithful")

server=function(input, output, session) {
            
            output$distPlot=renderPlot({
                hist(faithful$eruptions,
                     breaks = 50,
                     xlab = "Eruptions",
                     main = "Geyser eruption count")
                   })
            
            output$timePlot=renderPlot({
              hist(faithful$waiting,
                   breaks=30,
                   xlab="Waiting(minutes)",
                   main="Geyser eruption duration")
                  })
  
            output$summary=renderPrint({
                 summary(faithful)
                })
  
             output$table=renderTable({
               data.frame(x=faithful$eruptions)
               })
}


ui=fluidPage(
  
  titlePanel("Nav List Layout"),
  
  navlistPanel(
    "Header A",
    tabPanel("Plot",
             h3("this is the first plot example"),
             plotOutput("distPlot")),
    tabPanel("Summary",
             h3("this is the first summary example"),
             verbatimTextOutput("summary")),
    "Header B",
    tabPanel("Table",
             h3("this is the first table example"),
             tableOutput("table")),
    "Header C",
    tabPanel("Plot",
             h3("this is the second plot example"),
             plotOutput("timePlot")),
    tabPanel("Input"),
    "-----",
    tabPanel("Help-FAQ")
  
))

shinyApp(ui=ui, server=server)