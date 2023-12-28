
source("Pubmed_query_function.R")

dataset <- pubmed_query("(neuroscience) AND (poverty)")


openxlsx::write.xlsx(dataset,"SESneuroscienceRefs/Data/dataset_pubmed.xlsx")


