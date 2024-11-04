
#### Preamble ####
# Purpose: Cleans the raw presidential polling data obtained from FiveThirtyEight
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-11-04
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse`, `janitor`, and `arrow` packages must be installed and loaded.
# - 02-download_data.R must have been run.
# Any other information needed? We downloaded our president_polls data from FiveThirtyEight on October 29, 2024


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)


#### Clean data ####
raw_data <- read_csv("data/01-raw_data/us_polling_raw_data.csv") |>
  clean_names() |>
  filter(!is.na(numeric_grade) & !is.na(transparency_score))

cleaned_data <-
  raw_data |>
  mutate(
    state = if_else(is.na(state), "National", state),
    numeric_grade = as.numeric(numeric_grade),
    transparency_score = as.numeric(transparency_score),
    pct = as.numeric(pct)
  ) |>
  filter(
    candidate_name %in% c("Kamala Harris", "Donald Trump"),
    transparency_score >= 5,
    numeric_grade >= 2.0,
    !is.na(pct)  ) |>
  select(state, pollster, numeric_grade, transparency_score, candidate_name, pct)

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/us_polling_cleaned_data.parquet")

