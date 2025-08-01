% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meeting_fizz.R
\name{meeting_fizz}
\alias{meeting_fizz}
\title{Distribution of Meeting Hours (Fizzy Drink plot)}
\usage{
meeting_fizz(data, hrvar = "Organization", mingroup = 5, return = "plot")
}
\arguments{
\item{data}{A Standard Person Query dataset in the form of a data frame.}

\item{hrvar}{String containing the name of the HR Variable by which to split
metrics. Defaults to \code{"Organization"}. To run the analysis on the total
instead of splitting by an HR attribute, supply \code{NULL} (without quotes).}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{return}{String specifying what to return. This must be one of the following strings:
\itemize{
\item \code{"plot"}
\item \code{"table"}
}

See \code{Value} for more information.}
}
\value{
A different output is returned depending on the value passed to the \code{return} argument:
\itemize{
\item \code{"plot"}: 'ggplot' object. A jittered scatter plot for the metric.
\item \code{"table"}: data frame. A summary table for the metric.
}
}
\description{
Analyze weekly meeting hours distribution, and returns a 'fizzy' scatter plot
by default. Additional options available to return a table with distribution
elements.
}
\details{
Uses the metric \code{Meeting_hours}.
}
\examples{
# Return plot
meeting_fizz(pq_data, hrvar = "Organization", return = "plot")

# Return summary table
meeting_fizz(pq_data, hrvar = "Organization", return = "table")
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
\code{\link{create_bubble}()},
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

Other Meetings: 
\code{\link{meeting_dist}()},
\code{\link{meeting_line}()},
\code{\link{meeting_rank}()},
\code{\link{meeting_summary}()},
\code{\link{meeting_tm_report}()},
\code{\link{meeting_trend}()}
}
\concept{Meetings}
\concept{Visualization}
