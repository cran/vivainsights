% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_bubble.R
\name{create_bubble}
\alias{create_bubble}
\title{Create a bubble plot with two selected Viva Insights metrics (General
Purpose), with size representing the number of employees in the group.}
\usage{
create_bubble(
  data,
  metric_x,
  metric_y,
  hrvar = "Organization",
  mingroup = 5,
  return = "plot",
  bubble_size = c(1, 10)
)
}
\arguments{
\item{data}{A Standard Person Query dataset in the form of a data frame.}

\item{metric_x}{Character string containing the name of the metric, e.g.
"Collaboration_hours"}

\item{metric_y}{Character string containing the name of the metric, e.g.
"Collaboration_hours"}

\item{hrvar}{HR Variable by which to split metrics, defaults to
"Organization" but accepts any character vector, e.g. "LevelDesignation"}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{return}{String specifying what to return. This must be one of the
following strings: - \code{"plot"} - \code{"table"}}

\item{bubble_size}{A numeric vector of length two to specify the size range
of the bubbles}
}
\value{
A different output is returned depending on the value passed to the
\code{return} argument:
\itemize{
\item \code{"plot"}: 'ggplot' object. A bubble plot for the metric.
\item \code{"table"}: data frame. A summary table for the metric.
}
}
\description{
Returns a bubble plot of two selected metrics, using size to map
the number of employees.
}
\details{
This is a general purpose function that powers all the functions in
the package that produce bubble plots.
}
\examples{
create_bubble(pq_data, "Collaboration_hours", "Multitasking_hours", hrvar ="Organization")


}
\seealso{
Other Visualization: 
\code{\link{afterhours_dist}()},
\code{\link{afterhours_fizz}()},
\code{\link{afterhours_line}()},
\code{\link{afterhours_rank}()},
\code{\link{afterhours_summary}()},
\code{\link{afterhours_trend}()},
\code{\link{collaboration_area}()},
\code{\link{collaboration_dist}()},
\code{\link{collaboration_fizz}()},
\code{\link{collaboration_line}()},
\code{\link{collaboration_rank}()},
\code{\link{collaboration_sum}()},
\code{\link{collaboration_trend}()},
\code{\link{create_bar}()},
\code{\link{create_bar_asis}()},
\code{\link{create_boxplot}()},
\code{\link{create_dist}()},
\code{\link{create_fizz}()},
\code{\link{create_inc}()},
\code{\link{create_line}()},
\code{\link{create_line_asis}()},
\code{\link{create_period_scatter}()},
\code{\link{create_rank}()},
\code{\link{create_rogers}()},
\code{\link{create_sankey}()},
\code{\link{create_scatter}()},
\code{\link{create_stacked}()},
\code{\link{create_tracking}()},
\code{\link{create_trend}()},
\code{\link{email_dist}()},
\code{\link{email_fizz}()},
\code{\link{email_line}()},
\code{\link{email_rank}()},
\code{\link{email_summary}()},
\code{\link{email_trend}()},
\code{\link{external_dist}()},
\code{\link{external_fizz}()},
\code{\link{external_line}()},
\code{\link{external_rank}()},
\code{\link{external_sum}()},
\code{\link{hr_trend}()},
\code{\link{hrvar_count}()},
\code{\link{hrvar_trend}()},
\code{\link{keymetrics_scan}()},
\code{\link{meeting_dist}()},
\code{\link{meeting_fizz}()},
\code{\link{meeting_line}()},
\code{\link{meeting_rank}()},
\code{\link{meeting_summary}()},
\code{\link{meeting_trend}()},
\code{\link{one2one_dist}()},
\code{\link{one2one_fizz}()},
\code{\link{one2one_freq}()},
\code{\link{one2one_line}()},
\code{\link{one2one_rank}()},
\code{\link{one2one_sum}()},
\code{\link{one2one_trend}()}

Other Flexible: 
\code{\link{create_bar}()},
\code{\link{create_bar_asis}()},
\code{\link{create_boxplot}()},
\code{\link{create_density}()},
\code{\link{create_dist}()},
\code{\link{create_fizz}()},
\code{\link{create_hist}()},
\code{\link{create_inc}()},
\code{\link{create_line}()},
\code{\link{create_line_asis}()},
\code{\link{create_period_scatter}()},
\code{\link{create_rank}()},
\code{\link{create_sankey}()},
\code{\link{create_scatter}()},
\code{\link{create_stacked}()},
\code{\link{create_tracking}()},
\code{\link{create_trend}()}
}
\concept{Flexible}
\concept{Visualization}
