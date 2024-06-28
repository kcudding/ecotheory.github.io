---
title: "Multi-variate Linear Regression Model"
author: "Xuewen"
date: "2024-06-20"
output: 
  html_document: 
    toc: true
    toc_float:
      collapsed: false
    toc_depth: 4
    theme: lumen
    keep_md: true
---



# 0. Objectives

In the following sections, you will learn about:

- understand the concept of multi-variate linear regression model

- prepare and evaluate data for multi-variate linear regression model

- build multi-variate linear regression model

- model output interpretation and evaluation

# 1. Introduction 

## 1.1 What is Multivariate Linear Regression Model

Multi-variate linear regression model allows using multiple predictor variables to predict a single response variable, as in this equation:  

$$\hat{y}=\hat{a}x_1+\hat{b}x_2+\hat{c}x_3...+\hat{z}$$

It's basically an extension of the previously introduced single-variate linear regression model, both mathematically speaking and in the sense of building them in R.  

## 1.2 Recipe for multi-variate model in R

To build and interpret a multi-variate model:

- First, we will start from **preparing data for building multi-variate model**. We will select and check our variables of interests in [2. Data preparation]. The characteristics of our data might affect the subsequent model building and evaluation process.  

- **Once we prepared the data, we can start to build the actual model**. The standard R package **stats** provides the simplest way to do single and multi-variate linear regression model through the function `lm()`. We will introduce the detailed usage of this function for multi-variate linear regression model in [3. Model building]. 

- At the end, **we examine our model and analyze the presented relationships** between the predictors and the response. An entire section ([4. Model output]) will be dedicated in introducing ways to interpret the model output and to evaluate the model based on all the assumptions multi-variate linear regression model made. 

## 1.3 Loading data

Let's load all the necessary packages before proceeding to the actual modeling process. For the following sections, there are only two necessary packages *readxl* and *car*. If you have not installed these package before, please install it using `install.package()`. For example: `install.package(readxl)`


```r
#Loading Packages
library("readxl")
library("car")
```

```
## Loading required package: carData
```

*Note: I hide the warnings from this code chunk because loading packages give out a lot of warnings. If you want to see those warnings, delete `warning=FALSE`. *

For this and following sections, we will be using 3 predictor variables (water level, dissolved inorganic carbon amount and bottom hypoxia) and 1 response variable (total zooplankton) from the Hamilton Harbour AOC project dataset. 

So, we need to read the dataset and separate our selected variables from the complete dataset first: 


```r
#Loading Data
#Read the dataset using read_excel()
ham <- read_excel("ind dates flat all parameters Hamilton only FOR Kim.xlsx")
#Select and combine variables of interests 
multi_data<-as.data.frame(cbind(ham$`water level`,ham$DIC_ECCC1m, ham$`bottom hypoxia (Y/N)`,ham$total.zoop))
#Label each column of our new dataset
colnames(multi_data)<-c("waterlevel","DIC","bottomhypoxia","totalzoop")

#remove NAs
multi_data<-na.omit(multi_data)
```

# 2. Data preparation

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

Because of the intrinsic differences between continuous and categorical variables, we always want to check whether our data is in the correct data type before proceeding to the next step. Sometimes the data is not read in as the correct data type, and other times data types got altered during previous data modification procedures. We can check data type easily using the `class()` function, for example: 


```r
class(multi_data$waterlevel)  
```

```
## [1] "character"
```

Oops, it seems we do need to modify the data type of our dataset. Let's continue to check the other three columns of our dataframe: 


```r
class(dataframe$column_name)
```

We can set the data type back into numeric for our continuous variables using `as.numeric()`. For our categorical variables, we can transform them into groups/factors using `as.factor()`. I also transformed them into binary *dummy variables* that are required for some functions to accommodate categorical variables. 


```r
#Set numeric data type
multi_data$waterlevel<-as.numeric(multi_data$waterlevel)
multi_data$DIC<-as.numeric(multi_data$DIC)
multi_data$totalzoop<-as.numeric(multi_data$totalzoop)
#Transform bottom hypoxia variable to 0 and 1 instead of n and y
multi_data$bottomhypoxia <- replace(multi_data$bottomhypoxia, multi_data$bottomhypoxia=="n", 0) 
multi_data$bottomhypoxia <- replace(multi_data$bottomhypoxia, multi_data$bottomhypoxia=="y", 1) 
#Set factor data type
multi_data$bottomhypoxia<-as.factor(multi_data$bottomhypoxia)
```

*Note: As you noticed, the `as.xxx()` format is used to transform data type directly in R. You can explore some other options on your own, such as as.character(), as.integer()....*

# 3. Model building

Continuous variables work smoothly in multi-variate regression model. For categorical variable data, `lm()` function has embedded an automatic *dummy coding* process that will transform categorical values into n-1 groups of 0s and 1s. *(You can check `contrast()` function to learn more about the dummy coding process.)* 

Generating the model itself is similar to the single variable model and is very simple once we prepared our data. Simply adding a + sign between predictor variables to include more than one variable in your model. So, instead of `lm(response ~ predictor, data = dataframe)`, we are now using `lm(response ~ predictor 1 + predictor 2 ..., data = dataframe)`

Let's try to include the two additional predictor variables `DIC` and `bottomhypoxia` in our model based on this single variate model: 


```r
multi_model<-lm(totalzoop~waterlevel, data=multi_data)
```

It should be something like this: 


