library(shiny)
data(iris)

server=function(input,output,session){
  
  colm=reactive({			# this functions makes colm reactive
    as.numeric(input$var)		# no need to redeclare everytime, just colm()
  })
  
  
  output$text1=renderText({
    paste("Data set variable/column name is" , names(iris[colm()]))
  })
  
  output$text2=renderText({
    paste("Color of histogram is",input$color)
  })
  
  output$text3=renderText({
    paste("Number of histogram bins is",input$bins)
  })
  
  output$hist=renderPlot({
    hist(iris[,colm()],col=input$color,xlim=c(0, max(iris[,colm()])),
         main="Histogram of Iris dataset",breaks=seq(0, max(iris[,colm()]),l=input$bins+1),xlab=names(iris[colm()])
    )  
  })
  
}

ui=basicPage(
  h1("Using More Reactive"),
  sidebarLayout(
    sidebarPanel(("Enter the column from iris dataset"),
                 sliderInput(inputId="var",label="slider1",value=1, min=1, max=4),
                 sliderInput(inputId="bins",label="slider1",value=1, min=1, max=20),
                 radioButtons("color","Select the color",list("blue","red","green"),"")
    ),
    
    mainPanel(("Output from variables"),
               textOutput("text1"),
               textOutput("text2"),
               textOutput("text3"),
               plotOutput("hist")
               
       )
    
    )
    
  )
  
  shinyApp(ui=ui, server=server)