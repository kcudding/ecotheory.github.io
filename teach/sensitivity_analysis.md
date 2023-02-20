---
title: "Sensitivities, elasticities, and management applications"
author: "Debora"
date: "2023-02-10"
output:
  html_document:
    toc: true
    toc_depth: 5
    number_sections: true
    toc_float:
      collapsed: false
      smooth_scroll: false
    keep_md: yes
---



## Sensitivities, elasticities, and management applications

Remember how populations which achieved a stable stage distribution (SSD) maintain a constant proportion of organisms in each stage? Each of these stages contributes differentially to the overall population, which is indicated by specific reproductive values. Thus, we can expect that vital rates for a stage with more individuals and/or larger reproductive values will have a greater impact to lambda growth rates. **Sensitivity and elasticity analyses** are performed to determine the importance of each vital rate (survival or reproduction) within stages to the growth of a given population. While **sensitivities** represent absolute differences, **elasticities** enable a proportional comparison between vital rates. The theory and mathematical notations used in this section are based on Mills (2012).

### Sensitivity

How sensitive is population growth to small changes in different vital rates? We can investigate this by looking at how $\lambda$ is impacted (or how sensitive it is) following a very small change in a vital rate within a given population matrix, considering that all of the other matrix elements remain unchanged. This is called analytical sensitivity, which is represented by the following mathematic formulation:

$$a_{i,j} = \frac{\partial\lambda}{\partial a_{i,j}} = \frac{v_{i}*w_{j}}{\sum_{k=1}{(v_k*w_k)}}$$
Where:
a(i,j) = a given matrix element  
$\partial$ = partial derivative denoting a very small change applied to rates while all other variables are held constant  
$\lambda$ = rate of population change  
v(i) = reproductive value  
w(j) = stable stage distribution (SSD) value  
v(k) = reproductive value for the last stage class  
w(k) = stable stage distribution (SSD) value for the last stage class  

### From sensitivity to elasticity

Because the sensitivity analysis is based in absolute values, changes applied to small values have a disproportional effect in comparison to changes to larger values, which can make comparisons problematic. A solution is considering vital rate sizes and making sensitivities proportional to them. Such rescaled sensitivites are then called **elasticities** and can be represented by:

$$\text{Elasticity of }a_{i,j} = \text{(sensitivity of }a_{i,j})*\frac{a_{i,j}}{\lambda}$$

### Component sensitivity and elasticity

This type of analysis is applicable for the following situations:

* When both survival and reproduction rates affect a given matrix element

* When a certain vital rate impacts more than one matrix element

Component sensitivities and elasticities can be obtained by changing the $\lambda$ SSD by a small amount (eg., 0.01 in the equation below), obtaining the resulting matrix, and obtaining the new  $\lambda$ SSD for this changed matrix. Then, you proceed with this calculation for a given vital rate x:

$$x = \frac{\lambda_{x+0.01}-\lambda_{original}}{0.01}$$

And for the elasticity:

$$\text{Component elasticity of vital rate x} = \text{(component sensitivity of vital rate x) }*\frac{x}{\lambda_{original}}$$

### Practicing the calculation of sensitivities and elasticities

What is the importance of the survival of young individuals vs. adult reproduction for a given population?


```r
# Let's say that 2 given vital rates of a hypothetical population are:
young_surv <- 0.3
adt_reprod <- 30

# These rates can be visualized in the following matrix:
population0 <- matrix(c(0,40,adt_reprod,young_surv,0,0,0,0.5,0.9),nrow=3,byrow=T )
population0
```

```
##      [,1] [,2] [,3]
## [1,]  0.0 40.0 30.0
## [2,]  0.3  0.0  0.0
## [3,]  0.0  0.5  0.9
```

```r
# And we want to know the effects of a 10% change (or another observed variance)
# in these vital rates
young_surv1 <- 0.3+0.3*0.1
adt_reprod1 <- 30+30*0.1

# These changes are now incorporated in our original matrix
# This is the scenario for a change in young survival:
population1_surv <- matrix(c(0,40,adt_reprod,young_surv1,0,0,0,0.5,0.9),nrow=3,byrow=T )
population1_surv
```

```
##      [,1] [,2] [,3]
## [1,] 0.00 40.0 30.0
## [2,] 0.33  0.0  0.0
## [3,] 0.00  0.5  0.9
```

```r
# And this is the scenario for a change in adult reproductive rates:
population1_reprod <- matrix(c(0,40,adt_reprod1,young_surv,0,0,0,0.5,0.9),nrow=3,byrow=T )
population1_reprod
```

```
##      [,1] [,2] [,3]
## [1,]  0.0 40.0 33.0
## [2,]  0.3  0.0  0.0
## [3,]  0.0  0.5  0.9
```


```r
# Let's now obtain the original lambda
lambda0 <- eigen(population0)$value[1]
lambda0
```

```
## [1] 3.689598
```

```r
# And the changed lambdas
lambda_surv <- eigen(population1_surv)$value[1] # For a change in young survival
lambda_surv
```

