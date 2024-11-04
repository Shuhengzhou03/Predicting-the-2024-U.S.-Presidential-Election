#### Preamble ####
# Purpose: Tests the structure and validity of the simulated U.S. polling dataset.
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-10-31
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded.
# - 00-simulate_data.R must have been run.
# Any other information needed? Make sure you are in the `starter_folder` R project.


#### Workspace setup ####
library(tidyverse)

analysis_data <- read_csv("data/00-simulated_data/us_simulated_polling_data.parquet")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 200 rows
if (nrow(analysis_data) == 200) {
  message("Test Passed: The dataset has 200 rows.")
} else {
  stop("Test Failed: The dataset does not have 200 rows.")
}

# Check if the dataset has 6 columns
if (ncol(analysis_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}

# Check if the 'state' column contains only valid U.S. state names
valid_states <- c(
  "California", "Texas", "Florida", "New York", "Pennsylvania", "Illinois", "Ohio",
  "Georgia", "North Carolina", "Michigan", "Arizona", "Wisconsin", "Nevada", "Minnesota",
  "Colorado", "Virginia", "Missouri", "Tennessee", "Indiana", "Massachusetts"
)

if (all(analysis_data$state %in% valid_states)) {
  message("Test Passed: The 'state' column contains only valid U.S. state names.")
} else {
  stop("Test Failed: The 'state' column contains invalid state names.")
}

# Check if the 'pollster' column contains only valid pollster names
valid_pollsters <- c("YouGov", "AtlasIntel", "Ipsos", "RMG Research", "Emerson College")

if (all(analysis_data$pollster %in% valid_pollsters)) {
  message("Test Passed: The 'pollster' column contains only valid pollster names.")
} else {
  stop("Test Failed: The 'pollster' column contains invalid pollster names.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'numeric_grade' and 'transparency_score' are within expected ranges
if (all(analysis_data$numeric_grade %in% c(1.0, 2.0, 2.5, 3.0, 3.5))) {
  message("Test Passed: 'numeric_grade' values are within the expected range.")
} else {
  stop("Test Failed: 'numeric_grade' contains values outside the expected range.")
}

if (all(analysis_data$transparency_score %in% c(5, 6, 7, 8, 9, 10))) {
  message("Test Passed: 'transparency_score' values are within the expected range.")
} else {
  stop("Test Failed: 'transparency_score' contains values outside the expected range.")
}

# Check if 'pct' is between 0 and 60
if (all(analysis_data$pct >= 0 & analysis_data$pct <= 60)) {
  message("Test Passed: 'pct' values are within the expected range (0-60).")
} else {
  stop("Test Failed: 'pct' contains values outside the expected range (0-60).")
}

# Check if  'candidate_name' contains only valid candidate names
if (all(analysis_data$candidate_name %in% c("Kamala Harris", "Donald Trump"))) {
  message("Test Passed: 'candidate_name' contains valid candidate names.")
} else {
  stop("Test Failed: 'candidate_name' contains invalid names.")
}

