\name{generate_gpaxis}
\alias{generate_gpaxis}
\title{generate_gpaxis}
\usage{generate_gpaxis(dataset,xvar,yvar,daxis,cmargins)}
\description{Generates transparent ggplot and returns desired axis grob}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{hplot}
\arguments{
\item{dataset}{data set to be used}
\item{xvar}{string column name of desired x axis}
\item{yvar}{string column name of desired y axis}
\item{daxis}{string value of the desired axis}
\item{cmargins}{margin space surrounding the plot}
}
\examples{\dontrun{
# example of use
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
xvar <- "carat"
yvar <- "price"
plot.yaxis.grob <- generate_gpaxis(dsmall, xvar, yvar, daxis = "y", cmargins=c(0.1,-0.4))
}}
