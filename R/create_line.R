# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Time Trend - Line Chart for any metric
#'
#' @description
#' Provides a week by week view of a selected metric, visualised as line charts.
#' By default returns a line chart for the defined metric,
#' with a separate panel per value in the HR attribute.
#' Additional options available to return a summary table.
#'
#' @details
#' This is a general purpose function that powers all the functions
#' in the package that produce faceted line plots.
#'
#' @template spq-params
#' @param metric Character string containing the name of the metric,
#' e.g. "Collaboration_hours"
#'
#' @param ncol Numeric value setting the number of columns on the plot. Defaults
#'   to `NULL` (automatic).
#'
#' @param label Logical value to determine whether to show data point labels on
#'   the plot. If `TRUE`, both `geom_point()` and `geom_text()` are added to
#'   display data labels rounded to 1 decimal place above each data point.
#'   Defaults to `FALSE`.
#'
#' @param return String specifying what to return. This must be one of the
#'   following strings:
#'   - `"plot"`
#'   - `"table"`
#'
#' See `Value` for more information.
#'
#' @import dplyr
#' @import ggplot2
#' @import reshape2
#' @import scales
#' @importFrom tidyselect all_of
#'
#' @family Visualization
#' @family Flexible
#' @family Time-series
#'
#' @examples
#' # Return plot of Email Hours
#' pq_data %>% create_line(metric = "Email_hours", return = "plot")
#'
#' # Return plot of Collaboration Hours
#' pq_data %>% create_line(metric = "Collaboration_hours", return = "plot")
#'
#' # Return plot but coerce plot to two columns
#' pq_data %>%
#'   create_line(
#'     metric = "Collaboration_hours",
#'     hrvar = "Organization",
#'     ncol = 2
#'     )
#'
#' # Return plot of email hours and cut by `LevelDesignation`
#' pq_data %>% create_line(metric = "Email_hours", hrvar = "LevelDesignation")
#'
#' # Return plot with data point labels
#' pq_data %>% create_line(metric = "Email_hours", label = TRUE)
#'
#' @return
#' A different output is returned depending on the value passed to the `return` argument:
#'   - `"plot"`: 'ggplot' object. A faceted line plot for the metric.
#'   - `"table"`: data frame. A summary table for the metric.
#'
#' @export
create_line <- function(data,
                        metric,
                        hrvar = "Organization",
                        mingroup = 5,
                        ncol = NULL,
                        label = FALSE,
                        return = "plot"){

  ## Check inputs
  required_variables <- c("MetricDate",
                          metric,
                          "PersonId")

  ## Error message if variables are not present
  ## Nothing happens if all present
  data %>%
    check_inputs(requirements = required_variables)

  ## Clean metric name
  clean_nm <- us_to_space(metric)
  
  ## Handling NULL values passed to hrvar
  if(is.null(hrvar)){
    data <- totals_col(data)
    hrvar <- "Total"
    subtitle_nm <- paste("Total",
                         tolower(clean_nm),"over time")
    } else{
    subtitle_nm <- paste("Total",
                         tolower(clean_nm),
                         "by",
                         tolower(camel_clean(hrvar)))
    }

  myTable <-
    data %>%
    mutate(MetricDate = as.Date(MetricDate, "%m/%d/%Y")) %>%
    rename(group = !!sym(hrvar)) %>% # Rename HRvar to `group`
    select(PersonId, MetricDate, group, all_of(metric)) %>%
    group_by(group) %>%
    mutate(Employee_Count = n_distinct(PersonId)) %>%
    dplyr::filter(Employee_Count >= mingroup)  # Keep only groups above privacy threshold

  myTable <-
    myTable %>%
    group_by(MetricDate, group) %>%
    summarize(Employee_Count = mean(Employee_Count),
              !!sym(metric) := mean(!!sym(metric)),.groups = "drop")

  ## Data frame to return
  myTable_return <-
    myTable %>%
    select(MetricDate, group, all_of(metric)) %>%
    spread(MetricDate, !!sym(metric))

  ## Data frame for creating plot
  myTable_plot <-
    myTable %>%
    select(MetricDate, group, all_of(metric)) %>%
    group_by(MetricDate, group) %>%
    summarise(across(all_of(metric), ~mean(., na.rm = TRUE))) %>%
    ungroup()


  return_plot <- function(){

    plot_base <- myTable_plot %>%
      ggplot(aes(x = MetricDate, y = !!sym(metric))) +
      geom_line(colour = "#1d627e") +
      facet_wrap(.~group, ncol = ncol) +
      scale_fill_gradient(name="Hours", low = "white", high = "red") +
      theme_wpa_basic() +
      theme(strip.background = element_rect(color = "#1d627e",
                                            fill = "#1d627e"),
            strip.text = element_text(size = 10,
                                      colour = "#FFFFFF",
                                      face = "bold")) +
      labs(title = clean_nm,
           subtitle = subtitle_nm,
           x = "Metric Date",
           y = clean_nm,
           caption = extract_date_range(data, return = "text")) +
      ylim(0, NA) # Set origin to zero
    
    # Conditionally add points and labels if label = TRUE
    if(label == TRUE){
      plot_base <- plot_base +
        geom_point(colour = "#1d627e", size = 2) +
        geom_text(aes(label = round(!!sym(metric), 1)), 
                  vjust = -0.5, hjust = 0.5, size = 3, colour = "black")
    }
    
    plot_base

  }


  if(return == "table"){

    myTable_return

  } else if(return == "plot"){

    return_plot()

  } else {

    stop("Please enter a valid input for `return`.")

  }

}
