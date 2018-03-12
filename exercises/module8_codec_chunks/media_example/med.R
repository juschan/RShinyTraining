library(shiny)

server=function(input,output){
}

ui=navbarPage("Intergration of different types of media",      # click open in browser
              tabPanel("Image sourced locally",
                       img(src="dataX.png", width="100px", height="100px")),
              tabPanel("Image sourced online",
                       tags$iframe(style="height:500px; width:400px; scrolling=yes",
                                   src="http://www.zwani.com/graphics/hello_funny/images/56467.jpg")),
              tabPanel("video sourced locally",
                       tags$video(src="R2.mp4", type="video/mp4", controls=T, autoplay=T,
                                  width="500px", height="400px")),
              tabPanel("video from youtube, Iframe",
                       tags$iframe(width="650", height="550",src="//www.youtube.com/embed/nohQReM7BpI")),
              tabPanel("pdf sourced online, Iframe",
                       tags$iframe(style="height:600px; width:100%; scrolling=yes",
                                   src="https://cran.r-project.org/web/packages/shiny/shiny.pdf")),
              tabPanel("text as txt",
                       includeText("graphics.txt"))
)

shinyApp(ui=ui, server=server)