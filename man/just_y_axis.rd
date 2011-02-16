\name{just_y_axis}
\alias{just_y_axis}
\title{just_y_axis}
\usage{just_y_axis(p, offset_h=0, cmargins)}
\description{Generates grob of a ggplot object which only contains a y axis}
\details{Uses theme_blank to remove most information from the ggplot object but leaves desired axis}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{hplot}
\arguments{
\item{p}{ggplot2 object to be striped}
\item{offset_h}{horizontal offset to move the axis in order to account for grid space}
\item{cmargins}{custom margin space surrounding the plot}
}
\examples{\dontrun{
# example of use
p <- ggplot(cars, aes(speed,dist)) + geom_point()
p.yaxis <- just_y_axis(p, offset_h=0, cmargins=c(0.1,-0.4))
}}