```
## [1] 3.856703
```

```r
lambda_reprod <- eigen(population1_reprod)$value[1] # Change in adult reproduction
lambda_reprod
```

```
## [1] 3.709685
```


```r
# And here is the sensitivity we get by using the equation we have just seen
sensitivity_surv <- (lambda_surv-lambda0)/(young_surv1-young_surv)
sensitivity_surv
```

```
## [1] 5.570173
```

```r
sensitivity_reprod <- (lambda_reprod-lambda0)/(adt_reprod1-adt_reprod)
sensitivity_reprod
```

```
## [1] 0.006695594
```

```r
# We now scale the sensitivity to get the elasticity
elasticity_surv <- sensitivity_surv*(young_surv/lambda0)
elasticity_reprod <- sensitivity_reprod*(adt_reprod/lambda0)
elasticity_surv
```

```
## [1] 0.4529089
```

```r
elasticity_reprod
```

```
## [1] 0.05444165
```

```r
# If we do this for all vital rates, we can them compare them to understand their
# relative impact to population growth
```
By looking at the elasticities of young survival (0.45) and adult reproduction (0.05), we conclude that young survival is more important to the growth of this hypothetical population.

### Advantages of elasticities as compared to sensitivites

Elasticities are useful in population biology studies due to the following properties:

* Elasticities for several vital rates can be directly compared within and between populations

* The sum of elasticities of all matrix elements equals 1

* The sum of 2 or more elasticities enable analyzing the grouped effect of vital rates

* General life history patterns can be considered when analyzing elasticities. For instance, long-lived species tend to have a higher elasticity for survival in comparison with reproduction. Thus, when observing significant changes in population growth rates, adult survival elasticities should be considered first.

### Limitations of sensitivity and elasticity analyses

* Assumption that populations have a stable stage distribution

* They are not enough to describe vital rate dynamics under natural or management conditions: this is because high and low sensitivities and elasticities need to be considered together with the variance of vital rates. For example, a given vital rate with a high elasticity but low variance may be less important than another vital rate with a low elasticity but which changes a lot.

### Management applications 

* In the broad sense, a sensitivity analysis encompasses several analytical and simulation techniques 

* Such techniques include sensitivity and elasticity calculations together with other important management aspects, such as the joint consideration of vital rate variance and sensitivity/elasticity analyses

* Past and future management actions can be compared in terms of their impacts to vital rates, which ultimately affects population density

* One of the first studies which applied sensitivity analysis found that management strategies for endangered loggerhead sea turtles should focus on young adults in the ocean more than hatchlings moving from the sand to the sea. This is because elasticity values for young adult survival are greater than elasticities for eggs and hatchlings (Crouse, Crowder, & Caswell, 1987). Such findings contribute to the choice and application of successful management strategies which result in population growth of endangered species. 

