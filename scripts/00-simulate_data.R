
#### Preamble ####
# Purpose: Simulates a dataset of U.S. polling data for the 2024 presidential election
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-11-04
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed.
# Any other information needed? Make sure you are in the `starter_folder` R project.


#### Workspace setup ####
library(tidyverse)
set.seed(1234)


#### Simulate data ####
# State names
states <- c(
  "California", "Texas", "Florida", "New York", "Pennsylvania", "Illinois", "Ohio",
  "Georgia", "North Carolina", "Michigan", "Arizona", "Wisconsin", "Nevada", "Minnesota",
  "Colorado", "Virginia", "Missouri", "Tennessee", "Indiana", "Massachusetts"
)

# Polling organizations
pollsters <- c("YouGov", "AtlasIntel", "Ipsos", "RMG Research", "Emerson College")

# Pollster quality ratings (numeric_grade)
numeric_grades <- c(1.0, 2.0, 2.5, 3.0)

# Transparency scores
transparency_scores <- c(5, 6, 7, 8, 9, 10)

# Create a dataset by randomly assigning states, pollsters, methodologies, and other predictors
simulated_polling_data <- tibble(
  state = sample(
    states,
    size = 200,
    replace = TRUE,
    prob = rep(1 / length(states), length(states))  # Equal probability for each state
  ),
  pollster = sample(
    pollsters,
    size = 200,
    replace = TRUE,
    prob = rep(1 / length(pollsters), length(pollsters))  # Equal probability for each pollster
  ),
  numeric_grade = sample(
    numeric_grades,
    size = 200,
    replace = TRUE  # Random assignment of pollster quality ratings
  ),
  transparency_score = sample(
    transparency_scores,
    size = 200,
    replace = TRUE  # Random assignment of transparency scores
  ),
  candidate_name = sample(
    c("Kamala Harris", "Donald Trump"),  # Focus only on Harris and Trump
    size = 200,
    replace = TRUE
  ),
  # Assign party based on candidate
  pct = round(runif(200, min = 0, max = 60), 1),  # Random percentage support (0-60%)
)


#### Save data ####
write_csv(simulated_polling_data, "data/00-simulated_data/us_simulated_polling_data.parquet")

