\name{cmp_setviewports}
\alias{cmp_setviewports}
\title{cmp_setviewports}
\usage{cmp_setviewports(xlist, ylist, title, legend, legendplot)}
\description{Configures the matrix plot and sets viewports and prepares them for printing axes and plots}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{xlist}{list of desired x columns in "string" format}
\item{ylist}{list of desired y columns in "string" format}
\item{title}{string of desired title for resulting matrix, default is none}
\item{legend}{string representing legend visibility, default is off}
\item{legendplot}{ggplot object for which to base the legend}
}
\examples{\dontrun{
# example without title or legend
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
xlist <- c("x","y","z")
ylist <- c("carat","price","depth")
cmp_setviewports(xlist, ylist, title)

# example with title and legend
title <- "x-y-z vs carat-price-depth"
lplot <- ggplot(dsmall, aes(x,carat, colour=cut)) + geom_point()
cmp_setviewports(xlist, ylist, title = title, legend = "on", legendplot = lplot)
}}
