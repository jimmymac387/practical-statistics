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

# Untidy
mean(state_data[["2019"]])
mean(state_data[["2019"]], trim = 0.1)
median(state_data[["2019"]])

# Create a fake murder rate to calculate weighted values
set.seed(313)
state_data$murder_rate <- rnorm(n = 51, mean = 3.0, sd = 1)
weighted.mean(x = state_data$murder_rate, w = state_data$`2019`)
weightedMedian(x = state_data$murder_rate, w = state_data$`2019`)

# Tidy
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




##### BELOW IS INTERESTING BUT NOT NECESSARY #####
# Load libraries
library(randomNames)  # Generate random names

# Create data set with fake data
people <- randomNames(
  n = 1000,                   # Get 1000 names
  name.order = "first.last",  # Set name order
  name.sep = " ",             # Separate names with space
  return.complete.data = T    # Get gender and ethnicity
)

heights <-
  people %>%
  as_tibble() %>%
  select(first_name, last_name, gender, ethnicity) %>%
  mutate(
    gender =
      case_when(
        gender == 0 ~ "Male",
        gender == 1 ~ "Female"
      ),
    ethnicity =
      case_when(
        ethnicity == 1 ~ "American Indian/Native Alaskan",
        ethnicity == 2 ~ "Asian or Pacific Islander",
        ethnicity == 3 ~ "Black (not Hispanic)",
        ethnicity == 4 ~ "Hispanic",
        ethnicity == 5 ~ "White (not Hispanic)",
        ethnicity == 6 ~ "Middle-Eastern"
      ),
      height_ft =
        round(
          x = rnorm(
            n = 1000,
            mean = 5.4,
            sd = 0.4),
          digits = 2
        )
      )

head(heights)
mean(heights$height_ft)
mean(heights$height_ft, trim = 0.1)
median(heights$height_ft)
