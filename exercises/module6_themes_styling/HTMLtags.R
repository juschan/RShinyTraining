library(shiny)

server=function(input,output,session){}

ui=fluidPage(
  titlePanel(strong("This is the STRONG tag on the title")),
  
  sidebarLayout(
    sidebarPanel(
      withTags(
        div(
          b("bold text: here you have a line break, a horizonal line and a plot"),
          br(),
          br(),
          code("plot(lynx)")
        )),
      tags$img(src='Rlogo.png', height=50, width=50),
      tags$style("body{background-color:linen; color:brown}"),
      tags$style(".span12{font-style:oblique; border style: solid}")
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Weblinks with direct tag a", a(href="www.yahoo.com", "yahoo")),
        tabPanel(tags$b("using b for bold text"), tags$b("a bold text")),
        tabPanel("Citations with blockquote tag", tags$blockquote("R is Great", cite="R Programmer"))
      )
    )
  )
)

shinyApp(ui=ui, server=server)
