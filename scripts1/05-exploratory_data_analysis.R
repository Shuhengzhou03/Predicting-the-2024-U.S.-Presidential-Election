#### Preamble ####
# Purpose: Exploratory Data Analysis (EDA) on the cleaned U.S. polling dataset.
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-11-04
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse`, `ggplot2`, and `janitor` packages must be installed and loaded.
# - 02-clean_data.R must have been run to produce the cleaned data.
# Any other information needed? Make sure you are in the `starter_folder` R project.

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(janitor)

# Load cleaned data
analysis_data <- read_parquet("data/02-analysis_data/us_polling_cleaned_data.parquet")

#### Summary Statistics ####
# General overview of the dataset
summary_stats <- analysis_data |>
  summarise(
    avg_pct = mean(pct, na.rm = TRUE),
    min_pct = min(pct, na.rm = TRUE),
    max_pct = max(pct, na.rm = TRUE),
    count_harris = sum(candidate_name == "Kamala Harris"),
    count_trump = sum(candidate_name == "Donald Trump")
  )
print(summary_stats)

#### Visualizations ####
# Distribution of Support Percentage
analysis_data |>
  ggplot(aes(x = pct, fill = candidate_name)) +
  geom_histogram(bins = 30, alpha = 0.7, position = "identity") +
  labs(
    title = "Distribution of Support Percentage by Candidate",
    x = "Support Percentage",
    y = "Count"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("#1f77b4", "#ff7f0e"))

# Support by Pollster (Scatter Plot Showing All Observations)
analysis_data |>
  ggplot(aes(x = pollster, y = pct, color = candidate_name)) +
  geom_jitter(width = 0.2, alpha = 0.7) +
  labs(
    title = "Support by Pollster (Scatter Plot Showing All Observations)",
    x = "Pollster",
    y = "Support Percentage"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_manual(values = c("#1f77b4", "#ff7f0e"))

# Effect of Transparency Score on Support
analysis_data |>
  ggplot(aes(x = transparency_score, y = pct, color = candidate_name)) +
  geom_jitter(width = 0.3, alpha = 0.7) +
  geom_smooth(method = "lm") +
  labs(
    title = "Effect of Transparency Score on Support Percentage",
    x = "Transparency Score",
    y = "Support Percentage"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("#1f77b4", "#ff7f0e"))

