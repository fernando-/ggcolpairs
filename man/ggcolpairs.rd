\name{ggcolpairs}
\alias{ggcolpairs}
\title{ggcolpairs - GGplot2 plots combined into a matrix based on dataset columns ...}
\usage{ggcolpairs(dataset, xlist, ylist, colour="default", ggdetails="default", margins="default", title="", legend="off")}
\description{ggcolpairs - GGplot2 column based matrix
GGplot2 plots combined into a matrix based on dataset columns}
\details{dataset refers to the object name of the data
xlist,ylist are each lists of desired x/y columns in "string" format
colour refers to a column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter
ggdetails are ggplot2 layer options to be included in the creation of all plots
title is a string variable containing a desired title of the resulting matrix plot
legend describes weather or not to generate a legend for the matrix plot
margins refer to the space between the plots}
\keyword{hplot}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}, George Ostrouchov \email{ostrouchovg@ornl.gov}}
\value{ggcolpair object, will print if called}
\arguments{
\item{dataset}{data set to be used}
\item{xlist}{list of desired x columns in "string" format}
\item{ylist}{list of desired y columns in "string" format}
\item{colour}{column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter}
\item{ggdetails}{ggplot2 options to be included in the creation of all plots}
\item{margins}{space between the plots}
\item{title}{string of desired title for resulting matrix, default is none}
\item{legend}{string representing legend visibility, default is off}
}
\examples{
# example of use
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
pxlist <- c("x","y","z")
pylist <- c("carat","price","depth")
ggcolpairs(dsmall,pxlist,pylist,colour="cut")
}
