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
