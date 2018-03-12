library(shiny)

server=function(input, output, session) {
  
  data = reactive({  
    dist= switch(input$dist,
                 norm = rnorm,
                 unif = runif,
                 lnorm = rlnorm,
                 exp = rexp,
                 rnorm=rnorm)
    dist(input$n)
  })
  output$plot= renderPlot({
                          dist=input$dist
                          n=input$n
                          hist(data(), 
                          main=paste('r', dist, '(', n, ')', sep=''))
  })
  
  output$summary=renderPrint({
    summary(data())
  })
  
  output$table <- renderTable({
    data.frame(x=data())
  })
}


ui=pageWithSidebar(
  headerPanel("Tabsets"),
  sidebarPanel(
    radioButtons("dist", "Distribution type:",
                 list("Normal" = "norm",
                      "Uniform" = "unif",
                      "Log-normal" = "lnorm",
                      "Exponential" = "exp")),
    br(),
    
    sliderInput("n", 
                "Number of observations:", 
                value = 500,
                min = 1, 
                max = 1000)
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")), 
      tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Table", tableOutput("table"))
    )
  )
)

shinyApp(ui=ui, server=server)