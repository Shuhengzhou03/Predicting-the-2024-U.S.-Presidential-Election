#### Preamble ####
# Purpose: Downloads and saves the data from FiveThirtyEight's polling outcomes for the 2024 Presidential general election.
# Author: Jiaxuan Song, Zien Gao, Shuheng (Jack) Zhou
# Date: 2024-11-04
# Contact: lauragao75@gmail.com
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded.
# Any other information needed? Make sure you are in the `starter_folder` R project.


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Download data ####
# URL to download polling data
url <- "https://projects.fivethirtyeight.com/polls/data/president_polls.csv"

# Download the data from FiveThirtyEight
the_raw_data <- read_csv(url(url))


#### Save data ####
# Save the downloaded raw data to a CSV file
write_csv(the_raw_data, "data/01-raw_data/us_polling_raw_data.csv")


         
