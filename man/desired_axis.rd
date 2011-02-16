\name{desired_axis}
\alias{desired_axis}
\title{desired_axis}
\usage{desired_axis(xpos,ypos)}
\description{Returns which axis is desired to be generated based on matrix position}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{xpos}{x axis position in the matrix}
\item{ypos}{y axis position in the matrix}
}
\examples{\dontrun{
# example of use
# when xpos and ypos both equal 1, then both axis are needed so desired_axis returns xy
desired_axis(xpos=1,ypos=1)
}}
