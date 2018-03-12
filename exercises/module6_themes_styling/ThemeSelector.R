
# library(shinythemes)
# themeSelector() # > generates a list of themes > in this case i use "darkly"

# put this in ui=fluidPage(themeSelector()  > will generate options to choose from


library(shiny)
library(shinythemes)

server=function(input,output,session){}

ui=fluidPage(theme=shinytheme("sandstone"),
             titlePanel(strong("This is the STRONG tag on the title")),
             
             sidebarLayout(
               sidebarPanel(
                 withTags(
                   div(
                     b("bold text: here you have a line break, a horizonal line and a plot"),
                     br(),
                     hr(),
                     code("plot(lynx)")
                   ))),
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