# if (FALSE) {
  ui <- fluidPage(
    p("Choose a dataset to download."),
    selectInput("dataset", "Dataset", choices = c("mtcars", "airquality")),
    downloadButton("downloadData", "Download")
  )
  
  server <- function(input, output) {
    # The requested dataset
    data <- reactive({
      get(input$dataset)
    })
    
    output$downloadData <- downloadHandler(
      filename = function() {
        # Use the selected dataset as the suggested file name
        paste0(input$dataset, ".csv")
      },
      content = function(file) {
        # Write the dataset to the `file` that will be downloaded
        write.csv(data(), file)
      }
    )
  }
  
  shinyApp(ui, server)
# }
