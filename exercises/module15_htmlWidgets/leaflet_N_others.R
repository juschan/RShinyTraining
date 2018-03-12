library(shiny)
library(leaflet)
library(visNetwork)
library(networkD3)
library(d3heatmap)
library(threejs)
library(rgl)
library(rglwidget)
library(htmltools)


ui=fluidPage(
  
  titlePanel("HTML widgets dashBoard"),
  
  navlistPanel(
    tabPanel("Leaflet",
             h3("this is a leaflet"),
             leafletOutput("leafmap")),
    tabPanel("VisNetwork",
             h3("this is a network visualization"),
             visNetworkOutput("network")),
    tabPanel("d3 heatmap",
             h3("this is a heatmap"),
             d3heatmapOutput("heatmap")),
    tabPanel("RGL",
             h3("this is a 3D graphics"),
             scatterplotThreeOutput("threeDgraph")),
    tabPanel("3D graphics",
             h3("this is a 3D graphics part 2"),
             rglwidgetOutput("RGLwidgetplot"))
  ))

server=function(input,output){
  
  
  monitors <- read.table(header=TRUE, text='
  monitorid        lat        long                       name            
                         1   41.60668  -87.304729                 Gary-IITRI
                         2  39.811097  -86.114469     Indpls-Washington-Park
                         3  39.749019  -86.186314         Indpls-Harding-St.
                         4  38.013248  -87.577856     Evansville-Buena-Vista
                         5  39.159383  -86.504762                Bloomington
                         6  39.997484  -86.395172                 Whitestown
                         ')

  
  output$leafmap=renderLeaflet({
    m=leaflet()
    m=addTiles(m)
    m=addMarkers(m, lng=monitors$long, lat=monitors$lat, popup=monitors$name)
  })
  
  output$network=renderVisNetwork({
    nodes <- data.frame(id = 1:6, title = paste("node", 1:6), 
                        shape = c("dot", "square"),
                        size = 10:15, color = c("blue", "red"))
    edges <- data.frame(from = 1:5, to = c(5, 4, 6, 3, 3))
    visNetwork(nodes, edges) %>%
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)
  })   
  

  
  output$heatmap=renderD3heatmap({
    d3heatmap(mtcars, scale="column", colors="Blues")
  })
  
  
  output$threeDgraph=renderScatterplotThree({
    z <- seq(-10, 10, 0.01)
    x <- cos(z)
    y <- sin(z)
    scatterplot3js(x,y,z, color=rainbow(length(z)))  
  })
  
  output$RGLwidgetplot=renderRglwidget({
    theta <- seq(0, 6*pi, len=100)
    xyz <- cbind(sin(theta), cos(theta), theta)
    lineid <- plot3d(xyz, type="l", alpha = 1:0, 
                     lwd = 5, col = "blue")["data"]
    
    browsable(tagList(
      rglwidget(elementId = "example", width = 500, height = 400,
                controllers = "player"),
      playwidget("example", 
                 ageControl(births = theta, ages = c(0, 0, 1),
                            objids = lineid, alpha = c(0, 1, 0)),
                 start = 1, stop = 6*pi, step = 0.1, 
                 rate = 6,elementId = "player")
    ))  
  })
  
}

shinyApp(ui=ui, server=server)