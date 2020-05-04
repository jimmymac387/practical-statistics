# Chapter 1: Exploratory Data Analysis

### History
- John Tukey created foundation of modern data analysis with his 1997 book *Exploratory Data Analysis*.

### Structured vs. Unstructured Data
 - **FILL IN MORE**
 - Unstructured - Pixels in an image, words in text, clickstreams, etc.
 - Add notes here

There are two basic types of structured data: numeric and categorical

### Data Types
Data types help determine the type of visualization, data analysis, or statistical model that one chooses and signals to software how to handle the data

##### Key Terms
 - ***Continuous (aka interval, float, numeric)*** - Data that can take on any value in an interval
 - ***Discrete (aka integer, count)*** - Data that can take on only integer values, such as counts
 - ***Categorical (aka factors, nominal)*** - Data that can take on only a specific set of values representing a set of possible categories
 - ***Binary (aka logical, boolean)*** - A special case of categorical data with just two categories of values
 - ***Ordinal (aka ordered factor)*** - Categorical data that has an explicit ordering

### Rectangular Data
Rectangular data is essentially a two-dimensional matrix with rows indicating records (cases) and columns indicating features (variables)

Unstructured data must be processed and manipulated before it can be represented as a set of features in a rectangular data format

##### Examples of nonrectangular data
 - Time series data
 - Spatial data
 - Graph/network data

##### Key terms
 - ***Data frame*** - Rectangular data (like a spreadsheet) is the basic data structure for statistical and machine learning models
 - ***Feature (aka variable, predictor, attribute, input)*** - A column in the data frame
 - ***Outcome (aka dependent variable, response, target, output)*** - The outcome of a data science project; features are used to predict the outcome
 - ***Records (aka case, observation, sample)*** - A row in the data frame

Data frames have one more more columns designated as an index that can help improve the efficiency of operations
 - In *Python*, the `pandas` package uses `DataFrame` objects to store rectangular data and natively support multilevel indexes
 - In *R*, the native `data.frame` object stores rectangular data with a single-level integer index based on row order; however, other packages like `data.table` and `dplyr` can be used to extend support for multilevel indexes

##### Comparing terminology between disciplines
 - **Statisticians:** Use *predictor variables* to predict a *response* or *dependent variable*
 - **Data scientists:** Use *features* to predict a *target*

### Estimates of Location
A basic step in exploring data is getting a *typical value* for each feature (variable) or an estimate of where most data is located (central tendency)
##### Key terms
 - ***Mean (aka average)*** - The sum of all values divided by the number of values
 - ***Weighted mean (aka weighted average)*** - The sum of all values times a weight divided by the sum of the weights
 - ***Median (aka 50th percentile)*** - The value such that one-half of the data lies above and below
 - ***Weighted median*** - The value such that one-half of the sum of the weights lies above and below the sorted data
 - ***Trimmed mean (aka truncated mean)*** - The average of all values after dropping a fixed number of extreme values
 - ***Robust (aka resistant)*** - Not sensitive to extreme values
 - ***Outlier (aka extreme value, anomaly)*** - A data value that is very different from most of the data

Weighted means adjust estimates for data where some values are more variable than others or where the collected data does not equally represent different groups of interest

Trimmed means eliminate the influence of extreme values--trimming the bottom and top 10% is a common choice

Trimmed means, medians, and weighted medians are robust to outliers

> Trimmed means are a good balance between the median and mean: they are robust to extreme values, but use more data to estimate the value representing the central tendency

##### Example:
```r
> mean(state$population)
[1] 6162876
> mean(state$population, trim = 0.1)
[1] 4783697
> median(state$population)
[1] 4436370
```

Outliers should only be modified or removed when they are the result of data errors or bad readings from a sensor

##### Comparing terminology between disciplines
 - **Statisticians:** *Estimate* values from the data to create *estimates*
 - **Data scientists:** *Measure* values from the data to create *metrics*

### Estimates of Variability
Variability (aka dispersion) measures whether data values are tightly clustered or spread out

