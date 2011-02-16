\name{generate_ggplot}
\alias{generate_ggplot}
\title{generate_ggplot}
\usage{generate_ggplot(dataset,xvar,yvar,cpcolour,ggdetails,cmargins)}
\description{Generates ggplot based on parameter data}
\details{The ggplot object returned contains no legend, labels, ticks, or axis text so that all of the plots in the matrix are the same size.}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{hplot}
\arguments{
\item{dataset}{data set to be used}
\item{xvar}{string column name of desired x axis}
\item{yvar}{string column name of desired y axis}
\item{cpcolour}{string column name to color the data, default is none}
\item{ggdetails}{ggplot2 options to be included in the creation of the plot, default is geom_point}
\item{cmargins}{margin space surrounding the plot}
}
\examples{\dontrun{
# example of use
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
xvar <- "carat"
yvar <- "price"
clean_plot <- generate_ggplot(dsmall, xvar, yvar, cpcolour = "cut", cmargins=c(0.1,-0.4))
}}
