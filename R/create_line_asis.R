# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Create a line chart without aggregation for any metric
#'
#' @description
#' This function creates a line chart directly from the aggregated / summarised data.
#' Unlike `create_line()` which performs a person-level aggregation, there is no
#' calculation for `create_line_asis()` and the values are rendered as they are passed
#' into the function. The only requirement is that a `date_var` is provided for the x-axis.
#'
#' @param data Plotting data as a data frame.
#' @param date_var String containing name of variable for the horizontal axis.
#' @param metric String containing name of variable representing the line.
#' @param title Title of the plot.
#' @param subtitle Subtitle of the plot.
#' @param caption Caption of the plot.
#' @param ylab Y-axis label for the plot (group axis)
#' @param xlab X-axis label of the plot (bar axis).
#' @param line_colour String to specify colour to use for the line.
#' Hex codes are accepted. You can also supply
#' RGB values via `rgb2hex()`.
#' @param label Logical value to determine whether to show data point labels on
#'   the plot. If `TRUE`, both `geom_point()` and `geom_text()` are added to
#'   display data labels rounded to 1 decimal place above each data point.
#'   Defaults to `FALSE`.
#'
#' @import ggplot2
#' @import dplyr
#'
#' @family Visualization
#' @family Flexible
#' @family Time-series
#'
#' @return
#' Returns a 'ggplot' object representing a line plot.
#'
#' @examples
#' library(dplyr)
#'
#' # Median `Emails_sent` grouped by `MetricDate`
#' # Without Person Averaging
#' med_df <-
#'   pq_data %>%
#'   group_by(MetricDate) %>%
#'   summarise(Emails_sent_median = median(Emails_sent))
#'
#' med_df %>%
#'   create_line_asis(
#'     date_var = "MetricDate",
#'     metric = "Emails_sent_median",
#'     title = "Median Emails Sent",
#'     subtitle = "Person Averaging Not Applied",
#'     caption = extract_date_range(pq_data, return = "text")
#'   )
#'
#' # Create line plot with data point labels
#' med_df %>%
#'   create_line_asis(
#'     date_var = "MetricDate",
#'     metric = "Emails_sent_median",
#'     title = "Median Emails Sent",
#'     subtitle = "Person Averaging Not Applied",
#'     caption = extract_date_range(pq_data, return = "text"),
#'     label = TRUE
#'   )
#'
#' @export
create_line_asis <- function(data,
                            date_var = "MetricDate",
                            metric,
                            title = NULL,
                            subtitle = NULL,
                            caption = NULL,
                            ylab = date_var,
                            xlab = metric,
                            line_colour = rgb2hex(0, 120, 212),
                            label = FALSE){

  returnPlot <-
    data %>%
    mutate(across(all_of(date_var), ~as.Date(., format = "%m/%d/%Y"))) %>%
    ggplot(aes(x = !!sym(date_var), y = !!sym(metric))) +
    geom_line(colour = line_colour)

  # Conditionally add points and labels if label = TRUE
  if(label == TRUE){
    returnPlot <- returnPlot +
      geom_point(colour = line_colour, size = 2) +
      geom_text(aes(label = round(!!sym(metric), 1)), 
                vjust = -0.5, hjust = 0.5, size = 3, colour = "black")
  }

  returnPlot +
    labs(title = title,
         subtitle = subtitle,
         caption = caption,
         y = xlab,
         x = ylab) +
    theme_wpa_basic()
}
