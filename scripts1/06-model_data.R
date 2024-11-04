#### Preamble ####
# Purpose: Fit Bayesian generalized linear models to predict support for Kamala Harris and Donald Trump
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-10-31
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse` and `rstanarm` packages must be installed and loaded.
# - Cleaned datasets for Kamala Harris and Donald Trump should be available.
# Any other information needed? Make sure you are in the `starter_folder` R project.


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)

# Load cleaned datasets
cleaned_data <- read_parquet("data/02-analysis_data/us_polling_cleaned_data.parquet")

just_harris_high_quality <-
  cleaned_data |>
  filter(candidate_name == "Kamala Harris")

just_trump_high_quality <-
  cleaned_data |>
  filter(candidate_name == "Donald Trump")

#### Fit Bayesian Models ####
# Prepare data for modeling
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    pollster = factor(pollster),
    state = factor(state)
  )

just_trump_high_quality <- just_trump_high_quality |>
  mutate(
    pollster = factor(pollster),
    state = factor(state)
  )

# Specify priors
priors <- normal(0, 1)

# Model for Kamala Harris: Predicting percentage support using key predictors
harris_model <- stan_glm(
  pct ~ pollster + state + transparency_score + numeric_grade,
  data = just_harris_high_quality,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  chains = 4,
  iter = 4000,
  adapt_delta = 0.95
)

# Model for Donald Trump: Predicting percentage support using key predictors
trump_model <- stan_glm(
  pct ~ pollster + state + transparency_score + numeric_grade,
  data = just_trump_high_quality,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  chains = 4,
  iter = 4000,
  adapt_delta = 0.95
)
# Save the Harris model
saveRDS(harris_model, file = "models/harris_model.rds")
# Save the Trump model
saveRDS(trump_model, file = "models/trump_model.rds")

#### Summarize Models ####

# Summary of Harris model
summary(harris_model)

# Summary of Trump model
summary(trump_model)

# Posterior predictive checks
pp_check(harris_model)
pp_check(trump_model)

# Aggregate predicted support for each candidate
just_harris_high_quality <- just_harris_high_quality |>
  mutate(fitted_pct = predict(harris_model))
just_trump_high_quality <- just_trump_high_quality |>
  mutate(fitted_pct = predict(trump_model))

harris_avg_support <- mean(just_harris_high_quality$fitted_pct)
trump_avg_support <- mean(just_trump_high_quality$fitted_pct)

if (harris_avg_support > trump_avg_support) {
  message("Prediction: Kamala Harris is likely to win with an average support of ", round(harris_avg_support, 2), "%.")
} else {
  message("Prediction: Donald Trump is likely to win with an average support of ", round(trump_avg_support, 2), "%.")
}

#### Plot model predictions against Transparency Score ####

# Combine datasets for Harris and Trump
combined_data <- bind_rows(
  just_harris_high_quality |>
    mutate(candidate = "Kamala Harris", fitted_pct = predict(harris_model)),
  just_trump_high_quality |>
    mutate(candidate = "Donald Trump", fitted_pct = predict(trump_model))
)

# Plot for both Harris and Trump
combined_plot <- ggplot(combined_data, aes(x = transparency_score, y = pct, color = candidate)) +
  geom_point(alpha = 0.7) +
  geom_smooth(aes(y = fitted_pct), method = "lm", se = FALSE, linetype = "dotted") +
  theme_classic() +
  labs(
    y = "Support Percentage",
    x = "Transparency Score",
    title = "Predicted Support for Kamala Harris and Donald Trump by Transparency Score"
  ) +
  scale_color_manual(values = c("Kamala Harris" = "blue", "Donald Trump" = "red"))

print(combined_plot)

state_support <- combined_data |>
  group_by(state, candidate) |>
  summarize(avg_support = mean(fitted_pct), .groups = "drop")

# Retain data for key states only
key_states <- c("Florida", "Pennsylvania", "Michigan", "Wisconsin", "Arizona", 
                "Georgia", "Texas", "California", "New York", "North Carolina")

state_support_filtered <- state_support |>
  filter(state %in% key_states)

# Plot predicted support by key states only
fig2 <- ggplot(state_support_filtered, aes(x = reorder(state, avg_support), y = avg_support, fill = candidate)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(
    y = "Average Predicted Support Percentage",
    x = "State",
    title = "Predicted Support in Key States for Harris & Trump"
  ) +
  scale_fill_manual(values = c("Kamala Harris" = "#66CCCC", "Donald Trump" = "#FF9999")) +
  coord_flip() +
  theme(
    axis.text.y = element_text(size = 8)
  )

# Print the plot
print(fig2)
