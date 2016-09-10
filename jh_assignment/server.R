library(shiny)
library(data.table)
library(ggplot2)

data.nei.baltimore <- fread('data/data_nei_baltimore.csv')
data.nei.baltimore[,summ:=sum(Emissions), by=list(year, type)]

shinyServer(function(input, output) {
  #' TODO: 
  #' 1. handle empty data error
  #' 2. add some more user input - probably other cities, or calculate some value like sum of something
  #' 3. explain types in GUI
  
  output$emissions.plot <- renderPlot({
    data.sum <- data.nei.baltimore[type %in% input$type, sum(Emissions), by=list(year)]
    setnames(data.sum, c('year', 'emissions'))
    
    data.nei.baltimore[, summ_a:=sum(summ)]
    ggplot(data.sum, aes(year, emissions, group=1)) + 
      geom_point() + 
      geom_line() + 
      ylab("Emissions summ") + 
      ggtitle("emissions")
    
    # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
