---

---



# **Logistic regression**

## What is a logistic regression?

* Association between binary response variable and predictors 
* Example: species distribution models 
    + Binary response variable: presence (1) or absence (0) of species in area
    + Predictions of habitat suitability

## How are logistic regressions different from linear regressions?

*Linear regression*  
- Quantitative predictions: straight line  
- Correlation and test for significance of regression  
- Model comparison (eg., single versus several predictors)  

*Logistic regression*  
- We can also do all of that!  
- Main difference: our outcomes are now *binary*
- Examples of binary outcomes: presence versus absence; positive to a disease versus negative; dead versus alive  
- Outcomes can be categorized as 1 (e.g., success) and 0 (e.g., failure)

## How does this type of data look like?
- Hamilton Harbour dataset: let's suppose that it becomes hard for zooplankton to eat when there are more "less edible" algae than "edible" algae in the environment
- That was the criteria for populating the column "Easy to eat":


| Nitrate/nitrite|  Edible| Less edible|Easy to eat |
|---------------:|-------:|-----------:|:-----------|
|            2.23|  884.60|      1645.7|no          |
|            2.50|  900.00|      1133.3|no          |
|            2.50|  923.20|       939.9|no          |
|            2.13| 1546.40|      1312.0|yes         |
|            2.13|  811.90|       454.1|yes         |
|            2.62|  339.16|       308.2|yes         |
|            2.67| 1376.80|       552.2|yes         |

When we plot this type of binary data, we see that observations are either of the two outcome possibilities:



![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic1.png)

This type of data is best fit by an s-shaped curve instead of a line. And this is another difference between linear and logistic regressions.
 
## What does the logistic curve mean?



![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic2.png)

* It represents the *probability* of positive outcomes depending on predictors  
* As we move along the curve and our predictor values change, we go from 0 to 100% probability of our outcome  

## Aquatic ecology studies using logistic regressions  

