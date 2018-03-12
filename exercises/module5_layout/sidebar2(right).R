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
  
  titlePanel("Right Sidebar"),
  
  sidebarLayout(position="right",
                
                sidebarPanel(
                  sliderInput("n", "Number of observations:",  
                              min = 1, max = 1000, value = 500)
                ),
                
                mainPanel(
                  plotOutput("distPlot")
                )
  )
)

shinyApp(ui=ui, server=server)