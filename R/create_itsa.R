# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

#' @title
#' Estimate an effect of intervention on every Viva Insights metric in input
#' file by applying single-group Interrupted Time-Series Analysis (ITSA)
#'
#' @author Aleksey Ashikhmin <alashi@@microsoft.com>
#'
#' @description
#' r lifecycle::badge('experimental')
#'
#' This function implements ITSA method described in the paper 'Conducting
#' interrupted time-series analysis for single- and multiple-group comparisons',
#' Ariel Linden, The Stata Journal (2015), 15, Number 2, pp. 480-500
#'
#' This function further requires the installation of 'sandwich' and 'lmtest' in
#' order to work. These packages can be installed from CRAN using
#' `install.packages()`.
#'
#' @details
#' This function uses the additional package dependencies 'sandwich' and
#' 'lmtest'. Please install these separately from CRAN prior to running the
#' function.
#'
#' As of May 2022, the 'portes' package was archived from CRAN. The dependency
#' has since been removed and dependent functions `Ljungbox()` incorporated into
#' the **wpa** package.
#'
#' @param data Person Query as a dataframe including date column named
#'   `MetricDate`. This function assumes the data format is `%Y-%m-%d` as is
#'   standard in a Viva Insights query output.
#' @param metrics A character vector containing the variable names to perform
#'   the interrupted time series analysis for.
#' @param before_start String specifying the start date of the 'before'
#'   time period in `%Y-%m-%d` format. The 'before' time period refers to the
#'   period before the intervention (e.g. training program, re-org, shift to
#'   remote work) occurs and bounded by `before_start` and `before_end`
#'   parameters. Longer period increases likelihood of achieving more
#'   statistically significant results. Defaults to earliest date in dataset. If
#'   not provided, this defaults to the earliest date in the dataset.
#' @param before_end String specifying the end date of 'before' time
#'   period in `%Y-%m-%d` format. If `NULL`, an error will be raised, as this
#'   value is required.
#' @param after_start String specifying the start date of the 'after'
#'   time period in `%Y-%m-%d` format. If `NULL`, this will default to the value
#'   of `before_end`. The 'after' time period refers to the period after the
#'   intervention occurs and is bounded by `after_start` and `after_end`
#'   parameters. Longer periods increase the likelihood of achieving more
#'   statistically significant results.
#' @param after_end String specifying the end date of the 'after' time
#'   period in `%Y-%m-%d` format. Defaults to the latest date in the dataset.
#' @param ac_lags_max Numeric value specifying the maximum lag for the autocorrelation test.
#'   The Ljung-Box test is used to check for autocorrelation in the model residuals
#'   up to this specified number of lags. Higher values check for longer-term
#'   dependencies in the time series data.
#' @param return String specifying what output to return. Defaults to "table".
#' Valid return options include:
#'   - `'plot'`: return a list of plots.
#'   - `'table'`: return data.frame with estimated models' coefficients and
#'   their corresponding p-values You should look for significant p-values in
#'   beta_2 to indicate an immediate treatment effect, and/or in beta_3 to
#'   indicate a treatment effect over time
#'
#' @import dplyr
#' @import ggplot2
#'
#' @family Flexible Input
#' @family Interrupted Time-Series Analysis
#'
#'
#' @examples
#' \dontrun{
#' # Returns summary table
#' create_itsa(
#'   data = pq_data,
#'   metrics = c("Collaboration_span", "Internal_network_size"),
#'   before_end = "2024-07-01",
#'   after_start = "2024-07-01",
#'   ac_lags_max = 7,
#'   return = "table"
#' )
#'
#' # Returns list of plots
#' plot_list <-
#'   create_itsa(
#'     data = pq_data,
#'     metrics = c("Collaboration_span", "Internal_network_size"),
#'     before_end = "2024-07-01",
#'     after_start = "2024-07-01",
#'     ac_lags_max = 7,
#'     return = "plot"
#'   )
#'
#' # Extract a plot as an example
#' plot_list$Collaboration_span
#' }
#'
#' @return 
#' When 'data' is passed to `return`, a data frame with the following columns:
#' - `metric_name`: Name of the metric being analyzed.
#' - `beta_2`: Coefficient for the immediate treatment effect.
#' - `beta_3`: Coefficient for the treatment effect over time.
#' - `beta_2_pvalue`: P-value for the immediate treatment effect.
#' - `beta_3_pvalue`: P-value for the treatment effect over time.
#' - `AR_flag`: Logical flag indicating whether autocorrelation was detected.
#' - `error_warning`: Error or warning message if applicable.
#' 
#' @export