- The distribution of gammarid species was predicted using logistic regressions, where current velocity was the most important factor explaining their distribution [(Peeters & Gardeniers, 1998)](https://onlinelibrary.wiley.com/doi/epdf/10.1046/j.1365-2427.1998.00304.x)  

- Foraging shift behaviour from the benthos to the water surface in brown trout (1 = surface prey consumed, 0 = no surface prey consumed) was predicted using fish length as a predictor in a logistic regression [(SC!nchez-HernC!ndez & Cobo, 2017)](https://cdnsciencepub.com/doi/full/10.1139/cjfas-2017-0021])

![[Amphipod Gammaridae](https://commons.wikimedia.org/wiki/File:Amphipod_Gammaridae_%288741971996%29.jpg); [Brown Trout, USFWS Mountain-Prairie](https://www.flickr.com/photos/usfwsmtnprairie/49860328703)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic_studies_example.jpg)


## What kind of predictors can we have in a logistic regression?

Just like in a linear regression, we can use continuous and/or discrete variables to make predictions. Here are some examples:

**Continuous variables**

+ Temperature  

+ Precipitation  

+ Water depth  

+ Nitrogen concentration  

**Discrete variables**  

+ Levels of aquatic vegetation  

+ Soil type 

+ Water body type  


## Mathematical representation

* Logistic regression: transformation of response variable to get linear relationship  
* logit (log of probability of success/probability of failure)
* Explanatory variable is in log(odds)  

Equation for logistic regression:

$$ Log (p/1-p) = b0+b1*x1+e $$
*Log (p/1-p)*: response variable  
*b0*: y intercept  
*x*: predictor variable  
*b1*: slope for explanatory variable 1  
*e*: error  

If we had more explanatory variables, we could keep adding them to the equation above as b2*x2 and so forth.
 

## Key binomial logistic model assumptions  

- Dependent variable has 2 levels or is a proportion of successes  

- Observations are independent  

- Normal distribution of data or residuals is not needed  

## Creating a logistic model in R

### Steps to run a logistic model in R

1. Select potentially interesting predictors
2. Format predictors to correspond to binomial levels
3. Select time period and location
4. Run model
5. Interpret model
6. Plot results

### Let's create this first model together

First, we are going to create a new dataset called "filam_diatom" including some potentially interesting variables:


```r
filam_diatom <- ham[, c("area_group", "season", 
                        "filamentous_Diatom", "mean_mixing_depth_temp")]
```


| Location | Season | Filamentous diatom biomass | Epilimnion temperat. |
|:--------:|:------:|:--------------------------:|:--------------------:|
|   deep   |   2    |            0.00            |        21.79         |
|   deep   |   2    |            3.10            |        21.83         |
|    NE    |   1    |             NA             |        19.89         |
|   deep   |   1    |             NA             |        19.71         |
|    NE    |   1    |             NA             |        13.90         |
|   deep   |   1    |           287.18           |        16.05         |

Let's consider that filamentous diatom is our response variable of interest, as this food source is hard for zooplankton to consume. We will look at epilimnion temperature as a potential explanatory variable.

Before we can get started with the analysis, we need to remove NA data:


```r
filam_diatom <- na.omit(filam_diatom)
```

Now we will create a new column to describe presence or absence of filamentous diatoms.

We can do that with a function called "ifelse" to label all observations where measurements were greater than zero as "present", and all observations where measurements were equal to zero as "absent":


```r
filam_diatom$filam_presence <- ifelse(filam_diatom$filamentous_Diatom > 0, "present", "absent")
```

Now we format this column as "factor" and ensure the reference group ("absent") is the first to be shown:


```r
filam_diatom$filam_presence <- factor(filam_diatom$filam_presence)
levels(filam_diatom$filam_presence)
```

```
## [1] "absent"  "present"
```

- Subsetting to analyse at specific times of the year and at specific locations

Here we select summer conditions and remove deep locations:


```r
filam_diatom <- filam_diatom[(filam_diatom$season == 2 | filam_diatom$season == 3) & filam_diatom$area_group != "deep", ]
```

Run model using glm function and family binomial


```r
model <- glm(filam_presence ~ mean_mixing_depth_temp,
             data = filam_diatom, family = binomial)
```

Now we can check the model results


```r
summary(model)
```

```
## 
## Call:
## glm(formula = filam_presence ~ mean_mixing_depth_temp, family = binomial, 
##     data = filam_diatom)
## 
## Coefficients:
##                        Estimate Std. Error z value Pr(>|z|)   
## (Intercept)             10.1581     3.8402   2.645  0.00816 **
## mean_mixing_depth_temp  -0.4202     0.1736  -2.420  0.01551 * 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 79.807  on 69  degrees of freedom
## Residual deviance: 72.195  on 68  degrees of freedom
## AIC: 76.195
## 
## Number of Fisher Scoring iterations: 5
```

So we can see that our p-value for the epilimnion temperature predictor is smaller than 0.05. This suggests that there is a statistically significant relationship between temperature and the presence of filamentous diatoms.

Let's see what each component of the model result summary means:

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic_model_output.jpg)


We are now ready for the best part: plotting model predictions  

First, we calculate predicted probabilities for different temperature values: 

```r
# Create a sequence of temperature values
mean_mixing_depth_temp_values <- seq(min(filam_diatom$mean_mixing_depth_temp), max(filam_diatom$mean_mixing_depth_temp), length.out = length(filam_diatom$mean_mixing_depth_temp))

# Create a data frame with these temperature values
newdata <- data.frame(mean_mixing_depth_temp = mean_mixing_depth_temp_values)

# Predict probabilities for each temperature value
predicted_probabilities_filam <- predict(model, newdata = newdata, type = "response")

# Calculate errors around these predictions (confidence intervals)
z <- qnorm(1 - (1 - 0.95) / 2)  # 95% confidence level
se <- sqrt(predicted_probabilities_filam * (1 - predicted_probabilities_filam) / nrow(filam_diatom))
lower_bound <- predicted_probabilities_filam - z * se
upper_bound <- predicted_probabilities_filam + z * se
```

Now we are ready to plot the actual data and the model predictions:

```r
# Convert "present" and "absent" to 1 and 0
presence_numeric_filam <- ifelse(filam_diatom$filam_presence == "present", 1, 0)

# Plot the actual data along with predicted probabilities and confidence intervals
plot(mean_mixing_depth_temp_values, predicted_probabilities_filam, type = "l",
     main = "Filamentous diatom presence",
     xlab = "Epilimnion temperature (\u00B0C)", ylab = "Predicted probability", cex.axis = 1.5, ylim = c(0, 1), lwd = 2)
lines(mean_mixing_depth_temp_values, lower_bound, col = "blue", lty = 2)
lines(mean_mixing_depth_temp_values, upper_bound, col = "blue", lty = 2)
points(filam_diatom$mean_mixing_depth_temp, presence_numeric_filam)
```

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic3.png)

The dotted curves are confidence intervals, which show us the range in which we are 95% sure about the location of true values, based on our data


### Creating your logistic model 

Now it's your turn! Run this next logistic model using total phosphorus as a predictor, and filamentous diatoms as the response variable again.

#### Try it now {-}

Start by creating a dataset for your analysis. Select a name for your new dataset:

```r
your_dataset <- ham[, c("area_group", "season", 
                        "filamentous_Diatom", "NO2_NO3_ECCC1m")]
```



*Formatting* 

Remove NA data

```r
your_dataset <- na.omit(your_dataset)
```



Now you can create a new column that describes the presence or the absence of filamentous diatoms across the dataset:


```r
# To create a new column, first type the label you chose previously for the dataframe related to the phosphorus analysis (something like "filam_diatom_P"), then create a column name, and use the function "ifelse" to label all observations where measurements were greater than zero as "present", and all observations where measurements were equal to zero as "absent":

your_dataset$new_column_name <- ifelse(your_dataset$filamentous_Diatom > 0, "present", "absent")
```

Format this new column as a factor


```r
your_dataset$filamentous_Diatom <- factor(your_dataset$filamentous_Diatom)

# and check how it looks:
levels(your_dataset$filamentous_Diatom)
```



```
## [1] "absent"  "present"
```

*Run model*


```r
# Use glm function and family binomial
your_model_name <- glm("response variable" ~ "explanatory variable",
             data = your_dataset, family = binomial)
```




Check model results using the summary function


```r
summary(your_model_name)
```



How well did this predictor do? 

*Plot model predictions*

Start with obtaining model predictions and errors:

```r
# Create a sequence of values for nitrite/nitrate
Total_phosphorus_values <- seq(min(filam_diatom_P$NO2_NO3_ECCC1m), max(filam_diatom_P$NO2_NO3_ECCC1m), length.out = length(filam_diatom_P$NO2_NO3_ECCC1m))

# Create a data frame with nitrite/nitrate values
newdata <- data.frame(NO2_NO3_ECCC1m = Total_phosphorus_values)

# Predict probabilities for each value of nitrite/nitrate
predicted_probabilities_P <- predict(model, newdata = newdata, type = "response")

# Calculate confidence intervals
z <- qnorm(1 - (1 - 0.95) / 2)  # 95% confidence level
se <- sqrt(predicted_probabilities_P * (1 - predicted_probabilities_P) / nrow(filam_diatom_P))
lower_bound <- predicted_probabilities_P - z * se
upper_bound <- predicted_probabilities_P + z * se
```

Now you are ready to plot the data and the predictions:

```r
# Convert "present" and "absent" to 1 and 0
presence_numeric_P <- ifelse(filam_diatom_P$filam_presence == "present", 1, 0)

# Plot the predicted probabilities with confidence intervals
plot(Total_phosphorus_values, predicted_probabilities_P, type = "l", 
     main = "Filamentous diatom presence",
     xlab = "Total phosphorous (dissolved fraction) (mg/L)", ylab = "Predicted probability", cex.axis = 1.5, ylim = c(0, 1), lwd = 2)
lines(Total_phosphorus_values, lower_bound, col = "blue", lty = 2)
lines(Total_phosphorus_values, upper_bound, col = "blue", lty = 2)
points(filam_diatom_P$NO2_NO3_ECCC1m, presence_numeric_P)
```


![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic4.png)


## Additional resources

### What could go wrong?

- *Mixing up predictors and response variables in the logistic model equation*
    + If you get a warning or error when running your logistic model, you may have mixed up the predictors and the response variables. The response variable should be the first one to appear after the opening parenthesis 
    + In addition to the variable mix-up, such warning or errors tell us that we may be using quantitative measures as our response variable, which is not appropriate for a logistic regression. See how this error looks like:


```r
model <- glm(mean_mixing_depth_temp ~ filam_presence,
             data = filam_diatom, family = binomial)
```

```
## Error in eval(family$initialize): y values must be 0 <= y <= 1
```

- *Incorrectly coding data so that it is not independent*

Imagine you have counts of living and dead organisms in this imaginary dataset:


|date       |location  | living_daphnia| dead_daphnia|
|:----------|:---------|--------------:|------------:|
|Jan-1-2024 |station-1 |             45|           70|
|Jan-1-2024 |station-2 |             87|           62|
|Jan-1-2024 |station-3 |              4|           94|

In this case, instead of considering each individual as "living" or "dead", you should calculate the proportion of living organisms *per replicate* like this:
    

```r
example_independence$proportion <- round(example_independence$living_daphnia/(example_independence$living_daphnia+example_independence$dead_daphnia),2)
# the round function ensures we have 2 decimals in our proportion values
```


|date       |location  | living_daphnia| dead_daphnia| proportion|
|:----------|:---------|--------------:|------------:|----------:|
|Jan-1-2024 |station-1 |             45|           70|       0.39|
|Jan-1-2024 |station-2 |             87|           62|       0.58|
|Jan-1-2024 |station-3 |              4|           94|       0.04|

This proportion will be your response variable for the logistic model. When using proportions, you should also provide the "weights" information in the glm formula (i.e., a dataset with total number of trials per replicate, or the sum of events where we got success + events where we got failure).

- *Categorical response variable is formatted as character instead of factor* 
    + Formatting data as factors allows for defining order or reference group for statistical testing  


```r
# Here we are selecting and formatting the binomial data as we did before, but now we accidentally forget to format the new column as "factor" 
example <- ham

example$filam_presence <- ifelse(example$filamentous_Diatom > 0, "present", "absent")

model <- glm(filam_presence ~ mean_mixing_depth_temp,
             data = example, family = binomial)
```

```
## Error in eval(family$initialize): y values must be 0 <= y <= 1
```

Check the data in the problematic column:
    

```r
str(example$filam_presence)
```

```
##  chr [1:742] "present" NA NA "present" NA NA NA NA NA NA NA NA "present" NA ...
```

See how we need to remove NA data and format the column as factor for our model to run nicely:


```r
example <- example[!is.na(example$filamentous_Diatom), ]

example$filam_presence <- factor(example$filam_presence)

levels(example$filam_presence)
```

```
## [1] "absent"  "present"
```

```r
model <- glm(filam_presence ~ mean_mixing_depth_temp,
             data = example, family = binomial)
```

No more errors now!

That's it for now, but if you are interested in more complex logistic models, here are some resources:

### R resources 

*Multiple logistic regression*

- [Building Skills in Quantitative Biology (Cuddington, Edwards, & Ingalls, 2022)](https://www.quantitative-biology.ca/machine-learning-and-classification.html#multiple-logistic-regression)  

- [Getting started with Multivariate Multiple Regression (Ford, 2024)](https://library.virginia.edu/data/articles/getting-started-with-multivariate-multiple-regression)  


*Multinomial logistic regression*

- [Multinomial logistic regression (Russell, 2022)](https://ladal.edu.au/regression.html#Mixed-Effects_Binomial_Logistic_Regression)  

*Mixed-effects logistic regression*

- [Mixed-Effects Binomial Logistic Regression (Schweinberger, 2022 )](https://stats4nr.com/logistic-regression#modeling-more-than-two-responses)   

- [Mixed-effects logistic regression (Sonderegger, Wagner, & Torreira, 2018)](https://people.linguistics.mcgill.ca/~morgan/qmld-book/mixed-effects-logistic-regression.html)   
