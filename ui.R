library(shiny)
library(ggplot2)
library(shinythemes)     
library(choroplethr)      
library(choroplethrMaps)
library(leaflet)

shinyUI(fluidPage(
#fluidPage(
  titlePanel("Buy Cheap Used Cars Here!"),
  theme = shinythemes::shinytheme('flatly'),
  # Create a new Row in the UI for selectInputs
  fluidRow(

    column(2,
           selectInput("brand",
                       "Brand:",
                       multiple = TRUE,
                       c("All",
                       unique(as.character(Cars$Brand))))
    ),
    
    column(2,
           selectInput("model",
                       "Model:",
                       multiple = TRUE,
                       c("All",
                       unique(as.character(Cars$Model))))
    ),
    
    column(2,
           selectInput("color",
                       "Color:",
                       multiple = TRUE,
                       c("All",
                       unique(as.character(Cars$Color))))
    ),
    
    column(2,
           selectInput("state",
                       "State:",
                       multiple = TRUE,
                       c("All",
                       unique(as.character(Cars$State))))
    ),
    
    column(2,
           selectInput("price",
                       "Price:",
                       multiple = TRUE,
                       c("All",
                       unique(as.character(Cars$Price))))
  ),
  
  column(2,
         selectInput("mileage",
                     "Mileage:",
                      multiple = TRUE,
                      c("All",
                      unique(as.character(Cars$Mileage))))
  ),
  
  column(2,
         selectInput("year",
                     "Year:",
                     multiple = TRUE,
                     c("All",
                     unique(as.character(Cars$Year))))
  ),
  
  column(4,
  selectInput('x', 'Build a regression model of Price against:',
              choices = names(Cars)[-1])

  )
  ),
  
  mainPanel(width = 12, 
            tabsetPanel( 
              
              tabPanel(title = 'Car Table',
                       DT::dataTableOutput("table")),
                
              tabPanel(title = 'Regression Plot',
                       plotOutput('regPlot')),
              
              tabPanel(title = 'General Map',
                       leafletOutput("map"))
                       #leafletOutput("map"))
                      
                       )  
              )
  ))


