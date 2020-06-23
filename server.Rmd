library(shiny)
library(ggplot2)
library(leaflet)
library(htmltools)

Carss_df <-read.csv("statelatlong.csv",sep=",")
Cars_df <-read.csv("USA_cars_datasets.csv",sep=",")

Cars <- merge(Cars_df, Carss_df, by="Cities")

#head(Cars)

data <- Cars

shinyServer(function(input, output,session) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    #data <- Cars
    
    if (input$mileage != "All") {
      data <- data[data$Mileage == input$mileage,]
    }
    if (input$brand != "All") {
      data <- data[data$Brand == input$brand,]
    }
    if (input$model != "All") {
      data <- data[data$Model == input$model,]
    }
    if (input$price != "All") {
      data <- data[data$Price == input$price,]
    }
    if (input$color != "All") {
      data <- data[data$Color == input$color,]
    }
    if (input$state != "All") {
      data <- data[data$State == input$state,]
    }
    if (input$year != "All") {
      data <- data[data$Year == input$year,]
    }
    
    output$regPlot <- renderPlot({
      regFormula <- reactive({
        as.formula(paste('Price ~', input$x))
      })
      
      output$regPlot <- renderPlot({
        par(mar = c(4, 4, .1, .1))
        plot(regFormula(), data = Cars, pch = 19)
        
      })
    })
    data
  }))
  
  
  output$map <- renderLeaflet({
    my_map <- data.frame(Cities = Cars$Cities,
                         Pric = Cars$Price,
                         Bran = Cars$Brand,
                         Lat =  Cars$Latitude,
                         Long = Cars$Longitude,
                         Year = Cars$Year,
                         Cond = Cars$Condition,
                         Mile=  Cars$Mileage,
                         Col =  Cars$Color,
                         State = Cars$State)
    
    
    
    map <- my_map %>%
      leaflet() %>%
      addTiles() %>%
      addCircleMarkers(popup= paste
                       ("<br>Brand: ", 
                         htmlEscape(Cars$Brand),
                         "<br>Model: ", 
                         htmlEscape(Cars$Model),
                         "<br>Mileage: ", 
                         htmlEscape(Cars$Mileage),
                         "<br>Year: ", 
                         htmlEscape(Cars$Year),
                         "<br>Cities: ", 
                         htmlEscape(Cars$Cities),
                         "<br>State: ", 
                         htmlEscape(Cars$State),
                         "<br>Color: ",
                         htmlEscape(Cars$Color),
                         "<br>Price: ",
                         formatC(Cars$Price,
                                 format = "d", big.mark = ",")
                         
                       ))
    
    
    map
    
  })
  
   
})
