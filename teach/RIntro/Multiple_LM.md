# Multiple Linear Regression Model

## Introduction 

### What is multiple linear regression model

Multiple linear regression model allows using multiple predictor variables to predict a single response variable, as in this equation:  

$$\hat{y}=\hat{a}x_1+\hat{b}x_2+\hat{c}x_3...+\hat{z}$$

It's basically an extension of the previously introduced single-variate linear regression model, both mathematically speaking and in the sense of building them in R.  

### Recipe for multiple linear regression model in R

To build and interpret a multiple linear regression model:

- First, we will start from **preparing data for building model**. We will select and check our variables of interests in [Data preparation]. The characteristics of our data might affect the subsequent model building and evaluation process.  

- **Once we prepared the data, we can start to build the actual model**. The standard R package **stats** provides the simplest way to do single and multiple linear regression model through the function `lm()`. We will introduce the detailed usage of this function for multiple linear regression model in [Model building]. 

- At the end, **we examine our model and analyze the presented relationships** between the predictors and the response. An entire section ([Model output]) will be dedicated in introducing ways to interpret the model output and to evaluate the model based on all the assumptions multiple linear regression model made. 

#### Try it now: {-}

*Before starting the coding process: There are two necessary packages readxl and car for this section. If you haven't loaded these packages, please load them now so they won't cause errors in the following sections*


```r
#Loading Packages
library("readxl")
library("car")
```

*Note: I hide the warnings from this code chunk because loading packages give out a lot of warnings. If you want to see those warnings, delete `warning=FALSE`. *

For this and following sections, we will be using 3 predictor variables (water level, dissolved inorganic carbon amount and bottom hypoxia) and 1 response variable (total zooplankton) from the Hamilton Harbour AOC project dataset. 

So, we need to separate our selected variables from the complete dataset: 


```r
#Select and combine variables of interests 
multi_data<-ham[,c(14,16,108,93)]
#Label each column of our new dataset
colnames(multi_data)<-c("waterlevel","DIC","bottomhypoxia","totalzoop")

#remove NAs
multi_data<-na.omit(multi_data)
```

## Data preparation

First, we want to determine the characteristics of the three predictor variables we have, most importantly, are they continuous or categorical? 

> **Continuous variable**: data that are measured and ordered. It can be any specific value within a certain numerical range.

For example: 

```r
table(multi_data$waterlevel)
```

```
## 
## 74.34 74.42  74.5 74.54 74.55 74.56 74.59  74.6 74.65  74.7 74.71 74.74 74.78 
##     2     2     4     6     3     4     3     6     4     8     4     4    10 
## 74.79 74.81 74.84 74.85 74.86 74.88  74.9 74.91 74.92 74.95 74.96 74.98 75.02 
##    10     7    11     5     6     4     4     6     2    12     4     4     8 
## 75.03 75.05 75.06 75.08 75.09  75.1 75.12 75.14 75.16 75.17 75.18 75.19 75.24 
##     4     4     4     1    12     2     7     5     6     4     2     8     2 
##  75.3 75.43 75.53 75.69  75.8 
##     4     1     2     2     4
```

> **Categorical variable**: data that is divided into categories with distinct label. These data can't be ordered or measured as continuous variables.

For example:

```r
table(multi_data$bottomhypoxia)
```

```
## 
##   n   y 
## 116 101
```

### Check data type

Because of the intrinsic differences between continuous and categorical variables, we always want to check whether our data is in the correct data type before proceeding to the next step. Sometimes the data is not read in as the correct data type, and other times data types got altered during previous data modification procedures. We can check data type easily using the `class()` function, for example: 


```r
class(multi_data$waterlevel)  
```

```
## [1] "numeric"
```

#### Try it now: {-}

Let's continue to check the other three columns of our data frame using the same code:


```r
#Use the class() function to check for the other columns: 
class()
```

The numeric variables are in their correct data type. If we ever want to reset them, we can set the data type to numeric using `as.numeric()`. For our categorical variables, we can transform them into groups/factors using `as.factor()`. 


```r
#Set bottom hypoxia column as "factor" data type using as.factor(model_name$variable_name)
multi_data$bottomhypoxia<-as.factor(multi_data$bottomhypoxia)
```
*Note: As you noticed, the `as.xxx()` format is used to transform data type directly in R. You can explore some other options on your own, such as as.character(), as.integer()....*

## Model building

Generating the multiple linear regression model itself is similar to the single variable model and is very simple once we prepared our data. Simply adding a + sign between predictor variables to include more than one variable in your model. So, instead of `lm(response ~ predictor, data = dataframe)`, we are now using `lm(response ~ predictor 1 + predictor 2 ..., data = dataframe)`

