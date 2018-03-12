library(highcharter)
library(ggplot2)
library(treemap)
library(viridisLite)
library(dplyr)
library(quantmod)
library(datasets)
data(diamonds)
data(mtcars)
data(citytemp)
data(GNI2014)
data(unemployment)
data(uscountygeojson)


ui=fluidPage(
  
  titlePanel("Highchart Dashboard"),
  
  navlistPanel(
     tabPanel("Scatterplot",
              h3("this is a scatterplot of mtcars"),
              highchartOutput("mtcarsScatterplot")),
    tabPanel("Barplot",
             h3("this is a zoom barchart of diamonds"),
             highchartOutput("diamondsBarPlot")),
    tabPanel("LineChart",
             h3("this is a zoom linechart of city temperature"),
             highchartOutput("Linechart")),
    tabPanel("Treemap",
             h3("this is a treemap of Gross National Income"),
             highchartOutput("Treemap")),
    tabPanel("USAmap",
             h3("this is a geography map of US unemployment April 2015"),
             highchartOutput("USAmap")),
    tabPanel("Stocks",
             h3("this is a stock data of Apple Corp"),
             highchartOutput("Stocks"))
  ))


server=function(input, output){    
    
output$mtcarsScatterplot= renderHighchart({
                                highchart() %>% 
                                hc_title(text="Scatter chart with size and color") %>%
                                hc_add_series_scatter(mtcars$wt, mtcars$mpg, mtcars$drat, mtcars$hp)
})


output$diamondsBarPlot= renderHighchart({
                          hchart(diamonds$price, color="#B71C1C") %>%
                          hc_title(text= "You can zoom me")
})


output$Linechart= renderHighchart({
  highchart() %>% 
  hc_xAxis(categories=citytemp$month) %>%
  hc_add_series(name="Tokyo", data=citytemp$tokyo) %>%
  hc_add_series(name="London", data=citytemp$london) %>%
  hc_add_series(name="Other city", data=(citytemp$tokyo + citytemp$london)/2)
})



tm=treemap(GNI2014, index=c("continent","iso3"),
                  vSize="population", vColor="GNI",
                  type="value", palette=viridis(6))

output$Treemap= renderHighchart({
  highchart(height=800) %>%
  hc_add_series_treemap(tm, allowDrillToNode=TRUE,
                        layoutAlgorithm="squarified",
                        name="tmdata") %>%
  hc_title(text="Gross National Income World Data") %>%
  hc_tooltip(pointFormat="<b>{point.name}</b>:<br>
              Pop: {point.value:,.Of}<br>
              GNI: {point.valuecolor:,.Of}")
})


dclass=data.frame(from=seq(0,10, by=2),
                  to=c(seq(2,10, by=2),50),
                  color=substring(viridis(6, option="C"),0,7))
dclass=list_parse(dclass)

output$USAmap= renderHighchart({
  highchart() %>%
  hc_title(text = "US Countries unemployment rates, April 2015") %>%
  hc_add_series_map(uscountygeojson, unemployment,
                    value="value", joinBy="code") %>%
  hc_colorAxis(dataClasses=dclass) %>%
  hc_legend(layout="vertical", alight="right",
            floating=TRUE, valueDecimals=0,
            valueSuffix= "%") %>%
  hc_mapNavigation(enabled=TRUE)
})

getSymbols("AAPL")


output$Stocks= renderHighchart({
  highchart() %>%
  hc_add_series_ohlc(AAPL) %>%
  hc_add_theme(hc_theme_538())
})
  
  
}


shinyApp(ui=ui, server=server)
