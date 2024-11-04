#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned U.S. polling dataset.
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-11-04
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse` and `testthat` packages must be installed and loaded.
# - 02-clean_data.R must have been run to produce the cleaned data.
# Any other information needed? Make sure you are in the `starter_folder` R project.


# Load necessary packages
library(arrow)
library(tidyverse)

# Read the data
analysis_data <- read_parquet("data/02-analysis_data/us_polling_cleaned_data.parquet")

# Define a simple check function to display pass or fail messages
check <- function(condition, success_msg, fail_msg) {
  if (condition) {
    message(success_msg)
  } else {
    stop(fail_msg)
  }
}

#### Manual Tests ####

# Test that the dataset has at least 100 rows
check(
  nrow(analysis_data) >= 100,
  "Pass: Dataset has at least 100 rows",
  "Fail: Dataset has fewer than 100 rows"
)

# Test that the dataset has 6 columns
check(
  ncol(analysis_data) == 6,
  "Pass: Dataset has 6 columns",
  "Fail: Dataset does not have 6 columns"
)

# Test that the 'state' column is character type
check(
  is.character(analysis_data$state),
  "Pass: 'state' column is of character type",
  "Fail: 'state' column is not of character type"
)

# Test that the 'pollster' column is character type
check(
  is.character(analysis_data$pollster),
  "Pass: 'pollster' column is of character type",
  "Fail: 'pollster' column is not of character type"
)

# Test that there are no missing values in the dataset
check(
  all(!is.na(analysis_data)),
  "Pass: No missing values in dataset",
  "Fail: Dataset contains missing values"
)

# Test that 'candidate_name' column only contains valid candidate names
valid_candidates <- c("Kamala Harris", "Donald Trump")
check(
  all(analysis_data$candidate_name %in% valid_candidates),
  "Pass: 'candidate_name' column contains only valid candidate names",
  "Fail: 'candidate_name' column contains invalid candidate names"
)

# Test that 'pct' values are between 0 and 100
check(
  all(analysis_data$pct >= 0 & analysis_data$pct <= 100),
  "Pass: 'pct' values are between 0 and 100",
  "Fail: 'pct' column contains values outside 0 to 100 range"
)

# Test that 'numeric_grade' values are >= 2.0
check(
  min(analysis_data$numeric_grade, na.rm = TRUE) >= 2.0,
  "Pass: 'numeric_grade' values are >= 2.0",
  "Fail: 'numeric_grade' contains values less than 2.0"
)

# Test that 'transparency_score' values are >= 5
check(
  min(analysis_data$transparency_score, na.rm = TRUE) >= 5,
  "Pass: 'transparency_score' values are >= 5",
  "Fail: 'transparency_score' contains values less than 5"
)


