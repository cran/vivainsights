# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title Manager 1:1 Time Trend
#'
#' @description
#' Provides a week by week view of scheduled manager 1:1 Time. By default
#' returns a week by week heatmap, highlighting the points in time with most
#' activity. Additional options available to return a summary table.
#'
#' @details
#' Uses the metric `Meeting_and_call_hours_with_manager_1_1`.
#'
#' @inheritParams create_trend
#' @inherit create_trend return
#'
#' @family Visualization
#' @family Managerial Relations
#'
#'
#' @examples
#' # Run plot
#' one2one_trend(pq_data)
#'
#' # Run table
#' one2one_trend(pq_data, hrvar = "LevelDesignation", return = "table")
#'
#' @export

one2one_trend <- function(data,
                          hrvar = "Organization",
                          mingroup = 5,
                          return = "plot"){

  create_trend(data,
               metric = "Meeting_and_call_hours_with_manager_1_1",
               hrvar = hrvar,
               mingroup = mingroup,
               return = return)

}





