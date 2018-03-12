library(plotly)
library(ggplot2)
data(diamonds)



ui=fluidPage(

     titlePanel("Plotly Dashboard"),
     
     navlistPanel(
       tabPanel("Histogram",
                h3("this is a histogram multi-layer"),
                plotlyOutput("histmulti")),
       tabPanel("Scatterplot with color",
                h3("this is a scatterplot with color by region"),
                plotlyOutput("scattercolor")),
       tabPanel("Scatterplot of diamonds dataset",
                h3("this is a scatterplot with diamonds carat VS price VS clarity"),
                plotlyOutput("diamonds")),
       tabPanel("Surface plot",
                h3("this is a surfaceplot"),
                plotlyOutput("surfaceplot")),
       tabPanel("Contour plot",
                h3("this is a contourplot"),
                plotlyOutput("contourplot"))
     ))

server=function(input,output){
  
  path=file.path("www/WHO.csv")
  worldbank=read.csv(path, header=T, stringsAsFactors = F)
  
  output$histmulti=renderPlotly({
    plot_ly(worldbank, type="histogram", x=worldbank$Under15, opacity=0.5) %>%
      add_trace(worldbank, type="histogram", x=worldbank$Over60, opacity=0.5) %>%
      add_trace(worldbank, type="histogram", x=worldbank$FertilityRate, opacity=0.5) %>%
      layout(barmode='overlay')
  })
     
  output$scattercolor=renderPlotly({
    plot_ly(worldbank, type="scatter", x=worldbank$LifeExpectancy, 
            y=worldbank$ChildMortality, color=worldbank$Region)
  })   


  set.seed(100)
  d=diamonds[sample(nrow(diamonds),500),]
  
  output$diamonds=renderPlotly({
  plot_ly(d, x=d$carat, y=d$price, text=paste("Clarity:",d$clarity),
          color=d$carat, size=d$carat)
   })


   output$surfaceplot=renderPlotly({
     plot_ly(z=volcano, type="surface")  
   })
   
   output$contourplot=renderPlotly({
     plot_ly(z=volcano, type="contour")  
   })
   
}

shinyApp(ui=ui, server=server)