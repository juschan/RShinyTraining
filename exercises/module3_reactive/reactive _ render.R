library(shiny)

server=function(input,output,session){
  data=reactive({
    rnorm(50)*input$myslider
  })
  output$plot=renderPlot({
    plot(data(), col="blue", pch=20, bty="n")
  })
}

ui=basicPage(
  h1("Using Reactive"),
  sliderInput(inputId="myslider",label="slider1",value=1, min=1, max=20),
  plotOutput("plot")
)

shinyApp(ui=ui, server=server)