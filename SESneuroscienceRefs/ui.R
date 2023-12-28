

library(shiny)



# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("PubMed query for SES and Neuroscience references"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
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
      plotOutput(outputId = "distPlot",
                 height = "70vh")
      
      
      
    )
  ),
  
  
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css")
  )
  
  
  
)





