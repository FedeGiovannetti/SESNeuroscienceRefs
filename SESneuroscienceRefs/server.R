

library(shiny)
library(tidyverse)
library(openxlsx)

# Define server logic required to draw a histogram ----
server <- function(input,output, session) {
  
# Main plot
  
  output$distPlot <- renderPlot({
    
    dataset = read.csv("Data/dataset_pubmed.csv") 
    

    breakstart = seq(min(dataset$year), max(dataset$year), by = input$interval)
    breakend = breakstart + input$interval  
    x_label = paste(breakstart, "-", breakend - 1)
    
    grouped_dataset = dataset %>% 
      group_by(year) %>% 
      summarise(n = n()) 
    
    
    grouped_dataset%>% 
      mutate(year_grouped = cut(year,
                                breaks = c(1981, breakend),
                                labels = x_label,
                                right = F,
                                ordered_result = T)) %>% 
      
      complete(year_grouped, fill = list(n = 0))%>%
      summarise(n = sum(n), .by = year_grouped) %>%  
      
      ggplot(aes(x = year_grouped, n))+
      geom_col(position = "identity", fill = "lightblue")+
      geom_text(aes(label = n), vjust = -1, size = 7)+
      scale_y_continuous(expand = expansion(c(0,0.2)))+
      labs(title = paste("(neuroscience) AND (poverty)"),
           subtitle = paste("n =", sum(grouped_dataset$n)))+
      xlab("\nYears")+
      theme_minimal(base_size = 20)+
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 17),
            plot.title = element_text(size = 30),
            plot.subtitle = element_text(size = 20))
    
    
  })
  
# Downloader
  
  datacsv <- read.csv("Data/dataset_pubmed.csv")
  # dataxlsx <- openxlsx::read.xlsx("Data/dataset_pubmed.xlsx")
  
  output$downloadcsv <- downloadHandler(
    filename = function() {
      paste("dataset_pubmed-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(datacsv, file)
    }
  )
  
  output$downloadxlsx <- downloadHandler(
    filename = function() {
      paste("dataset_pubmed-", Sys.Date(), ".xlsx", sep="")
    },
    content = function(file) {
      openxlsx::write.xlsx(datacsv, file)
    }
  )
  
  # output$downloadxlsx <- downloadHandler(
  #   filename = function() {
  #     paste("dataset_pubmed-", Sys.Date(), ".xlsx", sep="")
  #   },
  #   content = function(file) {
  #     openxlsx::write.xlsx(dataxlsx, file)
  #   }
  # )
  
}
  