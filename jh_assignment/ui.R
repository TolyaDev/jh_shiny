library(shiny)
library(data.table)

shinyUI(fluidPage(
  h1('Plot and prediction of PM2.5 amount emmited in the city of Baltimore'),
  fluidRow(
    column(5,
           checkboxGroupInput("type", 
                              label = "Emissions source types to plot and to use with predict function:", 
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
                        label = "A year for which predict amount of PM2.5",
                        value = 2010, min = 2009, max=2030, step = 1),
           actionButton("submit.button","Submit")
    ),
    column(7,
           p('Predicted amount of PM2.5 emitted for specified year and sources'),
           verbatimTextOutput('emissions.predict')
    )
  ),
  hr(),
  h1('Documentation'),
  h3('1 Description'),
  p('This app allows user to see amount of PM2.5 emmited in USA in the city of Baltimore in years 1999-2008. Dataset used is National Emissions Inventory (NEI) provided by Environmental Protection Agency (EPA).'),
  h3('2 Functions'),
  h4('2.1 Building the plot'),
  p('Plot (at the right of GUI) is built using emission source types specified at the left with checkboxes. To built the plot, hit on checkboxes.'),
  h4('2.2 Predict the amount of PM2.5'),
  p('Prediction of PM2.5 emissions is made using:'),
  p('1) year specified by user below the checkboxes'),
  p('2) source types specified by checkboxes.'),
  p('To start prediction, hit "Submit" button. Result will appear at the right of year input field.'),
  p('Linear model is used')
))