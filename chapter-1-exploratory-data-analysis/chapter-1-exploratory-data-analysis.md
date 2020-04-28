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

Outliers should only be modified or removed when they are the result of data errors or bad readings from a sensor

##### Comparing terminology between disciplines
 - **Statisticians:** *Estimate* values from the data to create *estimates*
 - **Data scientists:** *Measure* values from the data to create *metrics*
