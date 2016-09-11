library(shiny)
library(data.table)
library(ggplot2)
library(gtools)
library(caret)

data.nei.baltimore <- fread('data/data_nei_baltimore.csv')
data.nei.baltimore$V1 <- NULL
data.nei.baltimore$fips <- NULL
data.nei.baltimore$SCC <- NULL
data.nei.baltimore$Pollutant <- NULL
data.nei.baltimore[,summ:=sum(Emissions), by=list(year, type)]
data.nei.baltimore$year <- as.numeric(data.nei.baltimore$year)

shinyServer(function(input, output) {
  #' TODO: 
  #' 1. handle empty data error
  #' 2. add some more user input - probably other cities, or calculate some value like sum of something
  #' 3. explain types in GUI
  #' 4. use some bigger city? to have more data
  
  output$emissions.plot <- renderPlot({
    if(invalid(input$type)){
      return()
    } 
    data.sum <- data.nei.baltimore[type %in% input$type, sum(Emissions), by=list(year)]
    setnames(data.sum, c('year', 'emissions'))
    
    data.nei.baltimore[, summ_a:=sum(summ)]
    ggplot(data.sum, aes(year, emissions, group=1)) + 
      geom_point() + 
      geom_line() + 
      ylab("Amount of PM2.5 emitted, tons") + 
      ggtitle("Baltimore PM2.5 emissions")
  })
  prediction <- eventReactive(input$submit.button, {
    data.sum <- data.nei.baltimore[type %in% input$type, sum(Emissions), by=list(year)]
    setnames(data.sum, c('year', 'emissions'))
    model <- lm(emissions ~ year, data.sum)
    result <- predict(model, data.table(year=input$year))
  })
  output$emissions.predict <- renderText({
    result <- prediction()
    paste(result)
  })
})
