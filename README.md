# SESNeuroscienceRefs

SESNeuroscienceRefs is a web app hosted at http://fedegiovannetti.shinyapps.io/sesneurosciencerefs and developed in R with {shiny}. It's main objetive is to provide updated information on recent scholar publications related to the field of SES and Neuroscience studies. For now, it only includes results obtained from Pubmed by introducing a certain query ("(neuroscience) AND (poverty)"). But future versions may include other scholar databases.

The main features of SESNeuroscienceRefs include
1. Providing a dataset dataset of all references related to a certain query. This is offered in two distinct formats: csv and xlsx.  
2. Providing an interactive plot of the evolution in the number of publications along the years. The app includes the posibility of manipulating the x-axis in order to group publications in different intervals of years.
3. The daily update of the references. This is done via Github Actions and updates at 00:00hs GMT-3.
