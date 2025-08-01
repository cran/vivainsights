% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_line.R
\name{create_line}
\alias{create_line}
\title{Time Trend - Line Chart for any metric}
\usage{
create_line(
  data,
  metric,
  hrvar = "Organization",
  mingroup = 5,
  ncol = NULL,
  label = FALSE,
  return = "plot"
)
}
\arguments{
\item{data}{A Standard Person Query dataset in the form of a data frame.}

\item{metric}{Character string containing the name of the metric,
e.g. "Collaboration_hours"}

\item{hrvar}{String containing the name of the HR Variable by which to split
metrics. Defaults to \code{"Organization"}. To run the analysis on the total
instead of splitting by an HR attribute, supply \code{NULL} (without quotes).}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{ncol}{Numeric value setting the number of columns on the plot. Defaults
to \code{NULL} (automatic).}

\item{label}{Logical value to determine whether to show data point labels on
the plot. If \code{TRUE}, both \code{geom_point()} and \code{geom_text()} are added to
display data labels rounded to 1 decimal place above each data point.
Defaults to \code{FALSE}.}

\item{return}{String specifying what to return. This must be one of the
following strings:
\itemize{
\item \code{"plot"}
\item \code{"table"}
}

See \code{Value} for more information.}
}
\value{
A different output is returned depending on the value passed to the \code{return} argument:
\itemize{
\item \code{"plot"}: 'ggplot' object. A faceted line plot for the metric.
\item \code{"table"}: data frame. A summary table for the metric.
}
}
\description{
Provides a week by week view of a selected metric, visualised as line charts.
By default returns a line chart for the defined metric,
with a separate panel per value in the HR attribute.
Additional options available to return a summary table.
}
\details{
This is a general purpose function that powers all the functions
in the package that produce faceted line plots.
}
\examples{
# Return plot of Email Hours
pq_data \%>\% create_line(metric = "Email_hours", return = "plot")

# Return plot of Collaboration Hours
pq_data \%>\% create_line(metric = "Collaboration_hours", return = "plot")

# Return plot but coerce plot to two columns
pq_data \%>\%
  create_line(
    metric = "Collaboration_hours",
    hrvar = "Organization",
    ncol = 2
    )

# Return plot of email hours and cut by `LevelDesignation`
pq_data \%>\% create_line(metric = "Email_hours", hrvar = "LevelDesignation")

# Return plot with data point labels
pq_data \%>\% create_line(metric = "Email_hours", label = TRUE)

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
\code{\link{create_bubble}()},
\code{\link{create_density}()},
\code{\link{create_dist}()},
\code{\link{create_fizz}()},
\code{\link{create_hist}()},
\code{\link{create_inc}()},
\code{\link{create_line_asis}()},
\code{\link{create_period_scatter}()},
\code{\link{create_rank}()},
\code{\link{create_sankey}()},
\code{\link{create_scatter}()},
\code{\link{create_stacked}()},
\code{\link{create_tracking}()},
\code{\link{create_trend}()}

Other Time-series: 
\code{\link{create_line_asis}()},
\code{\link{create_period_scatter}()},
\code{\link{create_trend}()}
}
\concept{Flexible}
\concept{Time-series}
\concept{Visualization}