#### Try it now: {-} 

Let's try to include the two additional predictor variables `DIC` and `bottomhypoxia` in our model based on the previous single variate model: 


```r
#Modify the below single variate linear regression model and make it a multiple linear regression model: 
#Hint: start by adding a plus sign and another predictor after water level 
multi_model<-lm(totalzoop~waterlevel, data=multi_data)
```


## Model output

### Model assumptions

Just like the simple linear regression model, the multiple linear regression models come with similar assumptions:

1. The predictor variables and the response variable have a **linear relationship** since we are doing a linear regression model.

2. The model also assumed **normal distribution in residuals**.
    
3. **Homoscedasticity** that there exists equal variance in residuals. 

And the multiple predictors aspect in this model brings in one more assumption: 

4. **No multicollinearity**. The independent variables should be independent of each other. 

### Evaluate model assumptions

I found it much easier to build the model first then check the assumptions as we can utilize these auto-generated model diagnosis plots from the `lm()` function. Just like in the simple linear regression model, these plots can be called by simply run `plot(model_name)`. Let's try to do this: 

#### Try it now: {-}


```r
#Access the diagnosis plots that are auto-generated from the lm() function
#Using plot(model_name): 
plot()
```


You should see four diagnosis plots generated:  *Residuals vs Fitted plot*, *Normal Q-Q plot*, *Scale-Location plot*, and *The Residuals vs Leverage plot*. As in the simple linear regression model, these plots can help us determine whether the first three of the four assumptions are met for our model. 

The last assumption, **Multicollinearity**, can be checked by the following several ways depending on the data characteristics: 

- If we only have continuous variables in our dataset, we can check this using correlation matrix through `cor()` or/and `corrplot()`, or variance inflation factor using `vif()` from the *car* package, or`vifcor()` and `vifstep()` from the *usdm* package.  

- If we have both continuous and categorical variables in our dataset, the `vif()` function will automatically detect our categorical variables and compute us the generalized vifs.

#### Try it now: {-}

```r
# Let's use vif(model_name) to calculate vif for our variables
vif()
```


The result for our variables should look like this: 


```
##    waterlevel           DIC bottomhypoxia 
##      1.577214      1.780762      1.165722
```

Our variables look good. If multicollinearity is found (vif > 5 is a common threshold to use for indicating a problematic amount of multicollinearity), we can try to remove it by identify and remove the predictor variable that is causing troubles. 

### Output interpretation

To access model output, the easiest way is to call the `summary()` method just like the simple linear regression model:

```r
summary(multi_model)
```

```
## 
## Call:
## lm(formula = totalzoop ~ waterlevel + DIC + bottomhypoxia, data = multi_data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -479.49 -169.14  -65.33   79.96 2158.84 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    -1053.213   6693.092  -0.157 0.875112    
## waterlevel         9.476     90.954   0.104 0.917119    
## DIC               27.790      7.884   3.525 0.000519 ***
## bottomhypoxiay   -48.853     40.968  -1.192 0.234401    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 278.8 on 213 degrees of freedom
## Multiple R-squared:  0.119,	Adjusted R-squared:  0.1066 
## F-statistic: 9.595 on 3 and 213 DF,  p-value: 5.717e-06
```

The interpretation of the model result is the same as in the simple linear regression model. For categorical variables, the significance level is calculated against a chosen *baseline* category. In this case, the *n* category in bottom hypoxia variable is the baseline category.  

Unlike the single variate model, you can compare the coefficients and significance of multiple predictors and decide on whether you want to exclude some of the variables in your final model. In this case, DIC seems to be the most significant variable and we might be able to get a similarly accurate model from this single predictor.

## What could go wrong? 

- Check carefully whether the values in your data set are in their correct data types, especially for the categorical variables if you have any. 

- Be careful with the *comma ,* and *tilde ~* symbols when you are dealing with functions in R. They represent opposite positions of the independent and dependent variables. 

- Always check the model assumptions to see if linear regression model is indeed the appropriate model to use. 

## References and Resources

Other resources on introductions to multivariate linear regression model in R:  
https://www.datacamp.com/tutorial/multiple-linear-regression-r-tutorial  
https://bookdown.org/jimr1603/Intermediate_R_-_R_for_Survey_Analysis/regression-model.html#multiple-linear-regression  
https://library.virginia.edu/data/articles/getting-started-with-multivariate-multiple-regression  
https://rpubs.com/bensonsyd/385183  

If you want to learn more about plotting prettier plots for presentation purposes, check the *ggplot2* package:

https://ggplot2.tidyverse.org/

If you want to learn more about the *dummy coding* process in lm() function that treat categorical variables, check the `contrasts()` function. 