![© T. Moore, Loggerhead Turtle, https://commons.wikimedia.org/wiki/File:Loggerhead_Turtle_%285884715439%29.jpg, [Public use provided by the National Institute of Standards and Technology (NIST), US](https://www.nist.gov/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/turtle.jpg) 

### Sensitivity analysis methods

#### Manual perturbation

* Compare $\lambda$ SSD after manually changing vital rates

* Two or more vital rates are compared when changed by the same amount or different proportions

* Example: compare a 5% change in adult survival vs. a 10% change in fecundity

* In addition to vital rates, this method allows assessing factors like density dependence, immigration and emigration, age structure, and endogamy (breeding of related individuals resulting in offspring performance reduction)

#### Analytical sensitivity and elasticity analysis

* Comparing different vital rates in terms of how much a small and equal change in each of them affects population growth

* Used to analyze a mean matrix, when little information on population structure or vital rate variation is known

* This type of analysis using a mean matrix can be misleading, as transient dynamics following management are not considered 

* In this case, phenomena such as population inertia may occur, in which growth occurs in opposite trends as the predicted by asymptotic elasticity as a result of a large change to a vital rate with a high elasticity

* Sensitivities and elasticities can be calculated for transients and fully stochastic scenarios

#### Example of analytical and sensitivity analysis: ring-necked pheasant populations

* Ring-necked pheasants (*Phasianus colchicus*) have been well studied in the context of wildlife management and research due to their original abundance in North America, subsequent decline in the 1950s due to agricultural practices intensification, and posterior population recovery following conservation strategies

![](https://raw.github.com/kcudding/kcudding.github.io/main/teach/paper1.png)

* This sensitivity analysis found that vital rates related to **young individuals** are the most important factors affecting the growth of the two ring-necked pheasants populations analyzed in the study

* The vital rates considered in this study were defined in the following matrix:


```r
peasants <- matrix(c("Fertility_hatch","Fertility_age_1_onward", "Survival_hatch_age_1", "Survival_age_1_onward"),nrow=2,byrow=T )
peasants
```

```
##      [,1]                   [,2]                    
## [1,] "Fertility_hatch"      "Fertility_age_1_onward"
## [2,] "Survival_hatch_age_1" "Survival_age_1_onward"
```
In this matrix, fertility is the multiplication of the reproductive rate and the amount of hatched chicks per adult which survived the year. This simple  2x2 matrix considers two age stages (hatchlings and adults starting at 1 year onward), as an analysis performed with additional stages did not yield different results in terms of adult survival and reproduction.  

![(left) © rawpixel, Hatchlings, https://www.rawpixel.com/search?page=1&similar=5920376&sort=curated&topic_group=_topics, [Creative Commons CC0 1.0 Universal license](https://creativecommons.org/publicdomain/zero/1.0/); (right) © Evelyn Simakv, Ring-necked pheasant (*Phasianus colchicus*), https://commons.wikimedia.org/wiki/File:Ring-necked_pheasant_%28Phasianus_colchicus%29_-_geograph.org.uk_-_775046.jpg, [creative commons CC BY-SA 2.0 license](https://creativecommons.org/licenses/by-sa/2.0/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/peasants.png)

* The sensitivity analysis found that the most important vital rates for these populations are related to the first age stage for this population of peasants, which correspond to their first year of life

* This is because this is a short-lived bird, and reproduction events start taking place during the first age stage

* While the sensitivity for *survival* had the greatest values, an elasticity analysis showed that *reproduction* is proportionally more important to population growth

* The authors recommend wildlife managers to focus on nesting cover and vegetation specific for young peasants during the spring, and winter protection for females

* Although this study created both deterministic and stochastic projection matrices, the sensitivity analysis was performed based on the deterministic matrix

#### Analytical sensitivity and elasticity & variance in vital rates

* The extent to which a given vital rate varies needs to be considered together with the analysis of elasticities

* A high elasticity and low variation in a vital rate may make it less important to population growth than another vital rate characterized by a low elasticity but a great variability

* An example is juvenile survival for several species: even if a low elasticity is found for this vital rate, it may be more variable than vital rates for adults, as juveniles have more mortality due to predation, 
poor conditions, and density-dependent factors

* Mean matrices are not appropriate for this type of analysis, as it requires knowing how much vital rates change in nature or under management and how this change affects population growth

#### Life-stage simulation analysis: method 1

* Uses techniques from both the analytical sensitivity and elasticity analysis and the manual perturbation

* Finds the most important vital rates impacting population growth based on mean rates and on their variation

* A given realistic change to averages and variances in field-collected rates is used to simulate several potential future scenarios

* Vital rate correlations and vital rate distribution functions are specified

* Several matrices are built using the vital rates specified in the distribution function

* $\lambda$ SSD can be calculated for each matrix (What is the probability of this population to increase in time?)

* How similar is the rating of elasticities across replicates (or matrices)?

* To include stochasticity, random vital rates can be used and $\lambda$S can be calculated instead of $\lambda$ SSD

#### Life-stage simulation analysis: method 2

* $\lambda$ values are regressed against each vital rate (for each replicate), considering that all other vital rates are also changing at the same time

* Coefficient of determination (R^2) is corresponds to how much variation in population growth is explained by variation in that specified vital rate

* R^2 values sum to one when analysis considers mean effects and interactions

* Slope of line represents the analytical sensitivity; if using log-transformed data, the slope corresponds to the elasticity

* R^2 is a function of analytical sensitivity and vital rate variance

#### Example of life-stage simulation analysis

Paper: Mating system, population growth, and management scenario for Kalanchoe pinnata in an invaded seasonally dry tropical forest (León, Herrera, & Guevara, 2016)
https://onlinelibrary.wiley.com/doi/full/10.1002/ece3.2219

* invasive succulent plant

* major driver of ecological degradation (changes in plant species composition and structure; changes in interactions such as herbivory and mycorrhizal colonization)

* simple time-based matrix model (Leslie matrix); five life cycle stages

* stochasticity: matrix elements varied randomly according to normal distribution (based on field observations)

* perturbation analyses of sensitivity and elasticity

## Resources
* popbio package: https://rdrr.io/cran/popbio/man/01Introduction.html

## References
Caswell, H. 2001. *Matrix Population Models* (2nd Edn.). Sinauer Associates, Sunderland, MA.

Clark, W. R., Bogenschutz, T. R., & Tessin, D. H. (2008). Sensitivity analyses of a population projection model of ring‐necked pheasants .*The Journal of Wildlife Management, 72*(7), 1605-1613.

Crouse, D. T., Crowder, L. B., & Caswell, H. (1987). A stage‐based population model for loggerhead sea turtles and implications for conservation. *Ecology, 68*(5), 1412-1423.

Gonzalez de Leon, S., Herrera, I., & Guevara, R. (2016). Mating system, population growth, and management scenario for *Kalanchoe pinnata* in an invaded seasonally dry tropical forest. *Ecology and evolution, 6*(13), 4541-4550.

Mills, L.S. (2012). *Conservation of wildlife populations*: Demography, genetics, and management. Wiley- Blackwell.