library(shiny)

server=function(input, output, session) {
  
  data= reactive(
    rnorm(input$n) 
  )
  
  output$distPlot= renderPlot({
    n=input$n
    hist(data(), 
         main=paste('Random plot of',n,'points', sep=''))
  })
}  



ui=fluidPage(
  
  titlePanel("GridLayout"),
  
  fluidRow(
    
    column(4,
           wellPanel(
             sliderInput("n", "Number of observations:",  
                         min = 1, max = 1000, value = 500)
           )       
    ),
    
    column(8,
           plotOutput("distPlot")
    )
  )
)

shinyApp(ui=ui, server=server)

