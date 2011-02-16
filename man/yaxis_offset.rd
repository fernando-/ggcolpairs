\name{yaxis_offset}
\alias{yaxis_offset}
\title{yaxis_offset}
\usage{yaxis_offset(p)}
\description{Calculates the offset margin space needed for the y axis of a plot based on axis text character length}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{p}{ggplot2 object to be analyzed}
}
\examples{\dontrun{
# example of use
p <- ggplot(cars, aes(speed,dist)) + geom_point()
yaxis_offset(p)
}}