Goal of statistics is to measure it, reduce it, distinguish random variability from real variability, identifying sources of real variability, and making decisions in the presence of it

##### Key terms
- ***Deviations (aka errors, residuals)*** - The difference between observed values and estimate of location
- ***Variance (aka mean-squared-error)*** - The sum of squared deviations from the mean divided by *n* - 1 where *n* is the number of data values
- ***Standard deviation*** - The square root of the variance
- ***Mean absolute deviation*** - The mean of the absolute value of the deviations from the mean
- ***Median absolute deviation from the median (aka MAD)*** - The median of the absolute value of the deviations from the median
- ***Range*** - The difference between the largest and the smallest value in a dataset
- ***Order statistics (aka ranks)*** - Metrics based on the data values sorted from smallest to largest; often used in non-parametric tests
- ***Percentile (aka quantile)*** - The values such that *P* percent of the values take on this value or less and (100 - *P*) percent take on this value or more
- ***Interquartile range (aka IQR)*** - The difference betweent he 75th percentile and the 25th percentile

Variance and standard deviation is preferred in statistics over the mean absolute deviation because squared values tend to be easier to work with than absolute values

The standard deviation is easier to interpret than the variance because it is on the same scale as the data (while the variance is reported in squared units) but both measures are routinely reported

Variance and standard deviation are especially sensitive to outliers and extreme values because they are based on squared deviations

Mean absolute deviation is less sensitive to outliers and extreme values but the MAD is the most robust estimate of variability

Percentiles are also robust againast outliers and extreme values but calculating them can be computationally difficult for large datasets because it requires sorting all the data values
- R offers several different ways to approximate percentiles to reduce computational effort

### Exploring the Data Distribution
It is also important to udnerstand how the data is distributed overall in addition to calculating estimates of location and variability

##### Key terms
- ***Boxplot (aka box and whisker plot)*** - A plot introduced by Tukey as a quick way to visualize the distribution of data
- ***Frequency table*** - A tally of the count of numeric data values that fall into a set of intervals (bins)
- ***Histogram*** - A plot of the frequency table with the bins on the x-axis and the count (or proportion) on the y-axis
- ***Density plot*** - A smoothed version of the histogram, often based on a *kernel density estimate*

Boxplots are based on percentiles where the top and bottom of the box are the 75th and 25th percentiles, respectively, and the median is shown by the horizontal line in the box

The vertical lines indicate the range for the bulk of the data and any data outside of the lines are plotted as single points

```r
boxplot(state$population / 1000000, ylab = "Population (millions)")
```

Frequency tables and histograms divide up the variable range into equally spaced segments and indicates how many values fall in each segments

```r
breaks <- seq(from = min(state$population),
              to = max(state$population),
              length = 11)
pop_freq <- cut(state$population, breaks = breaks,
                right = TRUE, include.lowest = TRUE)
table(pop_freq)
```

Histograms are a way to visualize frequency tables with bins on the x-axis and a count on the y-axis
- Bins are equal length
- No empty space is shown between bars unless there is an empty bin

```r
hist(state$population, breaks = breaks)
```

Density plots are essentially smoothed histograms and are based on *proportions* rather than *counts*

```r
hist(state$murder_rate, freq = FALSE)
lines(density(state$murder_rate), lwd = 3, col = "blue")
```

### Binary and Categorical Data

##### Key terms
- ***Mode*** - The most commonly occurring category or value in a dataset
- ***Expected value*** - When the categories can be associated with a numeric value--gives an average value based on the category's probability of occurrence
- ***Bar chart*** - The frequency or proportion for each category plotted as libraries
- ***Pie charts*** - The frequency or proportion for each category plotted as wedges in a pie

Bar charts have categories listed on the x-axis and frequencies or proportions on the y-axis

```r
barplot(as.matrix(dfw) / 6, cex.axis = 0.5)
```

Pie charts are an alternative to bar charts but statisticians and data visualization experts generally agree that pie charts are less informative (Few 2007)

