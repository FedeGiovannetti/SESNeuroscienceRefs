
source("Functions.R")
source("SESneuroscienceRefs/query_dictionary.R")

map(query_dict, pubmed_query)
map(query_dict, reference_table)

pubmed_query("(('socioeconomic status') OR (poverty)) AND (neuroscience)")
reference_table("(('socioeconomic status') OR (poverty)) AND (neuroscience)")

pubmed_query("(('socioeconomic status') OR (poverty)) AND (brain)")
reference_table("(('socioeconomic status') OR (poverty)) AND (brain)")
