
source("SESneuroscienceRefs/Functions.R")
source("SESneuroscienceRefs/query_dictionary.R")
library(purrr)

map(query_dict, pubmed_query_write)
map(query_dict, reference_table)
