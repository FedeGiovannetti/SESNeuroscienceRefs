# SESNeuroscienceRefs

SESNeuroscienceRefs is a web app hosted at http://fedegiovannetti.shinyapps.io/sesneurosciencerefs and developed in R with {shiny}. It's main objetive is to provide updated information on recent scholar publications related to the field of SES and Neuroscience studies. For now, it only includes results obtained from Pubmed by introducing a certain query ("(neuroscience) AND (poverty)"). But future versions may include other scholar databases.

The main features of SESNeuroscienceRefs include
1. Providing a dataset dataset of all references related to a certain query. This is offered in two distinct formats: csv and xlsx.  
2. Providing an interactive plot of the evolution in the number of publications along the years. The app includes the posibility of manipulating the x-axis in order to group publications in different intervals of years.
3. The daily update of the references. This is done via Github Actions and updates at 00:00hs GMT-3.

## Commentaries

1. The yearly frequence in the provided plot may show some differences with the one available in PubMed. This relates to the fact that here we are considering year of final publication and not year of electronic publication (which is often a few months before).
2. The hour of update is aproximate, sometimes it migth update a few minutes after the expected time. This is because Github Actions may delay some jobs in periods of high loads of workflow runs according to [official documentation](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule)
