library(shiny)
data(mtcars)

server=function(input, output, session) {
  
  data= reactive(
    rnorm(input$n) 
  )
  
  output$distPlot= renderPlot({
    n=input$n
    hist(data(), 
         main=paste('Random plot of',n,'points', sep=''))
  })
  
  
  output$mycars=renderPlot(plot(mtcars$mpg,mtcars$disp))
  
}  



ui=fluidPage(
  
  titlePanel("GridLayout"),
  
  fluidRow(
    
    column(2, offset = 1,                                      # offset shift the position
           wellPanel(
             sliderInput("n", "Number of observations:",  
                         min = 1, max = 1000, value = 500)
           )       
    ),
    
    column(4,
           plotOutput("distPlot")                     # must still add up to 12 with the
    ),                                                # offset=1 included
    
    column(4,
           plotOutput("mycars")
    )
  )
)





shinyApp(ui=ui, server=server)