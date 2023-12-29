
source("Pubmed_query_function.R")

pubmed_query("((SES) OR (poverty)) AND (neuroscience)")
pubmed_query("((SES) OR (poverty)) AND (brain)")


d = read.csv(paste("SESNeuroscienceRefs/Data/dataset_pubmed_", "((SES) OR (poverty)) AND (brain)" , ".csv"))

"dataset_pubmed_ ((SES) OR (poverty)) AND (brain) .csv"
"dataset_pubmed_ ((SES) OR (poverty)) AND (brain) .csv"