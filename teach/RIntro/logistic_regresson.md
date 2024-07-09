---

---



# Logistic regression

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
Here is some hypothetical data of a undesirable organism, as it is less edible for zooplankton. We record the presence or absence of this organism at each observation like this:  


| Nitrate/nitrite|Presence | Binary|
|---------------:|:--------|------:|
|            1.00|no       |      0|
|            1.05|no       |      0|
|            1.10|yes      |      1|
|            1.15|no       |      0|
|            1.20|no       |      0|
|            1.26|no       |      0|

When we plot this type of binary data, we see that observations are either of the two outcome possibilities:



![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic1.png)

As you can see in the plot, this type of data is best fit by an s-shaped curve instead of a line. And this is another difference between linear and logistic regressions.
 
## What does the logistic curve mean?



![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic2.png)

* It represents the *probability* of positive outcomes depending on predictors  
* As we move along the curve and our predictor values change, we go from 0 to 100% probability of our outcome  

## Aquatic ecology studies using logistic regressions  

- The distribution of gammarid species was predicted using logistic regressions, where current velocity was the most important factor explaining their distribution [(Peeters & Gardeniers, 1998)](https://onlinelibrary.wiley.com/doi/epdf/10.1046/j.1365-2427.1998.00304.x)  

- Foraging shift behaviour from the benthos to the water surface in brown trout (1 = surface prey consumed, 0 = no surface prey consumed) was predicted using fish length as a predictor in a logistic regression [(Sánchez-Hernández & Cobo, 2017)](https://cdnsciencepub.com/doi/full/10.1139/cjfas-2017-0021])

![[Amphipod Gammaridae](https://commons.wikimedia.org/wiki/File:Amphipod_Gammaridae_%288741971996%29.jpg); [Brown Trout, USFWS Mountain-Prairie](https://www.flickr.com/photos/usfwsmtnprairie/49860328703)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic_studies_example.jpg)


## What kind of predictors can we have in a logistic regression?

Just like in a linear regression, we can use continuous and/or categorical variables to make predictions. Here are some examples:

**Continuous variables**

+ Temperature  

+ Precipitation  

+ Water depth  

+ Nitrogen concentration  

**Categorical variables**  

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
                        "filamentous_Diatom", "mean_mixing_depth_temp", "NO2_NO3_ECCC1m")]
```


| Location | Season | Filamentous diatom biomass | Epilimnion temperat. | Nitrate/nitrate |
|:--------:|:------:|:--------------------------:|:--------------------:|:---------------:|
|   deep   |   2    |            0.00            |        21.79         |      2.50       |
|   deep   |   2    |            3.10            |        21.83         |      2.50       |
|    NE    |   1    |             NA             |        19.89         |      3.20       |
|   deep   |   1    |             NA             |        19.71         |      3.20       |
|    NE    |   1    |             NA             |        13.90         |      2.54       |
|   deep   |   1    |           287.18           |        16.05         |      2.54       |

Let's consider that *filamentous diatom* is our response variable of interest, as this food source is hard for zooplankton to consume. We will look at *epilimnion temperature* as a potential explanatory variable.

First, we will create a new column to describe presence or absence of filamentous diatoms.

We can do that with a function called **ifelse** to label all observations where measurements were greater than zero as "present", and all observations where measurements were equal to zero as "absent":


```r
filam_diatom$filam_presence <- ifelse(filam_diatom$filamentous_Diatom > 0, "present", "absent")
```

Now we format this column as **factor** and ensure the reference group ("absent") is the first to be shown:


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

Run model using **glm** function and family **binomial**


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
##   (197 observations deleted due to missingness)
## AIC: 76.195
## 
## Number of Fisher Scoring iterations: 5
```


So we can see that our p-value for the epilimnion temperature predictor is smaller than 0.05. This suggests that there is a statistically significant relationship between temperature and the presence of filamentous diatoms.

Let's see what each component of the model result summary means:

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic_model_output.jpg)


We are now ready for the best part: plotting model predictions  

First, we save the regression coefficients:

```r
coefficients <- round(as.data.frame(summary(model)$coefficients),2)
```

And we plot the actual data and the model predictions:

```r
# Convert "present" and "absent" to 1 and 0
presence_numeric_filam <- ifelse(filam_diatom$filam_presence == "present", 1, 0)

plot(filam_diatom$mean_mixing_depth_temp, presence_numeric_filam, pch = 16,
     main = "Filamentous diatom presence",
     xlab = "Epilimnion temperature (\u00B0C)", ylab = "Predicted probability", 
     cex.axis = 1.3, cex.lab = 1.3, ylim = c(0, 1), lwd = 2)
curve(exp(coefficients[1, 1] + coefficients[2, 1] * x)/(1 + exp(coefficients[1, 1] + coefficients[2, 1] * x)), 
      add = TRUE, col = 2, lwd = 3)
```

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/RIntro/logistic3.png)


### Creating your logistic model 

Now it's your turn! Run this next logistic model using nitrite/nitrate as a potential predictor, and filamentous diatoms as the response variable again.

#### Try it now {-}

Use the same dataset "filam_diatom" to run a new logistic model. Copy the code above, but replace the predictor temperature ("mean_mixing_depth_temp") with nitrite/nitrate ("NO2_NO3_ECCC1m"). How well does this explanatory variable predict the probability of finding filamentous diatom?



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
|Jan-1-2024 |station-1 |             14|           69|
|Jan-1-2024 |station-2 |             97|           80|
|Jan-1-2024 |station-3 |             91|            2|

In this case, instead of considering each individual as "living" or "dead", you should calculate the proportion of living organisms *per replicate* like this:
    

```r
example_independence$proportion <- round(example_independence$living_daphnia/(example_independence$living_daphnia+example_independence$dead_daphnia),2)
# the "round" function ensures we have 2 decimals in our proportion values
```


|date       |location  | living_daphnia| dead_daphnia| proportion|
|:----------|:---------|--------------:|------------:|----------:|
|Jan-1-2024 |station-1 |             14|           69|       0.17|
|Jan-1-2024 |station-2 |             97|           80|       0.55|
|Jan-1-2024 |station-3 |             91|            2|       0.98|

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

See how we need to format the column as factor for our model to run nicely:


```r
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
