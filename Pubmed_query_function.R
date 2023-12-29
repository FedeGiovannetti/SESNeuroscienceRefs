
#devtools::install_github("dami82/easyPubMed")

pubmed_query <- function(query){
  
  # Parameter description:
  # query= PubMed research query (e.g. "(neuroscience) AND (poverty)")
  
  require(tidyverse)
  require(easyPubMed)
  require(XML)
  require(stringi)
  
  # gc() # Esto es para que no aparezca "elapsed time limit" pero hay que probarlo
  
  epm_dataset <- epm_query(query) %>% 
    epm_fetch(format = 'xml') %>% 
    epm_parse() %>% 
    get_epm_data()
  
  epm_dataset <- epm_dataset %>%  
    
    mutate(across(everything(), ~if_else(nchar(.x) > 32766, NA, .x))) %>% 
    select(pmid, title, authors, abstract, year, month, day, journal, everything())
    # select(-coi)
  
  
  write.csv(epm_dataset, paste("SESneuroscienceRefs/Data/dataset_pubmed_", query, ".csv"),
            row.names = F)
  
  # return(epm_dataset)
}