create_itsa <- function(
    data,
    metrics = NULL,
    before_start = NULL,
    before_end = NULL,
    after_start = NULL,
    after_end = NULL,
    ac_lags_max = 7,
    return = 'table'
    ) {
  
  ## Check inputs types
  stopifnot(is.data.frame(data))  # Ensure 'data' is a data frame
  stopifnot(is.character(metrics) | is.null(metrics))  # 'metrics' can be a character vector or NULL
  stopifnot(is.character(before_start) | inherits(before_start, "Date") | is.null(before_start))  # 'before_start' can be a string, or Date, or NULL
  stopifnot(is.character(before_end) | inherits(before_end, "Date") | is.null(before_end))  # 'before_end' must be a string, Date, or NULL
  stopifnot(is.character(after_start) | inherits(after_start, "Date") | is.null(after_start))  # 'after_start' can be a string, Date, or NULL
  stopifnot(is.character(after_end) | inherits(after_end, "Date") | is.null(after_end))  # 'after_end' can be a string, Date, or NULL
  stopifnot(is.numeric(ac_lags_max))  # 'ac_lags_max' must be numeric
  stopifnot(is.character(return))  # 'return' must be a string

  # Set variables for min and max dates in `data`
  min_date <- min(data$MetricDate, na.rm = TRUE)
  max_date <- max(data$MetricDate, na.rm = TRUE)

  # If `before_start` is not provided, set it to the earliest date in the dataset
  if (is.null(before_start)) {
    before_start <- min_date
  }

  # Raise an error if `before_end` is NULL
  if (is.null(before_end)) {
    stop("The 'before_end' parameter must be provided.")
  }

  # If `after_start` is NULL, set it to the value of `before_end`
  if (is.null(after_start)) {
    after_start <- before_end
  }

  # If `after_end` is not provided, set it to the latest date in the dataset
  if (is.null(after_end)) {
    after_end <- max_date
  }
  
  # Check if dependencies are installed
  check_pkg_installed(pkgname = "sandwich")
  check_pkg_installed(pkgname = "lmtest")
  
  ## Check required columns in data
  required_variables <- c("MetricDate", "PersonId", metrics)
  
  ## Error message if variables are not present
  ## Nothing happens if all present
  check_inputs(data, requirements = required_variables)
  
  # Debugging: Print the provided date strings before parsing
  # message("Provided date strings:")
  # message(paste("  before_start:", before_start))
  # message(paste("  before_end:", before_end))
  # message(paste("  after_start:", after_start))
  # message(paste("  after_end:", after_end))
  
  # Parse the date strings
  before_start <- as.Date(before_start, "%Y-%m-%d")
  before_end <- as.Date(before_end, "%Y-%m-%d")
  after_start <- as.Date(after_start, "%Y-%m-%d")
  after_end <- as.Date(after_end, "%Y-%m-%d")
  
  # Debugging: Print the parsed dates
  message("Parsed dates:")
  message(paste("  before_start:", before_start))
  message(paste("  before_end:", before_end))
  message(paste("  after_start:", after_start))
  message(paste("  after_end:", after_end))
  
  # Check for missing dates
  if (any(is.na(c(before_start, before_end, after_start, after_end)))) {
    stop("One or more dates are missing.")
  }
  
  dateranges <- c(before_start, before_end, after_start, after_end)
  
  prepped_dataset <- 
    data %>%
    mutate(MetricDate = as.Date(MetricDate, "%Y-%m-%d")) %>%
    select(all_of(required_variables))
  
  # Check for dates in data file
  if (!all(dateranges >= min_date & dateranges <= max_date)){
    stop("Not all dates are found in the dataset")
  }
  
  # Create variable => Period
  prepped_dataset_table <-
    prepped_dataset %>%
    mutate(
      Period = case_when(
        (before_start <= MetricDate) & (MetricDate <= before_end) ~ "Before",
        (after_start <= MetricDate) & (MetricDate <= after_end) ~ "After"
      )
    ) %>%
    filter(Period %in% c("Before", "After")) %>%
    mutate(outcome = case_when(Period == "Before" ~ 0, Period == "After" ~ 1))
  
  # Create "train" data with metrics and Date columns
  date_column <- prepped_dataset_table[["MetricDate"]]
  
  train <- 
    prepped_dataset_table %>%
    select(where(is.numeric), MetricDate) %>%
    drop_na()
  
  # Aggregate metric values at Date level
  grouped_by_Date_train <- train %>% group_by(MetricDate)
  
  # Get metric names - exclude MetricDate and outcome columns
  metric_names <- setdiff(colnames(grouped_by_Date_train), c("MetricDate", "outcome"))
  
  # Create empty data.frame to save results (e.g. coefficients, p-values etc) for each metric
  results <- data.frame(
    metric_name = character(),
    beta_2 = double(),
    beta_3 = double(),
    beta_2_pvalue = double(),
    beta_3_pvalue = double(),
    AR_flag = logical(),
    error_warning = character()
  )
  
  # Create empty list to save plots
  results_plot <- list()
  
  # Perform ITSA for every metric in metric_names
  for (metric_name in metric_names) {
    
    # if error_flag = True then there would be no plot generated when return = 'plot'
    error_flag <- FALSE
    # AR_flag = False indicates that lag is equal 0 otherwise it's set to True
    AR_flag <- FALSE
    # lm_train_success_flag indicates model estimation success
    lm_train_success_flag <- FALSE
    
    buf_trycatch <- tryCatch({
      
      # Create a metric time-series by averaging metric values across users
      metric_data <- grouped_by_Date_train %>%
        summarise(
          across(
            c(metric_name, "outcome"), mean, na.rm = TRUE
            )
          )
      
      # Transform metric_data into ITSA format described in the paper page 485
      # X is dummy variable, 0 indicates pre-intervention period and 1 indicates post-intervention period
      X <- metric_data[["outcome"]]
      num_Zeros <- length(X) - sum(X) + 1
      
      data_OLS <- tibble(
        "MetricDate" = metric_data[["MetricDate"]],
        "Y" = metric_data[[metric_name]],
        "T" = seq(1:length(metric_data[["MetricDate"]])),
        "X" = metric_data[["outcome"]],
        "XT" = X * (T - num_Zeros)
        )
      
      single_itsa = stats::lm(Y ~ T + X + XT, data = data_OLS)
      
      # Newey-West variance estimator produces consistent estimates when there
      # is autocorrelation in addition to possible Heteroscedasticity
      coeff_pvalues <- lmtest::coeftest(
        single_itsa,
        vcov = sandwich::NeweyWest(single_itsa, lag = 0, prewhite = FALSE)
        )
      
      beta_2 <- round(single_itsa$coefficients[3], 3)
      beta_3 <- round(single_itsa$coefficients[4], 3)
      beta_2_pvalue <- round(coeff_pvalues[3, 4], 3)
      beta_3_pvalue <- round(coeff_pvalues[4, 4], 3)
      
      lm_train_success_flag <- TRUE
      
      # It is important to test for the presence of autocorrelated errors
      # when using regression-based time-series methods, because such tests
      # provide critical diagnostic information regarding the adequacy of the time-series model
      residuals <- single_itsa$residuals
      N <- length(residuals)
      
      # Run Ljung and Box Test to test for autocorrelation
      lb_test <- wpa::LjungBox(
        single_itsa,
        lags = seq(1, ac_lags_max),
        order = 4,
        season = 1,
        squared.residuals = FALSE
      )
      
      ind_stat_significant_coeff <- which(lb_test[, 'p-value'] <= 0.05)
      
      # LjungBox test identifies statistically significant lags then we use Newey-West method
      # (heteroscedasticity and autocorrelation consistent (HAC) covariance matrix estimators)
      # with maximum lag to estimate lm model coefficients' std errors and p-values with lags accounting
      if (0 < length(ind_stat_significant_coeff)) {
        # The Newey & West (1987) estimator requires specification
        # of the lag and suppression of prewhitening
        coeff_pvalues <- lmtest::coeftest(
          single_itsa,
          vcov = sandwich::NeweyWest(
            single_itsa,
            lag = max(ind_stat_significant_coeff),
            prewhite = FALSE
            )
          )
        
        AR_flag <- TRUE
      }
      
      # Look for significant p-values in beta_2 to indicate an immediate treatment
      # effect, or in beta_3 to indicate a treatment effect over time
      # Yt = Beta0 + beta_1*Tt + beta_2*Xt + beta_3*Xt*Tt + epst
      beta_2 <- round(single_itsa$coefficients[3], 3)
      beta_3 <- round(single_itsa$coefficients[4], 3)
      beta_2_pvalue <- round(coeff_pvalues[3, 4], 3)
      beta_3_pvalue <- round(coeff_pvalues[4, 4], 3)
      
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = beta_2,
        beta_3 = beta_3,
        beta_2_pvalue = beta_2_pvalue,
        beta_3_pvalue = beta_3_pvalue,
        AR_flag = AR_flag,
        error_warning = ""
        )
    },
    error = function(c) {
      error_flag <- TRUE
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = ifelse(exists("beta_2", inherits = FALSE), beta_2, -1),
        beta_3 = ifelse(exists("beta_3", inherits = FALSE), beta_3, -1),
        beta_2_pvalue = ifelse(exists("beta_2_pvalue", inherits = FALSE), beta_2_pvalue, -1),
        beta_3_pvalue = ifelse(exists("beta_3_pvalue", inherits = FALSE), beta_3_pvalue, -1),
        AR_flag = FALSE,
        error_warning = paste0('Error: ', c$message, "; lm_train_success=", lm_train_success_flag, collapse = " ")
        )
    },
    warning = function(c) {
      buf <- dplyr::tibble(
        metric_name = metric_name,
        beta_2 = ifelse(exists("beta_2", inherits = FALSE), beta_2, -1),
        beta_3 = ifelse(exists("beta_3", inherits = FALSE), beta_3, -1),
        beta_2_pvalue = ifelse(exists("beta_2_pvalue", inherits = FALSE), beta_2_pvalue, -1),
        beta_3_pvalue = ifelse(exists("beta_3_pvalue", inherits = FALSE), beta_3_pvalue, -1),
        AR_flag = AR_flag,
        error_warning = paste0('Warning: ', c$message, "; lm_train_success=", lm_train_success_flag, collapse = " ")
        )
    }
    )
    
    results <- rbind(results, buf_trycatch)
    
    # Create a metric plot with its estimated ITSA model
    # and save it in "results_plot" list. If error_flag is TRUE then
    #save "buf_trycatch" instead for logging error message
    if (return == 'plot' & !error_flag) {
      
      event_T <- which.max(data_OLS[, "X"] == 1)
      hat_Y <- single_itsa$fitted.values
      
      before_intervention_df <- data_OLS[1:event_T,]
      before_intervention_df[event_T, "X"] <- 0
      
      hat_Y_before_and_at_intervention <- data.frame(
        DateTime = data_OLS[1:event_T, "MetricDate"],
        T = data_OLS[1:event_T, "T"],
        Y = stats::predict(single_itsa, before_intervention_df)
      )
      
      hat_Y_after_and_at_intervention <- data.frame(
        DateTime = data_OLS[event_T:dim(data_OLS)[1], "MetricDate"],
        T = data_OLS[event_T:dim(data_OLS)[1], "T"],
        Y = hat_Y[event_T:dim(data_OLS)[1]]
        )
      
      # Create basic graph
      p <- ggplot(data_OLS, aes(x = T, y = Y)) +
        geom_point(aes(y = Y), color = "blue") +
        geom_line(data = hat_Y_before_and_at_intervention, aes(x = T, y = Y), size = 1) +
        geom_line(data = hat_Y_after_and_at_intervention, aes(x = T, y = Y), size = 1)
      
      # Calculate plotting area range and scale
      dY <- (max(data_OLS[, "Y"]) - min(data_OLS[, "Y"])) / 10
      dX <- 1
      
      # Calculate annotation positions on the graph
      Y_at_intervention_when_no_intervention_happened <- hat_Y_before_and_at_intervention[dim(hat_Y_before_and_at_intervention)[1], "Y"]
      Y_at_intervention_when_intervention_happened <- hat_Y_after_and_at_intervention[1, "Y"]
      pos_y_end_beta_2 <- (Y_at_intervention_when_no_intervention_happened + Y_at_intervention_when_intervention_happened) / 2
      pos_y_start_beta_2 <- pos_y_end_beta_2 + dY
      pos_x_end_beta_2 <- event_T
      pos_x_start_beta_2 <- pos_x_end_beta_2 - dX
      
      # Create data.frame with all the annotation info
      annotation <- data.frame(
        x = pos_x_start_beta_2 - dX,
        y = Y_at_intervention_when_intervention_happened + dY,
        label = c(paste0("beta_2=", round(beta_2, 3), collapse = " "))
      )
      
      # Create final plot
      p_final <- p +
        labs(
          title = metric_name,
          subtitle = "Interrupted time-series analysis"
        ) +
        geom_vline(xintercept = event_T,
                   color = "red",
                   size = 1) +
        annotate(
          "segment",
          x = pos_x_start_beta_2,
          xend = pos_x_end_beta_2,
          y = pos_y_start_beta_2,
          yend = pos_y_end_beta_2,
          colour = "black",
          size = 0.5,
          alpha = 0.6,
          arrow = arrow()
        ) +
        annotate(
          "segment",
          x = pos_x_end_beta_2,
          xend = pos_x_end_beta_2,
          y = Y_at_intervention_when_no_intervention_happened,
          yend = Y_at_intervention_when_intervention_happened,
          colour = "purple",
          size = 2,
          alpha = 1
        ) +
        geom_text(
          data = annotation,
          aes(x = x, y = y, label = label),
          color = "orange",
          size = 5,
          angle = 0,
          fontface = "bold"
        ) +
        theme_wpa_basic()
      
      # Save plot in list
      results_plot[[metric_name]] <- p_final
    } else {
      results_plot[[metric_name]] <- buf_trycatch
    }
    
  }
  
  if (return == 'plot') {
    return(results_plot)
  }
  
  # Return ranking table
  return(results)
  
}