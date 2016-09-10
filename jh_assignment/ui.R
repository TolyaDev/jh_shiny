library(shiny)
library(data.table)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("type", 
                         label = h3("Checkbox group"), 
                         choices = list("NONPOINT", 
                                        "POINT",
                                        "NON-ROAD", 
                                        "ON-ROAD"),
                         selected = "NONPOINT")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("emissions.plot")
    )
  )
))
