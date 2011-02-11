\name{ggcolpairs}
\alias{ggcolpairs}
\title{ggcolpairs - GGplot2 plots combined into a matrix based on dataset columns ...}
\usage{ggcolpairs(dataset, xlist, ylist, colour="default", 
	ggdetails="default", margins="default")}
\description{ggcolpairs - GGplot2 column based matrix
GGplot2 plots combined into a matrix based on dataset columns}
\details{dataset refers to the object name of the data
xlist,ylist are each lists of desired x/y columns in "string" format
colour refers to a column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter
ggdetails are ggplot2 options to be included in the creation of all plots
margins refer to the space between the plots}
\keyword{cplot}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}, George Ostrouchov \email{ostrouchovg@ornl.gov}}
\value{ggcolpair object that if called, will print -- to be implemented}
\arguments{\item{dataset}{data set to be used}
\item{xlist}{list of desired x columns in "string" format}
\item{ylist}{list of desired y columns in "string" format}
\item{colour}{column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter}
\item{ggdetails}{ggplot2 options to be included in the creation of all plots}
\item{margins}{space between the plots}}
\examples{# example of use
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
pxlist <- c("x","y","z")
pylist <- c("carat","price","depth")
ggcolpairs(dsmall,pxlist,pylist,colour="cut")}
