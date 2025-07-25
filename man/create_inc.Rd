% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_inc.R
\name{create_inc}
\alias{create_inc}
\alias{create_incidence}
\title{Create an incidence analysis reflecting proportion of population scoring above
or below a threshold for a metric}
\usage{
create_inc(
  data,
  metric,
  hrvar,
  mingroup = 5,
  threshold,
  position,
  return = "plot"
)

create_incidence(
  data,
  metric,
  hrvar,
  mingroup = 5,
  threshold,
  position,
  return = "plot"
)
}
\arguments{
\item{data}{A Standard Person Query dataset in the form of a data frame.}

\item{metric}{Character string containing the name of the metric,
e.g. "Collaboration_hours"}

\item{hrvar}{Character vector of at most length 2 containing the name of the
HR Variable by which to split metrics. Accepts \code{NULL}, where the total
population is used for the analysis.}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{threshold}{Numeric value specifying the threshold.}

\item{position}{String containing the below valid values:
\itemize{
\item \code{"above"}: show incidence of those equal to or above the threshold
\item \code{"below"}: show incidence of those equal to or below the threshold
}}

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
\item \code{"plot"}: 'ggplot' object. A heat map.
\item \code{"table"}: data frame. A summary table.
}
}
\description{
An incidence analysis is generated, with each value in the table reflecting
the proportion of the population that is above or below a threshold for a
specified metric. There is an option to only provide a single \code{hrvar} in
which a bar plot is generated, or two \code{hrvar} values where an incidence table
(heatmap) is generated.
}
\examples{
# Only a single HR attribute
create_inc(
  data = pq_data,
  metric = "After_hours_collaboration_hours",
  hrvar = "Organization",
  threshold = 4,
  position = "above"
)

# Total population (NULL hrvar)
create_inc(
  data = pq_data,
  metric = "Collaboration_hours",
  hrvar = NULL,
  threshold = 20,
  position = "below"
)

# Two HR attributes
create_inc(
  data = pq_data,
  metric = "Collaboration_hours",
  hrvar = c("LevelDesignation", "Organization"),
  threshold = 20,
  position = "below"
)

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
\code{\link{create_bubble}()},
\code{\link{create_density}()},
\code{\link{create_dist}()},
\code{\link{create_fizz}()},
\code{\link{create_hist}()},
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
