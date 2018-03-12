
#################### using ggVis ######################

library(shiny)
library(ggvis)
data(mtcars)

server=function(input, output, session) {
  
  input_size<-reactive({input$size})
  
  mtcars %>% 
    ggvis(~disp, ~mpg, size := input_size) %>%
    layer_points() %>%
    bind_shiny("ggvis")
}


ui=fluidPage(
  sliderInput(inputId = "size",
              label = "Area",
              value=500,
              min=10, max=1000, step=50),
  
  ggvisOutput("ggvis")
    
)

shinyApp(ui=ui, server=server)