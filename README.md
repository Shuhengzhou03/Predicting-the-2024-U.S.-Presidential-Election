# Forecasting a Lead for Kamala Harris in the 2024 U.S. Presidential Election
## Overview


This repository presents a statistical model aimed at forecasting the support rates of candidates in the 2024 U.S. Presidential Election. Currently, Vice President Kamala Harris and former President Donald Trump are in a tight race, with support rates especially competitive in key swing states like Pennsylvania, Georgia, and Michigan, where voter preferences may determine the final result. Backed strongly by President Biden, Harris aims to secure the presidency and maintain Democratic control of Congress. This study employs a Bayesian generalized linear model to integrate polling data from multiple sources, providing a comprehensive analysis and forecast of the support rates for both candidates to enhance prediction accuracy.


## File Structure

The repo is structured as:
- **data**
  - `00-simulated_data/`: Contains the simulated data generated for model testing.
    - `us_simulated_polling_data.parquet`
  - `01-raw_data/`: Contains the raw polling data used for analysis.
    - `us_polling_raw_data.csv`
  - `02-analysis_data/`: Contains cleaned and analyzed data that was constructed from the raw data.
    - `us_polling_cleaned_data.parquet`

    
- **models/**: Contains fitted models for both Harris and Trump, saved in RDS format.
  - `harris_model.rds`
  - `trump_model.rds`

- **other/**
  - `llm_usage/`: Includes documentation about interactions with large language models (LLMs).
    - `usage.txt`
  - `sketches/`: Contains images related to exploratory data analysis and dataset exploration.
    - `dataset.png`
    - `state.png`
    - `pollster.png`
    - `transparency.png`
    - `numeric score.png`
    
- **paper/**: Contains files used to generate the final paper.
  - `paper.pdf`: The final report in PDF format.
  - `paper.qmd`: The Quarto document used to generate the report.
   - `references.bib`: Bibliography file with references for the paper.

- **scripts/**: Contains R scripts for simulating, downloading, cleaning, and analyzing the data.
  - `00-simulate_data.R`: Script to create simulated datasets.
  - `01-test_simulated_data.R`: Verifies the accuracy of simulated datasets.
  - `02-download_data.R`:Retrieves data from FiveThirtyEight.
  - `03-clean_data.R`:Cleans the raw data for analysis.
  - `04-test_analysis_data.R`:Checks the readiness of cleaned data for analysis.
  - `05-exploratory_data_analysis.R`:Conducts exploratory data analysis (EDA).
  - `06-model_data.R`:Develops and optimizes analytical models.

## Statement on LLM usage
Parts of the code were developed with the help of ChatGPT-4o. The abstract, introduction, as well as table and results descriptions, were also developed with assistance from ChatGPT-4o.The full chat history is documented in other/llm_usage/usage.txt.

