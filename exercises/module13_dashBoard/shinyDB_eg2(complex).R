library(shiny)
library(shinydashboard)

ui=dashboardPage(skin = "red",
              dashboardHeader(title ="Shiny App",
                              dropdownMenu(type = "messages",
                                           messageItem(
                                             from = "Bob Carter",
                                             message ="Excellent dashboard.Keep the good job"),
                                           messageItem(
                                             from = "New User",
                                             message = "How do I register?",
                                             icon = icon("question"),
                                             time = "23:00"),
                                           messageItem(
                                             from = "Support",
                                             message = "The new server is ready.",
                                             icon = icon("life-ring"),
                                             time = "2017-15-03")
                                           ),
                              dropdownMenu(type = "notifications",
                                           notificationItem(
                                             text = "5 new users today",
                                             icon("users")
                                           ),
                                           notificationItem(
                                             text = "12 items delivered",
                                             icon("truck"),
                                             status = "success"
                                           ),
                                           notificationItem(
                                             text = "Server load at 86%",
                                             icon = icon("exclamationtriangle"),
                                             status = "warning"
                                           )
                              ),
                              dropdownMenu(type = "tasks", badgeStatus =
                                             "success",
                                           taskItem(value = 90, color =
                                                      "green",
                                                    "Documentation"
                                           ),
                                           taskItem(value = 17, color =
                                                      "aqua",
                                                    "Project Iris"
                                           ),
                                           taskItem(value = 75, color =
                                                      "yellow",
                                                    "Server deployment"
                                           ),
                                           taskItem(value = 80, color =
                                                      "red",
                                                    "Overall project"
                                           )
                              )),
              dashboardSidebar(
                width=400,
                sidebarMenu(
                  menuItem("DATATABLE", tabName = "dt" , icon = icon("dashboard")),
                  menuItem("SUMMARY", tabName = "sm", icon = icon("idcard-o")),
                  menuItem("K-MEANS", tabName = "km", icon = icon("vcardo"))
                  )),
              
              
              dashboardBody(tags$head(tags$style(HTML('
                                                      .main-header .logo {
                                                      Georgia", Times ,
                                                      "Times New Roman", serif;
                                                      font-weight: bold;
                                                      font-size: 24px;
                                                      }
                                                      '))),
                            tabItems(
                              tabItem(tabName = "dt",
                                      h2("DATA TABLE"),
                                      fluidRow(
                                        box (title ="DATA TABLE" ,solidHeader =
                                               TRUE,status="primary",dataTableOutput("Table"),width = 400)
                                      ),
                                      # infoBoxes with fill=FALSE
                                      fluidRow(
                                        # A static infoBox
                                        infoBox("New Orders",15 * 2 , icon =icon("credit-card"),fill = TRUE),
                                        # Dynamic infoBoxes
                                        infoBoxOutput("progressBox"),
                                        infoBoxOutput("approvalBox")
                                      )),
                              tabItem(tabName = "sm",
                                      h2("SUMMARY"),
                                      fluidRow(
                                        box(title="SUMMARY DATA TABLE",solidHeader =
                                              TRUE,status="primary",dataTableOutput("Table2"),width = 400)
                                      )
                              ),
                              tabItem(tabName = "km",
                                      fluidRow(
                                        box(title="K-MEANS",height=450,solidHeader =
                                              TRUE,status="primary",plotOutput("plot1",click = "mouse")),
                                        box(status="info",height=450,sliderInput("slider1", label =
                                                                                   h4("Clusters"),
                                                                                 min = 1, max
                                                                                 = 9, value = 4),
                                            verbatimTextOutput("coord"))),
                                      fluidRow(
                                        box(status="success",height=450,checkboxGroupInput("checkGroup",
                                                                                           label= h4("Variable X"),names(iris),
                                                                                           selected=names(iris)[[2]]
                                        )),
                                        box(status="danger",height=450,selectInput("select", label =h4("Variable Y"),
                                                                                   names(iris),selected=names(iris)[[2]]
                                        )))
                              )
                            )
              )
              )

server= function(input, output) {
  output$Table <- renderDataTable(
    iris,options = list(
      lengthMenu = list(c(10,20,30,-1),c('10','20','30','ALL')),
      pageLength = 10))
  sumiris<-as.data.frame.array(summary(iris))
  output$Table2 <- renderDataTable(sumiris)
  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF",
              "#999999"))
    plot(Data(),
         col = Clusters()$cluster,
         pch = 20, cex = 3,
         cex.main = 2, font.main= 4, col.main= "blue")
  }, width = "auto",height = "auto")
  output$coord <- renderText({
    paste0("x=", input$mouse$x, "\ny=", input$mouse$y)
  })
  Data <- reactive({iris[, c(input$select,input$checkGroup)]
  })
  Clusters <- reactive({
    kmeans(Data(),input$slider1)
  })
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "20%"), icon =
        icon("list"),
      color = "red",fill = TRUE
    )
  })
  output$approvalBox <- renderInfoBox({
    infoBox(
      "Approval", "70%", icon = icon("thumbs-up", lib =
                                       "glyphicon"),
      color = "green",fill = TRUE
    )
  })
}

shinyApp(ui=ui, server=server)