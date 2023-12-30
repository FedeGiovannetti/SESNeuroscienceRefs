

library(shiny)



# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("PubMed query for SES and Neuroscience references"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
    selectInput(inputId = "query",
                label = "Query:",
                c("((SES) OR (poverty)) AND (neuroscience)",
                  "((SES) OR (poverty)) AND (brain)")),
      
    # #   
    #   # Input: Slider for the number of bins ----
    sliderInput(inputId = "interval",
                label = "Years interval:",
                min = 1,
                max = 10,
                value = 5),
    
    p("Download the complete list of references in the preferred format:"),
    
    downloadButton(outputId = "downloadcsv", icon = NULL, class = "butt",
                   label = tagList(
                     tags$span(".csv",
                               style = "font-weight: bold"),
                     tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                   )
    ),
    
    downloadButton(outputId = "downloadxlsx", icon = NULL, class = "butt",
                   label = tagList(
                     tags$span(".xlsx",
                               style = "font-weight: bold"),
                     tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                   )
    )
    
    ),
    
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
## Main Plot
      
      plotOutput(outputId = "distPlot",
                 height = "70vh"),
      
## Table with latest publications references

      h3("Latest publications\n"),
      p(" "),
      
      tableOutput("table")
      

      
      
      
    )
  ),
  
  
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css")
  )
  
  
  
)





