

  
# Linear regression



## Learning outcomes
  * Understand the definition and application of a linear regression
  * Understand the assumptions of a linear regression and how to evaluate these with diagnostic plots 
  * Interpret the results of a linear regression 
  * Create and interpret a raw data plot with a regression line

### Introduction 

  A linear model is used when you want to test a prediction of correlation between an independent (or predictor) variable and a dependent (or response) variable (Phillips, 2018). For example, for our Hamilton Harbour data, we will be testing for a correlation between water level (our independent variable) and total zooplankton (our dependent variable) counted in the net grab. 

### Data import & packages

``` r
#install.packages("readxl")
library("readxl")
```

```
## Warning: package 'readxl' was built under R version 4.4.1
```

``` r
# xlsx files
ham<- read_excel("ind dates flat all parameters Hamilton only FOR Kim.xlsx")
```

### Linear regression  using water level and total zooplankton

``` r
# changing the column name to one that is easier to use
colnames(ham)[colnames(ham) == 'water level'] <- 'waterlevel'
# running the linear regression of water level and total zooplankton
waterlzoo.lm<- lm(waterlevel~total.zoop, ham)
# getting the results using the summary() function
summary(waterlzoo.lm)
```

```
## 
## Call:
## lm(formula = waterlevel ~ total.zoop, data = ham)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.75082 -0.18579 -0.02821  0.14399  0.98481 
## 
## Coefficients:
##              Estimate Std. Error  t value Pr(>|t|)    
## (Intercept) 7.487e+01  1.659e-02 4511.728  < 2e-16 ***
## total.zoop  2.537e-04  3.189e-05    7.954 1.08e-14 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2986 on 537 degrees of freedom
##   (203 observations deleted due to missingness)
## Multiple R-squared:  0.1054,	Adjusted R-squared:  0.1037 
## F-statistic: 63.26 on 1 and 537 DF,  p-value: 1.078e-14
```
## What does this output tell us? 

  The *call* in the summary output displays the call that was given to R, our linear regression coding using the lm() function. The *residuals* show the difference between the observed versus the expected values for the linear regression analysis. Under *coefficients*, the *estimate* shows the average change in value of our dependent variable (total zooplankton) when there is a 1 unit increase in the independent variable (water level). The *standard error* is a value that represents any uncertainty with the *estimate* value, where the *t value* shows the difference between these two values. The *p-value* is arguably the most important in this output. It indicates the level of significance of the relationship between the independent (water level) and dependent (total zooplankton) variables. Aka whether the value of the independent variable significantly impacts the value of the dependent variable. A *p-value* smaller than 0.05 is *generally* considered to represent a statistically significant relationship, whereas a *p-value* larger than 0.05 is *generally* considered to represent a statistically insignificant relationship between the independent and dependent variable. 

### What does the summary output tell us about the relationship between water level and total zooplankton?

## What are the assumptions of a linear regression? 
  * There is a linear relationship between the independent and dependent variable (Statistics solutions, 2024).
  * The residuals are normally distributed (Statistics solutions, 2024). 
  * The variance of the residuals should be consistent across all the values of the independent variable (Statistics solutions, 2024). 
  * Each observation is independent of one another (there is no significant correlation between the independent variable values) (Statistics solutions, 2024). 

## How do you evaluate the assumptions of a linear regression?

  You can evaluate the assumptions of a linear regression by creating diagnostic plots. These look at the residuals of the linear regression, that were shown using the summary() function above, to determine if the linear model is appropriate for the data (the data does not violate any assumptions) (Statistics solutions, 2024). This will create 4 diagnostic plots: residuals versus leverage, scale-location, Q-Q residuals and residuals versus fitted values. 

### Let's try...

``` r
# plotting diagnostic plots
plot(waterlzoo.lm)
```

![](HHworkshop_files/figure-html/unnamed-chunk-3-1.png)<!-- -->![](HHworkshop_files/figure-html/unnamed-chunk-3-2.png)<!-- -->![](HHworkshop_files/figure-html/unnamed-chunk-3-3.png)<!-- -->![](HHworkshop_files/figure-html/unnamed-chunk-3-4.png)<!-- -->

### 1. 
The *residuals versus fitted plot* determines if the residuals exhibit non-linear behaviour (Statistics solutions, 2024). If the red line roughly follows the horizontal line on the plot, the residuals are showing linear behaviour (Statistics solutions, 2024). In this case, the red line follows the horizontal line very closely. We can determine then that the linear model is suitable for this dataset. 

### 2. 
The *Q-Q plot* evaluates our second assumption; the residuals are normally distributed (Statistics solutions, 2024). If the points on the plot follow the diagonal line, then the residuals are normally distributed (Statistics solutions, 2024). In this case, the points fall roughly on the diagonal line, with some variation towards the upper end. 

### 3.
The *Scale-Location* plot is used to determine our third assumption; the variance of the residuals should be consistent across all the values The he independent variable (Statistics solutions, 2024). This is also called homoscedasticity (Bobbitt, 2021). In this case, the line is roughly horizontal along the plot, so the variance of residuals is likely consistent. 

### 4.
The *Residuals versus Leverage* plot displays any influential points in the dataset compared to Cook's distance (Bobbitt, 2021). Ideally, the points should fall close to the '0' line on the plot with little variation. Any points that fall past the line indicating Cook's distance are considered strongly influential points (Bobbitt, 2021). In this case, we have one point that falls past the line of Cook's distance (point 282), indicating that we have one strongly influential point in our dataset. 

## How can we plot this linear regression? 


``` r
# create a plot with water level and total zooplankton
# use xlab(), ylab() and main() to put titles on the plot
plot(ham$waterlevel, ham$total.zoop, xlab="Water level (m)", ylab="Total zooplankton collected", main="Relationship between water level and total zooplankton")
# add regression line to the plot using the abline() function
abline(waterlzoo.lm, col="red")
```

![](HHworkshop_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

In this case, water level does not appear to have a large impact on the amount of zooplankton collected. The regression, shown by the red line on the plot, shows a horizontal pattern between water level (m) and total zooplankton collection. 



## References and resources
  Assumptions of multiple linear regression analysis. Statistics Solutions. (2024, April 17). https://www.statisticssolutions.com/free-resources/directory-of-statistical-analyses/assumptions-of-linear-regression/ 
  
  Bobbitt, Z. (2021, July 23). How to interpret diagnostic plots in R. Statology. https://www.statology.org/diagnostic-plots-in-r/ 

  Phillips, N. D. (2018, January 22). Yarrr! The Pirate’s Guide to R. YaRrr! The Pirate’s Guide to R. https://bookdown.org/ndphillips/YaRrr/ 
    * Check out chapter 15 on linear regression analysis 
    
## Alternative resource:

  Another way to evaluate the assumptions of a linear regression is to compare fitted values (theoretical values of the dependent variable that are predicted by the model, assuming linearity) and the observed values of the dependent variable in a plot (Phillips, 2018). If the model fitted values forms a diagonal line with the observed values of the dependent variable, then the linear model fits the data well, and the assumptions of the linear model are met (Phillips, 2018). See Phillips resource for more details and sample coding. 


