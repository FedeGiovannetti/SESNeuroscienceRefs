

library(shiny)
source("query_dictionary.R")



# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("PubMed queries for SES and Neuroscience publications"),
  
  markdown("The main objective of `SESNeuroscienceRefs` is to provide updated information on
    recent scholar publications related to the field of SES and Neuroscience studies.\n
    Please refer to the [GitHub repo](https://github.com/FedeGiovannetti/SESNeuroscienceRefs) for more information."),
  
  # p("The main objective of SESNeuroscienceRefs is to provide updated information on
  #   recent scholar publications related to the field of SES and Neuroscience studies.
  #   Please refer to the [GitHub repo](https://github.com/FedeGiovannetti/SESNeuroscienceRefs) for more information."),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
    selectInput(inputId = "query",
                label = "Query:",
                (query_dict)),
      
    # #   
    #   # Input: Slider for the number of bins ----
    sliderInput(inputId = "interval",
                label = "Years interval:",
                min = 1,
                max = 10,
                value = 5),
    

    ## Dataset download    

    
    downloadButton(outputId = "downloaddata", icon = NULL, class = "butt",
                   label = tagList(
                     tags$span("Download complete dataset",
                               style = "font-weight: bold"),
                     tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                   )
    ),
    
    selectInput(inputId = "dataextension",
                label = "",
                c("Please select a file extension",
                  ".csv",
                  ".xlsx"
                ),
                selected = "Please select a file extension"),
    

    
    ## Plot download
    
    p("\n "),  
    

      
      downloadButton(outputId = "downloadplot", icon = NULL, class = "butt",
                     label = tagList(
                       tags$span("Download plot",
                                 style = "font-weight: bold"),
                       tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                     )
      ),

      selectInput(inputId = "plotextension",
                  label = "",
                  c("Please select a file extension",
                    ".png",
                    ".svg",
                    ".pdf"
                    ),
                  selected = "Please select a file extension"),
    

    
    ## Plot data download
    
    p("\n "),

    
    downloadButton(outputId = "downloadplotdata", icon = NULL, class = "butt",
                   label = tagList(
                     tags$span("Download plot data",
                               style = "font-weight: bold"),
                     tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                   )
    ),

    selectInput(inputId = "plotdataextension",
                label = "",
                c("Please select a file extension",
                  ".csv",
                  ".xlsx"
                ),
                selected = "Please select a file extension")

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





