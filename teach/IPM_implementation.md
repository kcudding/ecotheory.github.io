---
title: "Numerical Implementation"
author: "Debora"
date: "2023-03-15"
output:
  html_document:
    toc: true
    toc_depth: 4
    number_sections: true
    toc_float:
      collapsed: false
      smooth_scroll: false
    keep_md: yes
---



## How do we go about implementing an IPM for our species of interest?

Performing an IPM model involves using regression models for vital rates, combining functions into a projection kernel, dividing kernels into classes (bins), and integrating between them to calculate transition rates. An iterative analysis of IPMs output ensures the model is improved so that it is biologically plausible. After obtaining the overall kernel corresponding to a large matrix, the same population analyses performed for matrix projection models (MPMs) can be carried out, such as stable distribution and sensitivity analyses.     

### Modelling vital rates: regressions

To perform an IPM model, regression models are fit to data relative to relevant state variables. Such models include linear or logistic regressions, or non-linear models such as generalized additive models (GAMs). Candidate models can be assessed using the Akaike information criteria (AIC), which you were introduced to in the section [Model Selection](https://www.ecotheory.ca/teach/BIOL652.html#model-selection-how-do-we-tell-which-model-to-use-for-our-data). The dynamics for each vital rate can be modelled by the commonly used examples below:


Table: Functions commonly used for vital rates

Vital_rate                                                Function                                                                   
--------------------------------------------------------  ---------------------------------------------------------------------------
Survival                                                  Logistic regression (generalized linear model with binomial link function) 
Growth                                                    Linear model with normal error distribution                                
Probability of life-history transition (eg., flowering)   Poisson regression (generalized linear model with log link function)       
Offspring number (eg., fruit number)                      Logistic regression (generalized linear model with binomial link function) 
Recruit size distribution                                 Normal or log-normal distribution                                          


### Numerical integration methods: midpoint rule

A projection kernel obtained in IPMs is analogous to projection matrices of MPMs, as $hK(z_j, z_i)$ is an $m\times m$ matrix (Gonzalez et al., 2021). To create an IPM kernel, we need to put vital rate functions together. To calculate the probability of transitioning to the next size within each group (or bin), the midpoint rule is a commonly used integration technique consisting of dividing the size range into several groups *m* with an equal length *h*. *z~i~* is the midpoint of the *i~th~* size class: 

$$n(z_j,t+1)\approx h\sum_{i=1}^mK(z_j,z_i)n(z_i,t)$$ 

### Model diagnostics and improvement

During the iterative process of model output analysis, we can improve specific functions to better correspond to the observed patterns in our data. For example, if size measurements become more variable in larger individuals, growth variance can be added as a function of size; or a fecundity function can be changed to add the probability of reproduction, which is more realistic considering that we do not observe reproduction in all individuals (Merow et al, 2014). Population analyses can then be re-done and compared to previously run IPMs, where we can check how such improvements affect population dynamics projections.

In terms of survival, an important error to check for is called **eviction**, which consists of individuals transitioning to size classes which are outside the range selected for the model, thus impacting survival projections. To diagnose this, you can plot the relevant matrix elements against the fitted survival model and check for discrepancies. Misplaced individuals can then be returned to the next size class within the established range for the IPM (Merow et al, 2014).

To verify if a given IPM model is biologically realistic, we can calculate several life history events such as  life expectancy and maximum size, and observe how well the model describes our species. 

### Case study: an IPM for duckweeds
We took note of the mortality of duckweed fronds submitted to fluctuating temperature regimes with a mean of 37C, for 5 days. Because at this time we only have grouped data for initial populations consisting of 4 fronds, we estimated average values per individual. Initial frond surface area was calculated by taking the average surface area of 4 fronds. Individual mortality was considered when population mortality was greater than 4 individuals. Average individual reproduction was calculated as total reproduction divided by the initial population. Size at the next stage was hypothesized as a 3x increase in frond size for the purpose of having dummy data for this exercise only. Here is our data:


```r
# Download the dataset
d <- read.csv("https://raw.githubusercontent.com/kcudding/kcudding.github.io/main/teach/ipm_duckweed.csv",header=TRUE, stringsAsFactors = TRUE,fileEncoding="UTF-8-BOM")
head(d)
```

```
NA   experiment_number treatment    size sizeNext surv fec
NA 1                81      0.00 0.05325  0.15975    1   5
NA 2                81      0.00 0.05875  0.17625    0  NA
NA 3                81      0.95 0.05525  0.16575    0  NA
NA 4                81      0.95 0.03575  0.10725    0  NA
NA 5                82      0.00 0.06475  0.19425    0  NA
NA 6                82      0.00 0.05600  0.16800    0  NA
```

We build one regression for each vital rate: growth, survival, and reproduction. You can start by creating an empty data frame to store parameters for each model. 



We will demonstrate the regression for survival:

```r
# Logistic regression for survival
surv.reg=glm(surv~size,data=d,family=binomial())
params$surv.int=coefficients(surv.reg)[1]
params$surv.slope=coefficients(surv.reg)[2]
summary(surv.reg)
```

```
NA 
NA Call:
NA glm(formula = surv ~ size, family = binomial(), data = d)
NA 
NA Deviance Residuals: 
NA     Min       1Q   Median       3Q      Max  
NA -2.1654  -0.8857   0.3729   0.8629   1.8494  
NA 
NA Coefficients:
NA             Estimate Std. Error z value Pr(>|z|)  
NA (Intercept)   -3.732      1.819  -2.051   0.0403 *
NA size          52.879     24.590   2.150   0.0315 *
NA ---
NA Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
NA 
NA (Dispersion parameter for binomial family taken to be 1)
NA 
NA     Null deviance: 33.104  on 23  degrees of freedom
NA Residual deviance: 26.474  on 22  degrees of freedom
NA   (24 observations deleted due to missingness)
NA AIC: 30.474
NA 
NA Number of Fisher Scoring iterations: 4
```

```r
# Now you can continue creating regressions for reproduction and growth
```

Here are the observations and the model fit:

![A logistic model for the survival of duckweeds](https://raw.github.com/kcudding/kcudding.github.io/main/teach/unnamed-chunk-5-1.jpeg){ dpi=300 }  



Now it is time to define a function to predict the survival of our population (and the same should be done for the other vital rates):

```r
s.x=function(x,params) {
u=exp(params$surv.int+params$surv.slope*x)
return(u/(1+u))
}
```



To make a kernel, define the matrix size, size range, boundary points, mesh points, and step size:

```r
min.size=.9*min(c(d$size,d$sizeNext),na.rm=T)
max.size=1.1*max(c(d$size,d$sizeNext),na.rm=T)
n=100 # amount of cells in the matrix
b=min.size+c(0:n)*(max.size-min.size)/n # boundary points (edges of matrix)
y=0.5*(b[1:n]+b[2:(n+1)]) # mesh points (matrix points for midpoint evaluation)
h=y[2]-y[1] # step size  (widths)
```

The IPM matrices can now be created using the regression parameters and the settings we have just defined. First, individual matrices are created for growth, reproduction, and survival. The function outer() is used to create the kernels for growth and fecundity by evaluating all pairwise combinations of vectors y in the 2 step sizes. Next, the full matrix is obtained by matrix multiplication and addition:

```r
G=h*outer(y,y,g.yx,params=params) # growth matrix
S=s.x(y,params=params) # survival matrix
F=h*outer(y,y,f.yx,params=params) # reproduction matrix

P=G # placeholder; P is redefined on the next line
for(i in 1:n) P[,i]=G[,i]*S[i] # growth/survival matrix
K=P+F # full matrix
K[1:4,1:4]
```

```
NA             [,1]        [,2]        [,3]        [,4]
NA [1,] 0.001271302 0.001267617 0.001263943 0.001260279
NA [2,] 0.001460592 0.001456358 0.001452137 0.001447927
NA [3,] 0.001673134 0.001668285 0.001663449 0.001658627
NA [4,] 0.001910973 0.001905434 0.001899911 0.001894403
```

After obtaining an IPM matrix, population analyses can be performed in a similar fashion as in MPMs, such as asymptotic population growth rate, stable stage structure, reproductive values, sensitivities and elasticities, which you have already learnt about here: [Structured Population Models](hhttps://www.ecotheory.ca/teach/BIOL652.html#structured-population-models)

## References
Doak, D. F., Waddle, E., Langendorf, R. E., Louthan, A. M., Isabelle Chardon, N., Dibner, R. R., ... & DeMarche, M. L. (2021). A critical comparison of integral projection and matrix projection models for demographic analysis. *Ecological Monographs, 91*(2), e01447.

Gonzalez, E.J., Childs, D.Z., Quintana-Ascencio, P.F. and Salguero-Gomez, R. (2021), Integral projection models. In: *Demographic Methods Across the Tree of Life*. Edited by Roberto Salguero-Gomez and Marlene Gamelon, Oxford University Press.

Merow, C., Dahlgren, J. P., Metcalf, C. J. E., Childs, D. Z., Evans, M. E., Jongejans, E., ... & McMahon, S. M. (2014). Advancing population ecology with integral projection models: a practical guide. *Methods in Ecology and Evolution, 5*(2), 99-110.
