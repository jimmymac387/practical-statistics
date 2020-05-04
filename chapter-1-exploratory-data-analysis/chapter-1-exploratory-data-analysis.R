# Style guide: https://style.tidyverse.org/

# Load libraries
library(tidyverse)    # Add tidyverse and piping functions
library(readxl)       # Read xlsx files
library(matrixStats)  # Add weighted median function
library(hexbin)

# Load data ----------------------------------------------------------
state <- read.csv("../data/state.csv")
airline_delays <- read.csv("../data/airline_delay_causes.csv")
sp500_data <- read.csv("../data/sp500_data.csv")
sp500_sectors <- read.csv("../data/sp500_sectors.csv")
kc_tax <- read.csv("../data/kc_tax.csv")
airline_stats <- read.csv("../data/airline_stats.csv")

# Stuff to rearrange -------------------------------------------------
kc_tax %>%
  filter(
    TaxAssessedValue < 750000 &
    SqFtTotLiving > 100 &
    SqFtTotLiving < 3500
  ) %>%
  ggplot(aes(x = SqFtTotLiving, y = TaxAssessedValue)) +
    stat_binhex(color = "white") +
    theme_bw() +
    scale_fill_gradient(low = "white", high = "black") +
    labs(x = "Finished Square Feet", y = "Tax Assessed Value")

kc_tax %>%
  filter(
    TaxAssessedValue < 750000 &
    SqFtTotLiving > 100 &
    SqFtTotLiving < 3500 &
    ZipCode %in% c(98188, 98105, 98108, 98126, 98115)
  ) %>%
  ggplot(aes(x = SqFtTotLiving, y = TaxAssessedValue)) +
    stat_binhex(color = "white") +
    theme_bw() +
    scale_fill_gradient(low = "white", high = "black") +
    labs(x = "Finished Square Feet", y = "Tax Assessed Value") +
    facet_wrap(~ZipCode)

kc_tax %>%
  filter(
    TaxAssessedValue < 750000 &
    SqFtTotLiving > 100 &
    SqFtTotLiving < 3500
  ) %>%
  ggplot(aes(x = SqFtTotLiving, y = TaxAssessedValue)) +
    theme_bw() +
    geom_point(alpha = 0.1) +
    geom_density2d(color = "white") +
    labs(x = "Finished Square Feet", y = "Tax Assessed Value")

airline_stats %>%
  ggplot(aes(x = airline, y = pct_carrier_delay)) +
    ylim(0, 50) +
    geom_boxplot() +
    labs(x = " ", y = "Daily % Delayed Flights")

airline_stats %>%
  ggplot(aes(x = airline, y = pct_carrier_delay)) +
    ylim(0, 50) +
    geom_violin() +
    labs(x = " ", y = "Daily % Delayed Flights")

# Should add contingency table in here

# State Population Totals 2010-2019
# Source: U.S. Census Bureau, Population Division (census.gov)
# Release Date: December 2019
#state_data <- read_xlsx("nst-est2019-01.xlsx")
#head(state_data)

# Untidy -------------------------------------------------------------
# Calculate location and variability estimates
mean(state_data$`2019`)
mean(state_data$`2019`, trim = 0.1)
median(state_data$`2019`)
sd(state_data$`2019`)
IQR(state_data$`2019`)
mad(state_data$`2019`)

# Calculate quantiles
quantile(state_data$`2019`, probs = c(0.2, 0.5, 0.8))

# Create a fake murder rate to calculate weighted values
set.seed(313)
state_data$murder_rate <- rnorm(n = 51, mean = 3.0, sd = 1)
weighted.mean(x = state_data$murder_rate, w = state_data$`2019`)
weightedMedian(x = state_data$murder_rate, w = state_data$`2019`)

boxplot(state_data$`2019` / 1000000, ylab = "Population (millions)")

breaks <- seq(from = min(state_data$`2019`),
              to = max(state_data$`2019`),
              length = 11)
pop_freq <- cut(state_data$`2019`, breaks = breaks,
                right = TRUE, include.lowest = TRUE)
table(pop_freq)

hist(state_data$`2019`, breaks = breaks)

hist(state_data$murder_rate, freq = FALSE)
lines(density(state_data$murder_rate), lwd = 3, col = "blue")
# Add correlation matrix for stock symbols

# Tidy ---------------------------------------------------------------
# Calculate location and variability estimates
state_data %>%
  summarize(
    mean = mean(`2019`),
    trimmed_mean = mean(`2019`, trim = 0.1),
    median = median(`2019`),
    sd = sd(`2019`),
    iqr = IQR(`2019`),
    mad = mad(`2019`)
  )

# Calculate quantiles
p <- c(0.2, 0.5, 0.8)
p_names <- map_chr(p, ~paste0(.x*100, "%"))
p_funs <-
  map(p, ~partial(quantile, probs = .x, na.rm = TRUE)) %>%
  set_names(nm = p_names)

state_data %>%
  summarize_at(vars(`2019`), p_funs)

# Create a fake murder rate to calculate weighted values
set.seed(313)
state_data %>%
  mutate(murder_rate = rnorm(n = 51, mean = 3.0, sd = 1)) %>%
  summarize(
    weight_mean = weighted.mean(x = murder_rate, w = `2019`),
    weight_median = weightedMedian(x = murder_rate, w = `2019`)
  )

state_data %>%
  ggplot() +
  geom_boxplot(aes(y = `2019` / 1000000)) +
  ylab("Population (millions)") +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

# Need to add frequency table, histogram, and density plot
# Add correlation matrix for stock symbols