```r
multi_model<-lm(totalzoop~waterlevel+DIC+bottomhypoxia, data=multi_data)
```

# 4. Model output

## 4.1 Model assumptions

Just like the simple linear regression model, the multi-variate linear regression models come with similar assumptions:

1. The predictor variables and the response variable have a **linear relationship** since we are doing a linear regression model.

2. The model also assumed **normal distribution in residuals**.
    
3. **Homoscedasticity** that there exists equal variance in residuals. 

And the multi-variate feature brings in one more assumption: 

4. **No multicollinearity**. The independent variables should be independent of each other. 

## 4.2 Evaluate model assumptions

I found it much easier to build the model first then check the assumptions as we can utilize these auto-generated model diagnosis plots from the `lm()` function. These plots can be called by simply run:  

```r
plot(multi_model)
```

![](Multivariate_LM_files/figure-html/model plot-1.png)<!-- -->![](Multivariate_LM_files/figure-html/model plot-2.png)<!-- -->![](Multivariate_LM_files/figure-html/model plot-3.png)<!-- -->![](Multivariate_LM_files/figure-html/model plot-4.png)<!-- -->

1. *Residuals vs Fitted plot* checks **linearity assumption**. If the red line, represents residual distribution, in the plot align with the dashed black line (horizontal at zero), it indicates linear relationship exists in the model.  
    + we can also test linear relationship by simply do a scatter plot between each predictor variable and the response variable, using `plot()`. For example:
    
    
    ```r
      plot(multi_data$totalzoop~multi_data$DIC)
    ```
    
    ![](Multivariate_LM_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
    
      we can add a linear regression line by using `abline()` and a single linear model between these two variables using `lm()`.
      
    
    ```r
      plot(multi_data$totalzoop~multi_data$DIC)
      abline(lm(totalzoop~DIC,data=multi_data))
    ```
    
    ![](Multivariate_LM_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
    
      The R squared of the linear regression line can be extracted and evaluate whether the relationship is linear: 
      
    
    ```r
      summary(lm(totalzoop~DIC,data=multi_data))$r.squared
    ```
    
    ```
    ## [1] 0.1131415
    ```
2. *Normal Q-Q plot* checks the **normality of residuals** assumption. If the standardized residuals follow the straight dashed line, then the assumption is fulfilled.  
    + Another simpler way to visualize and check it is to plot histogram using (`hist()`) model residuals.
    
    ```r
      hist(multi_model$residuals)
    ```
    
    ![](Multivariate_LM_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

3. *Scale-Location plot* is used to check the **homoscedasticity**. If the residuals have equal variance, the standardized will spread randomly with the red line approximate horizontal line.  
    + If heteroscedasticity is found, we can try to eliminate it by doing non-linear data transformation or adding quadratic terms. 
      
- *The Residuals vs Leverage plot is not used to check any of the model assumptions. However, it is still important and worth checking as it is used to identify extreme values that can cause a huge influence to our analysis of the model output based on Cook's distance. Extreme values can be identified as any of the values are outside of the dashed lines. *

4. **Multicollinearity** can be checked using several different ways: 
    + If we only have continuous variables in our dataset, we can check this using correlation matrix through `cor()` or/and `corrplot()`, or variance inflation factor using `vif()` from the *car* package, or`vifcor()` and `vifstep()` from the *usdm* package.  
    + If we have both continuous and categorical variables in our dataset, we need to transfer our categorical variables into dummy variables and viewing them as a single entity. We have already done that in [2. Data preparation]. The `vif()` function will automatically detect our categorical variables and compute us the generalized vifs.
    
    ```r
    vif(multi_model)
    ```
    
    ```
    ##    waterlevel           DIC bottomhypoxia 
    ##      1.577214      1.780762      1.165722
    ```
    + Our variables look good. If multicollinearity is found (vif > 5 is indicating problematic amount of multicollinearity), we can try to remove it by identify and remove the predictor variable that is causing troubles. 

## 4.3 Output interpretation

To access model output, the easiest way is to call the `summary()` method just like the single variate linear regression model:

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
## bottomhypoxia1   -48.853     40.968  -1.192 0.234401    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 278.8 on 213 degrees of freedom
## Multiple R-squared:  0.119,	Adjusted R-squared:  0.1066 
## F-statistic: 9.595 on 3 and 213 DF,  p-value: 5.717e-06
```
However, unlike the single variate model, you can compare the coefficients and significance of multiple predictors and decide on whether you want to exclude some of the variables in your final model. In this case, DIC seems to be the most significant variable and we might be able to get a similarly accurate model from this single predictor 

# 5. What could go wrong? 

- Check carefully whether the values in your data set are in their correct data types, especially for the categorical variables if you have any. 

- Be careful with the *comma ,* and *tilde ~* symbols when you are dealing with functions in R. They represent opposite positions of the independent and dependent variables. 

- Always check the model assumptions to see if linear regression model is indeed the appropriate model to use. 

# References and Resources

Other resources on introductions to multivariate linear regression model in R:  
https://www.datacamp.com/tutorial/multiple-linear-regression-r-tutorial  
https://bookdown.org/jimr1603/Intermediate_R_-_R_for_Survey_Analysis/regression-model.html#multiple-linear-regression  
https://library.virginia.edu/data/articles/getting-started-with-multivariate-multiple-regression  
https://rpubs.com/bensonsyd/385183  

If you would like to have prettier plots for presentation purposes, check the *ggplot2* package:
https://ggplot2.tidyverse.org/
