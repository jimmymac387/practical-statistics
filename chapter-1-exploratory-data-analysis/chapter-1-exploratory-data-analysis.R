# Style guide: https://style.tidyverse.org/

# Load libraries
library(tidyverse)    # Add tidyverse and piping functions
library(readxl)       # Read xlsx files
library(matrixStats)  # Add weighted median function

# State Population Totals 2010-2019
# Source: U.S. Census Bureau, Population Division (census.gov)
# Release Date: December 2019
state_data <- read_xlsx("nst-est2019-01.xlsx")
head(state_data)

# Untidy -------------------------------------------------------------
mean(state_data[["2019"]])
mean(state_data[["2019"]], trim = 0.1)
median(state_data[["2019"]])

# Create a fake murder rate to calculate weighted values
set.seed(313)
state_data$murder_rate <- rnorm(n = 51, mean = 3.0, sd = 1)
weighted.mean(x = state_data$murder_rate, w = state_data$`2019`)
weightedMedian(x = state_data$murder_rate, w = state_data$`2019`)

# Tidy ---------------------------------------------------------------
state_data %>%
  summarize(
    mean = mean(`2019`),
    trimmed_mean = mean(`2019`, trim = 0.1),
    median = median(`2019`)
  )

# Create a fake murder rate to calculate weighted values
set.seed(313)
state_data %>%
  mutate(murder_rate = rnorm(n = 51, mean = 3.0, sd = 1)) %>%
  summarize(
    weight_mean = weighted.mean(x = murder_rate, w = `2019`),
    weight_median = weightedMedian(x = murder_rate, w = `2019`)
  )
# Testing
