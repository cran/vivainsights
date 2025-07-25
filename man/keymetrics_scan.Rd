% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/keymetrics_scan.R
\name{keymetrics_scan}
\alias{keymetrics_scan}
\title{Run a summary of Key Metrics from the Standard Person Query data}
\usage{
keymetrics_scan(
  data,
  hrvar = "Organization",
  mingroup = 5,
  metrics = c("Collaboration_span", "Collaboration_hours",
    "After_hours_collaboration_hours", "Meetings", "Meeting_hours",
    "After_hours_meeting_hours", "Meeting_and_call_hours_with_manager_1_1",
    "Meeting_and_call_hours_with_manager", "Emails_sent", "Email_hours",
    "After_hours_email_hours", "Internal_network_size", "External_network_size"),
  return = "plot",
  low = rgb2hex(7, 111, 161),
  mid = rgb2hex(241, 204, 158),
  high = rgb2hex(216, 24, 42),
  textsize = 2
)
}
\arguments{
\item{data}{A Standard Person Query dataset in the form of a data frame.}

\item{hrvar}{String containing the name of the HR Variable by which to split
metrics. Defaults to \code{"Organization"}. To run the analysis on the total
instead of splitting by an HR attribute, supply \code{NULL} (without quotes).}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{metrics}{A character vector containing the variable names to calculate
averages of.}

\item{return}{Character vector specifying what to return, defaults to "plot".
Valid inputs are "plot" and "table".}

\item{low}{String specifying colour code to use for low-value metrics.
Arguments are passed directly to \code{ggplot2::scale_fill_gradient2()}.}

\item{mid}{String specifying colour code to use for mid-value metrics.
Arguments are passed directly to \code{ggplot2::scale_fill_gradient2()}.}

\item{high}{String specifying colour code to use for high-value metrics.
Arguments are passed directly to \code{ggplot2::scale_fill_gradient2()}.}

\item{textsize}{A numeric value specifying the text size to show in the plot.}
}
\value{
Returns a ggplot object by default, when \code{'plot'} is passed in \code{return}.
When \code{'table'} is passed, a summary table is returned as a data frame.
}
\description{
Returns a heatmapped table by default, with options to return a table.
}
\examples{
\dontrun{
# Heatmap plot is returned by default
keymetrics_scan(pq_data)

# Heatmap plot with custom colours
keymetrics_scan(pq_data, low = "purple", high = "yellow")

# Return summary table
keymetrics_scan(pq_data, hrvar = "LevelDesignation", return = "table")
}

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
}
\concept{Visualization}
