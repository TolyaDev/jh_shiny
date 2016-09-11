library(shiny)
library(data.table)

shinyUI(fluidPage(
  title = "Plotting and linear prediction of PM2.5 amount emmited in a city of Baltimore",
  fluidRow(
    column(5,
           h4("Diamonds Explorer"),
           checkboxGroupInput("type", 
                              label = h4("Emissions source types to plot and to use with predict function"), 
                              choices = list("NONPOINT", 
                                             "POINT",
                                             "NON-ROAD", 
                                             "ON-ROAD"),
                              selected = "NONPOINT")
    ),
    column(7,
           plotOutput("emissions.plot")
    )
  ),
  hr(),
  fluidRow(
    column(5,
           numericInput(inputId="year", 
                        label = h4("A year for which predict amount of PM2.5"),
                        value = 2010, min = 2009, max=2030, step = 1),
           actionButton("submit.button","Submit")
    ),
    column(7,
           h4('Predicted amount of PM2.5 emitted for specified year and sources'),
           verbatimTextOutput('emissions.predict')
    )
  )
))