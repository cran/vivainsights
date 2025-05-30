# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE.txt in the project root for license information.
# --------------------------------------------------------------------------------------------
library(testthat)
library(vivainsights)

test_that("create_period_scatter returns a data frame when return = 'table'", {

  result<-  create_period_scatter(pq_data,
                        hrvar = "LevelDesignation",
                        before_start = "2024-05-01",
                        before_end = "2024-05-31",
                        after_start = "2024-06-01",
                        after_end = "2024-07-03",
                        return = "table"
                        )

  # Check if the result is a data frame
  expect_s3_class(result, "data.frame")
})

test_that("create_period_scatter returns a ggplot when return = 'plot'", {

  result<-  create_period_scatter(pq_data,
                        hrvar = "LevelDesignation",
                        before_start = "2024-05-01",
                        before_end = "2024-05-31",
                        after_start = "2024-06-01",
                        after_end = "2024-07-03",
                        return = "plot"
                        )

  # Check if the result is a ggplot object
  expect_s3_class(result, "ggplot")
})