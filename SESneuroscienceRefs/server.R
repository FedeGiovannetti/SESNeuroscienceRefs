

library(shiny)
library(tidyverse)
library(openxlsx)


server <- function(input,output, session) {
  
  
  dataset <- reactive({
    path <- paste("https://raw.githubusercontent.com/FedeGiovannetti/SESNeuroscienceRefs/main/SESneuroscienceRefs/Data/dataset_pubmed_%20",
                  gsub(" ", "%20", input$query) ,
                  "%20.csv", sep = "")
    read.csv(url(path))
  })
  
  reference <- reactive({
    path <- paste("https://raw.githubusercontent.com/FedeGiovannetti/SESNeuroscienceRefs/main/SESneuroscienceRefs/Data/references_pubmed_%20",
                  gsub(" ", "%20", input$query) ,
                  "%20.csv", sep = "")
    read.csv(url(path))
  })
  
# Main plot
  
  output$distPlot <- renderPlot({
    

    breakstart = seq(min(dataset()$year, na.rm = T), max(dataset()$year, na.rm = T), by = input$interval)
    breakend = breakstart + input$interval  
    x_label = paste(breakstart, "-", breakend - 1)
    
    grouped_dataset = dataset() %>% 
      summarise(n = n(), .by = year) 
    
    
    grouped_dataset%>% 
      mutate(year_grouped = cut(year,
                                breaks = c(min(year, na.rm = T), breakend),
                                labels = x_label,
                                right = F,
                                ordered_result = T)) %>% 
      
      filter(!is.na(year_grouped)) %>%
      # 
      complete(year_grouped, fill = list(n = 0))%>%
      summarise(n = sum(n), .by = year_grouped) %>%  

      
      ggplot(aes(x = year_grouped, n))+
      geom_col(position = "identity", fill = "lightblue")+
      geom_text(aes(label = n), vjust = -1, size = 7)+
      scale_y_continuous(expand = expansion(c(0,0.2)))+
      labs(title = paste(input$query),
           subtitle = paste("n =", (sum(grouped_dataset$n)) ))+
      xlab("\nYears")+
      theme_minimal(base_size = 20)+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 17),
            plot.title = element_text(size = 30),
            plot.subtitle = element_text(size = 20))
    
  })

# Dataset downloaders 
  
  output$downloadcsv <- downloadHandler(
    filename = function() {
      paste("dataset_pubmed-", input$query, Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(dataset, file)
    }
  )
  
  output$downloadxlsx <- downloadHandler(
    filename = function() {
      paste("dataset_pubmed-", input$query, Sys.Date(), ".xlsx", sep="")
    },
    content = function(file) {
      openxlsx::write.xlsx(dataset(), file)
    }
  )
  
# Latest publications references
  
  # output$table <- renderTable(read.csv(paste("Data/references_pubmed_", input$query, ".csv")))
  output$table <- renderTable(reference())
  
}
  