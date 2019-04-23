library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(highcharter)
library(quantmod)
library(MASS)
library(tseries)
library(forecast)

shinyUI(fluidPage(
  
  theme = shinytheme("simplex"),

         titlePanel(helpText(HTML("<h1>Stock Financials By Kaveh Alemi</h1>"))),

         searchInput(inputId = "StockCode", label = "Enter a Stock Symbol", value = "AAPL",
                     placeholder = "Search",
                     btnSearch = icon("search")),
  
  

  column(6,offset = 3, align = "center",
         
         box(
           title = helpText(HTML("<h2>Stock Price Time Series</h2>")),
           highchartOutput("plot1",width = "700px", height = "700px"),
           width = 900, height = 900),
         
         
         box(
           title = helpText(HTML("<h2>Dividend Percentage</h2>")),
           highchartOutput("plot2",width = "700px", height = "700px"),
           width = 900, height = 900),
         
         
         box(
           title = helpText(HTML("<h2>Daily Return</h2>")),
           highchartOutput("plot4",width = "700px", height = "700px"),
           width = 900, height = 900),
         
         
         box(
           title = helpText(HTML("<h2>Bollinger Bands</h2>")),
           plotOutput("plot3",width = "700px", height = "700px"),
           radioButtons("plot3_buttons", "",
                        c("3 Month" = "3mon",
                          "6 Month" = "6mon",
                          "1 Year" = "ytd",
                          "All" = "all"),
                        inline = TRUE),
           width = 900, height = 900),
  
  
  
          box(
            title = helpText(HTML("<h2>Directional Movement Index</h2>")),
            plotOutput("plot6",width = "700px", height = "700px"),
            radioButtons("plot6_buttons", "",
                         c("3 Month" = "3mon",
                           "6 Month" = "6mon",
                           "1 Year" = "ytd",
                           "All" = "all"),
                         inline = TRUE),
            width = 900, height = 900),
         
         
           box(
             title = helpText(HTML("<h2>Commodity Channel Index</h2>")),
             plotOutput("plot7",width = "700px", height = "700px"),
             radioButtons("plot7_buttons", "",
                          c("3 Month" = "3mon",
                            "6 Month" = "6mon",
                            "1 Year" = "ytd",
                            "All" = "all"),
                          inline = TRUE),
             width = 900, height = 900),
         
         
         box(
           title = helpText(HTML("<h2>Moving Averages</h2>")),
           plotOutput("plot8",width = "700px", height = "700px"),
           radioButtons("plot8_buttons", "",
                        c("3 Month" = "3mon",
                          "6 Month" = "6mon",
                          "1 Year" = "ytd",
                          "All" = "all"),
                        inline = TRUE),
           
           radioButtons("mavg_buttons", "",
                        c("SMA" = "SMA",
                          "EMA" = "EMA",
                          "WMA" = "WMA",
                          "DEMA" = "DEMA",
                          "EVWMA" = "EVWMA",
                          "ZLEMA" = "ZLEMA"
                          ),
                        inline = TRUE),
           sliderInput("bands",
                       "Bandwidth (n days):",
                       min = 1,
                       max = 54,
                       value = 20),
           width = 1000, height = 1000),
         
         
         
         box(
           title = helpText(HTML("<h2>10 Day Price Prediction Using ARIMA,</h2>")),
           plotOutput("plot9",width = "700px", height = "700px"),
           width = 800, height = 800),
         
         box(
           title = "",
           highchartOutput("plot10",width = "700px", height = "700px"),
           width = 700, height = 700)
         
         
         
         
         
  
  
  
  
  
  
    )
  )
)