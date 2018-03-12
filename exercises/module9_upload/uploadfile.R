library(shiny)

ui=fluidPage(
  
  titlePanel("File Input"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Upload the file"),
      helpText("Default max. file size is 5MB"),
      br(),
      h5(helpText("Select the read.table parameters below")),
      checkboxInput(inputId="header", label="Header", value=FALSE),
      checkboxInput(inputId="stringAsFactors","stringAsFactors", FALSE),
      br(),
      radioButtons(inputId='sep', label='Seperator', choices=c(Comma=',',Semicolon=';',Tab='\t', Space='')),
      uiOutput("choose_columns"),
      br(),
      h5(textOutput("counter")),
      h6("Powered by:"),
      tags$img(src='Rlogo.png', height=50, width=50),
      tags$style("body{background-color:linen; color:brown}")
      
    ),
    
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("About file", tableOutput("filedf")),
                  tabPanel("Data", tableOutput("table")),
                  tabPanel("Summary", tableOutput("sum")),
                  tabPanel("Plot", plotOutput('plot'))
      )
    )
  ))

server=function(input,output){
  
  data=reactive({
    file=input$file
    if(is.null(file)){return()}
    read.table(file=file$datapath, sep=input$sep, header=input$header, stringsAsFactors=input$stringAsFactors)
  })
  
  output$filedf=renderTable({
    if(is.null(data())){return()}
    input$file
  })
  
  output$sum=renderTable({
    if(is.null(data())){return()}
    summary(data())
  })
  
  output$table=renderTable({
    if(is.null(data())){return()}
    data()
  })
  
  output$counter=renderText({ 
    if(!file.exists("counter.Rdata"))
      counter=0
    else
      load(file="counter.Rdata")
    counter=counter+1
    save(counter, file="counter.Rdata")
    paste0("Hits:", counter)
  })
  
  plotInput = function(){
    if(is.null(data())){return()}
    dat <- data()
    df = dat[, input$columns, drop = FALSE]
    p=plot(df)
  }
  
  output$choose_columns = renderUI({
    if(is.null(data())){return()}
    dat = data()
    colnames = names(dat)
    checkboxGroupInput("columns", "Choose columns", 
                       choices  = colnames,
                       selected = colnames)  
  })
  
  output$plot=renderPlot({
    if(is.null(data())){return()}
    print(plotInput())
  })
  
}
  
  shinyApp(ui=ui, server=server)