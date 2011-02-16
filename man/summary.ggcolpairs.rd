\name{summary.ggcolpairs}
\alias{summary.ggcolpairs}
\title{Summary of ggcolpairs object}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{misc}
\description{
Display information of a ggcolpairs object.
}
\usage{summary.ggcolpairs(object, ...)}
\arguments{
\item{object}{ggcolpairs object to summarise}
\item{...}{not used}
}
\examples{\dontrun{
# example of use
dsmall <- diamonds[sample(nrow(diamonds), 100), ] 
p.xlist <- c("x","y","z")
p.ylist <- c("carat","price","depth")
p <- ggcolpairs(dsmall,pxlist,pylist,colour="cut")
summary(p)
}}