Expected values are similar to weighted means but use probabilities as the weights
- Fundamental concept in business valuation and capital budgeting (e.g., expected value of five years of profits from new acquisition or expected cost savings from new patient management software)
- A company offers two services ($200/month and $25/month) and believe that people will sign up at a rate of 10% for the more expensive service and 50% for the less expensive service after attending a free webinar
- The expected value of a webinar attendee is then calculated by calculating: (0.10 * 200) + (0.50 * 25) + (0.40 * 0) = $32.50

### Correlation
Correlation measures the extent to which two variables are associated with one another

Exploratory data analysis involves examining correlation among predictors and between predictors and a target variable

##### Key terms
- ***Correlation coefficient*** - A metric that measures the extent to which numeric variables are associated with one another (ranges from -1 to +1)
- ***Correlation matrix*** - A table where the variables are shown on both rows and columns, and the cell values are the correlations between the variables
- ***Scatterplot*** - A plot in which the x-axis is the value of one variable and the y-axis is the value of another

```r
# Create a correlation matrix
corrplot(cor(etfs))
```

Correlation coefficient is not a useful metric when the association between two variables is not linear

Although, *Pearson's correlation coefficient* is the most widely used there are others including ones that are more robust to outliers like those included in the `robust` package
- *Spearman's rho* and *Kendall's tau* are other robust correlation coefficients calculated based on rank, which are good for small datasets and specific hypothesis tests

Scatterplots are used to show the relationship between two measured variables

> Random arrangements of data may produce both positive and negative values for the correlation coefficient just by chance

### Exploring Two or More Variables
The appropriate type of bivariate or multivariate analysis depends on the nature of the data: numeric vs. categorical

##### Key terms
- ***Bivariate analysis*** - Comparing two variables
- ***Multivariate analysis*** - Comparing more than two variables
- ***Contingency tables*** - A tally of counts between two or more categorical variables
- ***Hexagonal binning*** - A plot of two numeric variables with recrods binned into hexagons
- ***Contour plots*** - A plot showing hte density of two numeric variables like a topographic map
- ***Violin plots*** - Similar to boxplot but shwing the density estimate

Scatterplots are good when there is a relatively small number of data values because too many values make the scatterplot too dense to see patterns

Hexagonal binning and contours are two alternatives to scatterplots when there are a lot of data points
- Heat maps can also be used to show the relationship between two numeric values

```r
ggplot(kc_tax0, aes(x = SqFtTotLiving, y = TaxAssessedValue)) +
  stat_binhex(color = "white") +
  theme_bw() +
  scale_fill_gradient(low = "white", high = "black") +
  labs(x = "Finished Square Feet", y = "Tax Assessed Value")

ggplot(kc_tax0, aes(x = SqFtTotLiving, y = TaxAssessedValue)) +
  theme_bw() +
  geom_point(alpha = 0.1) +
  geom_density2d(color = "white")
  labs(x = "Finished Square Feet", y = "Tax Assessed Value")
```

Contingency tables are a good way to summarize two categorical Variables

```r
table(lc_loans$grade, lc_loans$status)
```

Boxplots and violin plots are used to show categorical and numeric data together

```r
boxplot(pct_delay ~ airline, data = airline_stats, ylim = c(0, 50))

ggplot(data = airline_stats, aes(x = airline, y = pct_carrier_delay)) +
  ylim(0, 50) +
  geom_violin +
  labs(x = " ", y = "Daily % Delayed Flights")
```

### Visualizing Multiple variables
Mutlple variables can be compared using *conditioning*
- This is achieved in R by using using the `facet_wrap` function in the `ggplot2` package and in Python using the `seaborn` and `bokeh` modules
-

```r
ggplot(subset(kc_tax0, ZipCode %in% c(98188, 98105, 98108, 98126))) +
  stat_binhex(color = "white") +
  scale_fill_gradient(low = "white", high = "black") +
  labs(x = "Finished Square Feet", y = "Tax Assessed Value") +
  facet_wrap(~ZipCode)
```
