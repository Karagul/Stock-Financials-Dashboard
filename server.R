library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(highcharter)
library(quantmod)
library(MASS)
library(tseries)
library(forecast)

shinyServer(function(input, output) {
  
  
  stockPrices <- reactive({
    
    getSymbols(Symbols = as.character(input$StockCode), src = "yahoo",auto.assign = FALSE)
    
  })
  
  
  stockDivs <- reactive({
    
    getDividends(as.character(input$StockCode))
    
  })
  
  
  bolinger_band_date <- reactive({
    
    data = stockPrices()
  
    if(input$plot3_buttons == "3mon") {
      last(data, '3 months')
    }
    else if(input$plot3_buttons == "6mon") {
      last(data, '6 months')
    }
    else if(input$plot3_buttons == "ytd") {
      last(data, '12 months')
    }
    else if(input$plot3_buttons == "all") {
      data
    }
  })
  
  
  dmi_date <- reactive({
    
    data = stockPrices()
    
    if(input$plot6_buttons == "3mon") {
      last(data, '3 months')
    }
    else if(input$plot6_buttons == "6mon") {
      last(data, '6 months')
    }
    else if(input$plot6_buttons == "ytd") {
      last(data, '12 months')
    }
    else if(input$plot6_buttons == "all") {
      data
    }
  })
  
  CCI_date <- reactive({
    
    data = stockPrices()
    
    if(input$plot7_buttons == "3mon") {
      last(data, '3 months')
    }
    else if(input$plot7_buttons == "6mon") {
      last(data, '6 months')
    }
    else if(input$plot7_buttons == "ytd") {
      last(data, '12 months')
    }
    else if(input$plot7_buttons == "all") {
      data
    }
  })
  
  
  mavg_date <- reactive({
    
    data = stockPrices()
    
    if(input$plot8_buttons == "3mon") {
      last(data, '3 months')
    }
    else if(input$plot8_buttons == "6mon") {
      last(data, '6 months')
    }
    else if(input$plot8_buttons == "ytd") {
      last(data, '12 months')
    }
    else if(input$plot8_buttons == "all") {
      data
    }
  })
  
  predictions <- reactive({
    
    data = last(stockPrices(), '12 months')
    fit <- Arima(data[,6],
                 order = c(0,1,1),
                 include.drift = TRUE)
    forecast(fit)
  })
   
  
  
  
  # Stock Price Time Series
  output$plot1 <- renderHighchart({
    
    highchart(type = "stock") %>% 
      hc_add_series(stockPrices(), type = "line")
    
  })
  
  
  
  # Dividends Plot
  output$plot2 <- renderHighchart({
    
    highchart(type = "stock") %>% 
      hc_add_series(stockDivs(), type = "line", color = "red")
    
  })
  
  # Daily Return Plot
  output$plot4 <- renderHighchart({
    
    highchart(type = "stock") %>% 
      hc_add_series(dailyReturn(stockPrices()), type = "line", color = "orange")
    
  })
  
  
  # Boolinger Bands Plot
  output$plot3 <- renderPlot({
    
    chartSeries(bolinger_band_date(),
                TA='addBBands()',
                name = "",
                theme = chartTheme("white",bg.col = "white"))
  })
  
  
  # ADX Plot
  output$plot6 <- renderPlot({
    
    chartSeries(dmi_date(),
                TA='addADX()',
                name = "",
                theme = chartTheme("white",bg.col = "white"))
  })
  
  
  # Commodity Channel Index Plot
  output$plot7 <- renderPlot({
    
    chartSeries(CCI_date(),
                TA='addCCI()',
                theme = chartTheme("white",bg.col = "white"),
                name = "")
  })
  
  
  
  # Moving Average Lines
  output$plot8 <- renderPlot({
    
    chartSeries(mavg_date(),
                type = "line",
                name = "",
                theme = chartTheme("white",bg.col = "white"))
    
    
    if(input$mavg_buttons == "SMA") {
      addSMA(n = input$bands, on = 1, overlay = TRUE, col = "red")
    }
    
    else if(input$mavg_buttons == "EMA") {
      addEMA(n = input$bands, on = 1, overlay = TRUE, col = "red")
    }
    
    else if(input$mavg_buttons == "WMA") {
      addWMA(n = input$bands, on = 1,  overlay = TRUE, col = "red")
    }
    
    else if(input$mavg_buttons == "DEMA") {
      addDEMA(n = input$bands, on = 1, overlay = TRUE, col = "red")
    }
    
    else if(input$mavg_buttons == "EVWMA") {
      addEVWMA(n = input$bands, on = 1,  overlay = TRUE, col = "red")
    }
    
    else if(input$mavg_buttons == "ZLEMA") {
      addZLEMA(n = input$bands, on = 1, overlay = TRUE, col = "red")
    }   
  })
  
  

  
  # Prediction Plots:
  output$plot9 <- renderPlot({
    
    plot(predictions(), col = "red",
         xlab = "Days of The Year",
         ylab = "Stock Price")
  })
  
  
  output$plot10 <- renderHighchart({
    
    highchart(type = "stock") %>% 
      hc_add_series(predictions(), type = "line", color = "blue")
    
  })

  
  
  
  
})
