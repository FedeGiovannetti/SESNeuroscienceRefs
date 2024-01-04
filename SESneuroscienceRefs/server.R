

library(shiny)
library(tidyverse)
library(svglite)
library(openxlsx)


server <- function(input,output, session) {
  
  # version <- "v0.1.0",
  
  dataset <- reactive({
    path <- paste("https://raw.githubusercontent.com/FedeGiovannetti/SESNeuroscienceRefs/main/SESneuroscienceRefs/Data/dataset_pubmed_%20",
                  gsub(" ", "%20", gsub('"', '', gsub('\\*', '', input$query))),
                  "%20.csv", sep = "")
    read.csv(url(path), fileEncoding = "latin1")
  })
  
  reference <- reactive({
    path <- paste("https://raw.githubusercontent.com/FedeGiovannetti/SESNeuroscienceRefs/main/SESneuroscienceRefs/Data/references_pubmed_%20",
                  gsub(" ", "%20", gsub('"', '', gsub('\\*', '', input$query))) ,
                  "%20.csv", sep = "")
    read.csv(url(path))
  })
  
  # Dataset downloaders 
  
  # output$downloaddata <- downloadHandler(
  #   
  #   
  #   filename = function() {
  #     paste("dataset_pubmed-", gsub('\\*', '', input$query), Sys.Date(), input$dataextension, sep="")
  #   },
  #   content = function(file) {
  #     
  #     
  #     extensionlist = list(
  #       .xlsx =   write.xlsx(dataset() %>% 
  #                              select(title), file),
  #       .csv  = write.csv(dataset(), file, row.names = F))
  #     
  #     extensionlist$input$dataextension
  #     
  #     
  #   }
  # )
  
  output$downloaddata <- downloadHandler(
    filename = function() {
      paste("dataset_pubmed", input$query, Sys.Date(), input$dataextension, sep="")
    },
    content = function(file) {
      dataset <- dataset()  
      if (input$dataextension == ".xlsx") {
        openxlsx::write.xlsx(dataset, file)
      } else if (input$dataextension == ".csv") {
        write.csv(dataset, file, row.names = FALSE)
      } else {
        stop("Invalid file extension. Please choose either '.xlsx' or '.csv'.")
      }
    }
  )
  
  

  
  # Main plot
  
  grouped_dataset <- reactive({
    
    breakstart = seq(min(dataset()$year, na.rm = T), max(dataset()$year, na.rm = T), by = input$interval)
    breakend = breakstart + input$interval  
    x_label = paste(breakstart, "-", breakend - 1)
  
    dataset() %>% 
      summarise(n = n(), .by = year) %>%  
      mutate(year_grouped = cut(year,
                                breaks = c(min(year, na.rm = T), breakend),
                                labels = x_label,
                                right = F,
                                ordered_result = T)) %>% 
      
      filter(!is.na(year_grouped)) %>%
      # 
      complete(year_grouped, fill = list(n = 0))%>%
      summarise(n = sum(n), .by = year_grouped) 
    
}) 
    
  main_plot <- reactive({  
      
    grouped_dataset() %>% 
      ggplot(aes(x = year_grouped, n))+
      geom_col(position = "identity", fill = "lightblue")+
      geom_text(aes(label = n), vjust = -1, size = 7)+
      scale_y_continuous(expand = expansion(c(0,0.2)))+
      labs(title = paste(input$query),
           subtitle = paste("n =", (sum(grouped_dataset()$n)) ))+
      xlab("\nYears")+
      theme_minimal(base_size = 20)+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 17),
            plot.title = element_text(size = 20),
            plot.subtitle = element_text(size = 15),
            panel.background = element_rect(color = "white"),
            plot.background = element_rect(color = "white"))
    
  })

  
  output$distPlot <- renderPlot({
    
    main_plot()
    
  })
  
  # Plot downloader 
  
  output$downloadplot <- downloadHandler(
    

    
    filename = function() {
      paste("SESNeuroscienceRefs", gsub('"', '', input$query), Sys.Date(), input$plotextension, sep="")
    },
    content = function(file) {
      
      ggsave(filename = file ,dpi = 300,
             plot = main_plot(), device = gsub("\\.", "", input$plotextension),
             units = "px", width = 3508, height = 2480)
      

    }
  )

  # Plot data downloader
  
  output$downloadplotdata <- downloadHandler(
    filename = function() {
      paste("SESNeuroscienceRefs", input$query, Sys.Date(), input$plotdataextension, sep="")
    },
    content = function(file) {
      dataset <- grouped_dataset()  
      if (input$plotdataextension == ".xlsx") {
        openxlsx::write.xlsx(dataset, file)
      } else if (input$plotdataextension == ".csv") {
        write.csv(dataset, file, row.names = FALSE)
      } else {
        stop("Invalid file extension. Please choose either '.xlsx' or '.csv'.")
      }
    }
  )
  


# Latest publications references
  
  output$table <- renderTable(reference())
  
}
  