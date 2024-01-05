# Function to query. Returns a df with query result ----

pubmed_query <- function(query){
  
  # Parameter description:
  # query= PubMed research query (e.g. "(neuroscience) AND (poverty)")
  
  require(tidyverse)
  require(easyPubMed)
  require(XML)
  
  # gc() # Esto es para que no aparezca "elapsed time limit" pero hay que probarlo
  
  epm_dataset <- epm_query(query) %>% 
    epm_fetch(format = 'xml', api_key = "4467c7b8740f9096dc3d17900119e5c8c808") %>% 
    epm_parse() %>% 
    get_epm_data()
  
  epm_dataset <- epm_dataset %>%  
    
    mutate(across(everything(), ~if_else(nchar(.x) > 32766, NA, .x))) %>% 
    select(pmid, title, authors, abstract, year, month, day, journal, everything())

  
  return(epm_dataset)
}


# Function to save query df result to a csv file ----

pubmed_query_write <- function(query){
  
  # Parameter description:
  # query= PubMed research query (e.g. "(neuroscience) AND (poverty)")
  # Dependency: pubmed_query()

  
  
  write.csv(pubmed_query(query), paste("SESneuroscienceRefs/Data/dataset_pubmed_",
                               gsub('"', '', gsub('\\*','',query)), # Removing quotation marks inside the query for better file naming
                               ".csv"),
            row.names = F)
  
  
}





# Function to make built-in queries reference table and save it as a csv file ----

reference_table <- function(query){
  
  # Parameter description:
  # query= PubMed research query (e.g. "(neuroscience) AND (poverty)")
  
  require(rcrossref)
  require(tidyverse)
  
  dataset = read.csv(paste("SESneuroscienceRefs/Data/dataset_pubmed_",
                           gsub('"', '', gsub('\\*','',query)), # Removing quotation marks inside the query for better file naming
                           ".csv"))
  
  references = dataset %>% 
    mutate(Date = as.Date(paste(year, month, day,sep="-"))) %>% 
    select(doi, Date) %>% 
    slice_max(Date, n = 10) %>% 
    mutate(Reference = unlist(cr_cn(dois = paste("https://doi.org/", doi, sep = ""),
                                    format = "text", style = "apa",))) %>% 
    select(Reference, doi, Date)
  
  
  write.csv(references, paste("SESneuroscienceRefs/Data/references_pubmed_",
                              gsub('"', '', gsub('\\*','',query)), # Removing quotation marks inside the query for better file naming
                              ".csv"),
            row.names = F)
  
}



# Function to make custom query reference from a df returned from pubmed_query. Returns a df


reference_table_custom <- function(query_database){
  
  # Parameter description:
  # query_database= a query df as returned by pubmed_query
  
  require(rcrossref)
  require(tidyverse)
  
  references = query_database %>% 
    mutate(Date = as.Date(paste(year, month, day,sep="-"))) %>% 
    select(doi, Date) %>% 
    slice_max(Date, n = 10) %>% 
    mutate(Reference = unlist(cr_cn(dois = paste("https://doi.org/", doi, sep = ""),
                                    format = "text", style = "apa",))) %>% 
    select(Reference, doi, Date)
  
  return(references)
  
}



