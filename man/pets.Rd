\name{pets}
\alias{pets}
\title{
Calculate the Potential Extinction upon Time Series (PETS) index.
}
\description{
The PETS index calculate the completeness of time series for a given community based on occurrence data. 
Incomplete time series for recent year can be due to local extinction and/or lack of knowledge.
}
\usage{
pets<-function(taxa, time, obs_type=NULL, fauna=NULL, plot=T, colours=c("red","green","blue","orange","purple"),
persistence="palegreen", absence="pink", end=NULL)
}
\arguments{
  \item{taxa}{
A vector indicating the species membership of each record.
}
  \item{time}{
A vector indicating the year of collection of each record
}
  \item{obs_type}{
An optional vector indicating the type of observation (e.g. collection, citizen science etc)
}
  \item{fauna}{
An optional vector indicating the reference species list to be matched with the "taxa" vector.
}
  \item{plot}{
Logical, if TRUE the plot is returned.
}
  \item{colours}{
A list of colours to be attributed to the different categories of obs_type.
}
  \item{persistence}{
The colour to be attributed to the persistence segment in the plot.
}
\item{end}{
The last year for the calculation of the PETS index, if NULL the last year in the year vector is used.
}
}
\details{
The difference between the first and last year of existing records is considered as the persistence of a species in a given area while time since the last observation (absence) is considered as continuos measure for potential extinction. 
The PETS algorithm measure which is the overall fraction in a community of the potential extinction (absence) against the total time since the first observation (persistence+absence) on the entire community.
}
\value{
\item{extinctionP}{
The value of the PETS index.
}
\item{table}{
The table containing the list of species together with their first and last obsrevations.
}
}
\references{
Labadessa, R., Cagnetta, G., Desaphy, J. F., Bonifacino, M., Dodaro, G., Festa, D., Monterastelli, E., Papa, V., E., Zollo, L., Balletto, E., DAPPORTO, L. (2021). Using occurrence data to evaluate extinction reveals a strong resilience of butterflies in a National Park of Southern Europe (Alta Murgia National Park). Journal of Insect Biodiversity, 28(1), 1-12.
}
\author{
Leonardo Dapporto
}
\examples{

# Inspect the example dataset
head(gransasso)

# Run the simplest analysis with only species and years
pets_run<-pets(gransasso$scientificName,gransasso$year)
pets_run

# Impose the last year of sampling (e.g. end=2021) and visualise different kinds of observations by including a obs_type vector.

pets_run2<-pets(gransasso$scientificName,gransasso$year, obs_type=gransasso$basisOfRecord, end=2021)
}
\keyword{local extinction}
