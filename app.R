library(shiny)
library(shiny)
library(ggplot2)  # for the diamonds dataset

Cars <- read.csv("USA_cars_datasets.csv")
data(Cars)
data(mtcars)
data("iris")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
         
        'input.dataset === "Cars"',
          checkboxGroupInput("Cars", "Columns in Cars data to show:",
                             names(Cars), selected = names(Cars)),
        ),
      
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText("Click the column header to sort a column.")
      ),
      conditionalPanel(
        'input.dataset === "iris"',
        helpText("Display 5 records by default.")
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Cars", DT::dataTableOutput("mytable1")),
        tabPanel("mtcars", DT::dataTableOutput("mytable2")),
        tabPanel("iris", DT::dataTableOutput("mytable3"))
      )
    )
    ))

server <- function(input, output) {
  
  # choose columns to display
  Cars2 = Cars[sample(nrow(Cars), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(Cars2[, input$Cars, drop = FALSE])
  })
  

  
  # sorted columns are colored now because CSS are attached to them
  
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(orderClasses = TRUE))
  })
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })
  
}

shinyApp(ui, server)