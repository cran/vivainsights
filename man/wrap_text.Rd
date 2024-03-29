% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/supporting_functions.R
\name{wrap_text}
\alias{wrap_text}
\title{Wrap text based on character threshold}
\usage{
wrap_text(x, threshold = 15)
}
\arguments{
\item{x}{String to wrap text}

\item{threshold}{Numeric, defaults to 15. Number of character units by which
the next space would be replaced with \verb{\\n} to move text to next line.}
}
\value{
String output representing a processed version of \code{x}, with spaces replaced
by \verb{\\n.}
}
\description{
Wrap text in visualizations according to a preset character
threshold. The next space in the string is replaced with \verb{\\n}, which will
render as next line in plots and messages.
}
\examples{
wrapped <- wrap_text(
  "The total entropy of an isolated system can never decrease."
  )
message(wrapped)

}
