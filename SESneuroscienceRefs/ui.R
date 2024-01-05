

library(shiny)
source("query_dictionary.R")



ui <- 
  
  
  fluidPage(
  
    tags$head(tags$link(rel = "shortcut icon", href = "SESneuroscienceRefs/www/favicon.ico")),
    
    tags$style(type = "text/css", ".irs-grid-pol.small {height: 0px;}"), ## Remove intermediate breaks in sliderInput
    

    titlePanel("SESNeuroscienceRefs"),
    h4("A Web-App for literature exploration in SES, poverty and neuroscience research"),
    
    markdown("`SESNeuroscienceRefs` provides updated information on
      recent scholar publications related to the field of SES and Neuroscience studies. <br>
      For now, it only includes results obtained from Pubmed by searching built-in or custom queries. 
      Built-in queries are delivered inmediatly while custom queries take some minutes.
      Future versions may include other scholar databases and queries. \n
      Please refer to the [GitHub repo](https://github.com/FedeGiovannetti/SESNeuroscienceRefs) for more information, commentaries or suggestions."),
    
    
    navbarPage("",
               
               # Built-in queries ----
               
               tabPanel("Built-in queries",
    

    sidebarLayout(
      
      
      

      sidebarPanel(
        
        
      selectInput(inputId = "query",
                  label = "Query:",
                  (query_dict)),
        

      sliderInput(inputId = "interval",
                  label = "Years interval:",
                  min = 1,
                  max = 10,
                  value = 5),
      
  
      ## Dataset download    ----
      
      p(" \nDownloads"),  
  
      
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
      
  
      
      ## Plot download ----
      
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
      
  
      
      ## Plot data download ----
      
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
                  selected = "Please select a file extension"),
      
      
      h6("v0.1.0"),
      h6(markdown("Please cite as: Giovannetti, F., & Lipina, S. J. (2024). SESNeuroscienceRefs.
         Zenodo. [https://doi.org/10.5281/zenodo.10454409](https://doi.org/10.5281/zenodo.10454409)"))

  ),
  

    
    
    
    
    
    ## Main panel for displaying outputs ----
    mainPanel(
      
## Main Plot
      
      plotOutput(outputId = "distPlot",
                 height = "70vh"),
      

      
## Table with latest publications references ----

      h3("Latest publications\n"),
      p(" "),
      
      tableOutput("table")
      

      
      
      
    )
  ),
  
  
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css")
  ),
  
  
  
),


# Custom queries tab ----


tabPanel("Custom queries",
         
         
         p(markdown("Here you can search for your own queries.
                    All sent queries will be stored and may be added to the built-in query list in the near future.<br>
                    **Please take into consideration that the custom queries might take 5 or 10 minutes to load due to the API's databases restrictions.***")),


         sidebarLayout(




           sidebarPanel(


             textInput(inputId = "custom_query",
                         label = "Enter your desired query:",
                         ""),

             actionButton("submit", "Submit"),
             
             textOutput("text"),


             sliderInput(inputId = "custom_query_interval",
                         label = "Years interval:",
                         min = 1,
                         max = 10,
                         value = 5),


             ## Custom query Dataset download    ----

             p(" \nDownloads"),


             downloadButton(outputId = "custom_query_downloaddata", icon = NULL, class = "butt",
                            label = tagList(
                              tags$span("Download complete dataset",
                                        style = "font-weight: bold"),
                              tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                            )
             ),

             selectInput(inputId = "custom_query_dataextension",
                         label = "",
                         c("Please select a file extension",
                           ".csv",
                           ".xlsx"
                         ),
                         selected = "Please select a file extension"),



             ## Plot download ----

             p("\n "),



             downloadButton(outputId = "custom_query_downloadplot", icon = NULL, class = "butt",
                            label = tagList(
                              tags$span("Download plot",
                                        style = "font-weight: bold"),
                              tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                            )
             ),

             selectInput(inputId = "custom_query_plotextension",
                         label = "",
                         c("Please select a file extension",
                           ".png",
                           ".svg",
                           ".pdf"
                         ),
                         selected = "Please select a file extension"),



             ## Plot data download ----

             p("\n "),


             downloadButton(outputId = "custom_query_downloadplotdata", icon = NULL, class = "butt",
                            label = tagList(
                              tags$span("Download plot data",
                                        style = "font-weight: bold"),
                              tags$head(tags$style(".butt{background:#2bc37f;} .butt{border-color:#FFFFFF} .butt{color: #FFFFFF;}"))
                            )
             ),

             selectInput(inputId = "custom_query_plotdataextension",
                         label = "",
                         c("Please select a file extension",
                           ".csv",
                           ".xlsx"
                         ),
                         selected = "Please select a file extension"),


             h6("v0.1.0"),
             h6(markdown("Please cite as: Giovannetti, F., & Lipina, S. J. (2024). SESNeuroscienceRefs.
         Zenodo. [https://doi.org/10.5281/zenodo.10454409](https://doi.org/10.5281/zenodo.10454409)"))

           ),
         
         





           ## Main panel for displaying outputs ----
           mainPanel(

             ## Main Plot

             plotOutput(outputId = "customPlot",
                        height = "70vh"),



             ## Table with latest publications references ----

             h3("Latest publications\n"),
             p(" "),

             tableOutput("custom_query_table")





           )
         ),



         tags$head(
           tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css")
         ),



)

)
)




