### The first step of IPMs: regressions

To perform an IPM model, regression models are commonly fit to  vital rate data relative to relevant state variables. Such models include linear or logistic regressions, or non-linear models such as generalized additive models (GAMs). Candidate models can be assessed using the Akaike information criteria (AIC), which you were introduced to in the section [Model Selection](https://www.ecotheory.ca/teach/BIOL652.html#model-selection-how-do-we-tell-which-model-to-use-for-our-data). The dynamics for each vital rate can be modelled by the commonly used examples below:


Table: Functions commonly used for vital rates

Vital_rate                                                Function                                                                   
--------------------------------------------------------  ---------------------------------------------------------------------------
Survival                                                  Logistic regression (generalized linear model with binomial link function) 
Growth                                                    Linear model with normal error distribution                                
Probability of life-history transition (eg., flowering)   Poisson regression (generalized linear model with log link function)       
Offspring number (eg., fruit number)                      Logistic regression (generalized linear model with binomial link function) 
Recruit size distribution                                 Normal or log-normal distribution                                          

&rarr; Note that it is not always necessary to use the above mentioned regressions. For example, functions can be used when there is no data available for growth. One illustration is the IPM model for grass carp developed by Erickson et al. (2017), where the growth function consisted of a normal distribution with 2 variables centered around a modified von Bertalanffy function of fish length at each time step. A derivative was then calculated to map length changes as a function of length.     

### How do we go about implementing an IPM for our species of interest?

This diagram shows the main steps to implement an IPM. You have already learnt about the steps in blue (first, second, and last step). 

![Flowchart of the key steps to build an IPM](https://raw.github.com/kcudding/kcudding.github.io/main/teach/flowchart.jpg){ dpi=300 } 

In addition to using regression models for vital rates, performing an IPM involves combining functions into a projection kernel, dividing kernels into classes (bins), and integrating between them to calculate transition rates. An iterative analysis of IPMs output ensures the model is improved so that it is biologically plausible. After obtaining the overall kernel corresponding to a large matrix, the same population analyses performed for matrix projection models (MPMs) can be carried out, such as stable distribution and sensitivity analyses.

### Numerical integration methods: midpoint rule

A projection kernel obtained in IPMs is analogous to projection matrices of MPMs, as $hK(z_j, z_i)$ is an $m\times m$ matrix (Gonzalez et al., 2021). To create an IPM kernel, we need to put vital rate functions together. To calculate the probability of transitioning to the next size within each group (or bin), the midpoint rule is a commonly used integration technique consisting of dividing the size range into several groups *m* with an equal length *h*. *z~i~* is the midpoint of the *i~th~* size class: 

$$n(z_j,t+1)\approx h\sum_{i=1}^mK(z_j,z_i)n(z_i,t)$$ 

### Model diagnostics and improvement

During the iterative process of model output analysis, we can improve specific functions to better correspond to the observed patterns in our data. Consider these possibilities:

* If size measurements become more variable in larger individuals, growth variance can be added as a function of size

* A fecundity function can be changed to add the probability of reproduction, which is more realistic considering that we do not observe reproduction in all individuals (Merow et al, 2014). 

In these cases, population analyses can be re-done and compared to previously run IPMs, where we can check how such improvements affect population dynamics projections.

* In terms of survival, an important error to check for is called **eviction**:

- Eviction consists of individuals transitioning to size classes which are outside the range selected for the model, thus impacting survival projections.

- To diagnose eviction, you can plot the relevant matrix elements against the fitted survival model and check for discrepancies. Misplaced individuals can then be returned to the next size class within the established range for the IPM (Merow et al, 2014).

To verify if a given IPM model is biologically realistic, we can calculate several life history events such as  life expectancy and maximum size, and observe how well the model describes our species. 

### Case study: an IPM for snapping turtles 

Armstrong and colleagues (2018) studied the importance of indeterminate growth to ectotherm population dynamics. We used the [dataset](https://datadryad.org/stash/dataset/doi:10.5061/dryad.2j05h) provided in their publication to obtain growth, reproduction and survival information for a female population of North American snapping turtles (*Chelydra serpentina*). 

![[Common snapping turtle](https://commons.wikimedia.org/wiki/File:Common_Snapping_Turtle_%28Chelydra_serpentina%29.jpg), [Creative Commons Attribution-Share Alike 3.0 Unported license](https://creativecommons.org/licenses/by-sa/3.0/deed.en)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/turtle.jpg){ fig.width=180 fig.height=120 dpi=300 } 

Because measurements were made across several years, we selected the 2 greatest size measurements and the largest fecundity measurement for surviving individuals, and the latest measurement for non-surviving individuals. New recruits (eg., individual in the 3rd row below) are individuals initially measured at the latest years of the data collection process.


```r
# Download the dataset
d <- read.csv("https://raw.githubusercontent.com/kcudding/kcudding.github.io/main/teach/snapping_turtles.csv",header=TRUE, stringsAsFactors = TRUE,fileEncoding="UTF-8-BOM")

head(d)
```

```
NA    ID surv size sizeNext   fec
NA 1 767    1 26.3     26.4 300.4
NA 2 C15    1 26.9     26.9 365.0
NA 3 J09   NA   NA     27.3    NA
NA 4 H04    1 30.2     30.3    NA
NA 5 T19    1 25.7     26.0    NA
NA 6 H18    1 28.5     28.5    NA
```



We will demonstrate the regression for reproduction:

```r
# After setting up an empty data frame to store model parameters, we proceed with our Poisson regression for reproduction
fec.reg=glm(fec~size,data=d,family=poisson())
params$offsp.int=coefficients(fec.reg)[1]
params$offsp.slope=coefficients(fec.reg)[2]
summary(fec.reg)
```

```
NA 
NA Call:
NA glm(formula = fec ~ size, family = poisson(), data = d)
NA 
NA Deviance Residuals: 
NA     Min       1Q   Median       3Q      Max  
NA -35.189   -1.742    1.345    4.119   16.884  
NA 
NA Coefficients:
NA             Estimate Std. Error z value Pr(>|z|)    
NA (Intercept) 2.880108   0.039448   73.01   <2e-16 ***
NA size        0.110536   0.001365   80.99   <2e-16 ***
NA ---
NA Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
NA 
NA (Dispersion parameter for poisson family taken to be 1)
NA 
NA     Null deviance: 28996  on 247  degrees of freedom
NA Residual deviance: 22496  on 246  degrees of freedom
NA   (50 observations deleted due to missingness)
NA AIC: 24272
NA 
NA Number of Fisher Scoring iterations: 5
```

```r
# Now you can continue creating regressions for survival and growth
```

Here are the observations and the model fit:

![Reproduction regression for snapping turtles. Bullets are observations and the regression is shown as a curve displaying the relationship between size and clutch mass at time t. ](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/unnamed-chunk-5-1.jpeg){ dpi=300 }  



Now it is time to define a function to predict the reproduction of our population (and the same should be done for the other vital rates):

```r
f.yx=function(xp,x,params) {
params$establishment.prob*
dnorm(xp,mean=params$recruit.size.mean,sd=params$recruit.size.sd)*
exp(params$offsp.int+params$offsp.slope*x)
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
NA            [,1]        [,2]        [,3]        [,4]
NA [1,] 0.01356862 0.006496844 0.002771060 0.001054831
NA [2,] 0.02704795 0.014710977 0.007123565 0.003073257
NA [3,] 0.04685952 0.028954228 0.015925250 0.007799033
NA [4,] 0.07055157 0.049528484 0.030947537 0.017213692
```

IPMs can also be obtained by using R packages, such as IPMpack:

```r
library("IPMpack")

# Create a regression object for each vital rate, such as:
survival_object<-makeSurvObj(my_dataset,surv~size)

# This package has built-in functions to evaluate different models within each vital rate

# Now create an IPM matrix
IPMmatrix<-makeIPMPmatrix(survObj=survival_object,growObj=growth_object,
                          minSize=minSize,maxSize=maxSize)
```

After obtaining an IPM matrix, population analyses can be performed in a similar fashion as in MPMs, such as asymptotic population growth rate, stable stage structure, reproductive values, sensitivities and elasticities, which you have already learnt about here: [Structured Population Models](hhttps://www.ecotheory.ca/teach/BIOL652.html#structured-population-models)

Now let's exemplify one of the possible quality checks to our IPM: checking for eviction, or individuals outside the size range impacting our survival model. For the sake of this example, we excluded a few large non-surviving individuals to reduce the variance and improve the model fit when doing the regression.  

We begin by plotting probabilities and observed values:


![Eviction check: plotting probability of survival and model values. The line shows the fitted survival model and the dots display observed values from model (column sums of growth/survival matrix) ](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/unnamed-chunk-9-1.jpeg){ dpi=300 } 

And here we see that eviction is mostly occurring among large individuals. To correct this, we can modify our matrix to place evicted individuals at the closest bin within the model boundaries (eg., individuals which are too small are placed in the bin for the smallest size, and individuals who are too big are placed in the bin for the largest size). 


```r
# loop to fix eviction of small individuals
for(i in 1:(n/2)) {
G[1,i]<-G[1,i]+1-sum(G[,i])
P[,i]<-G[,i]*S[i]
}

# loop to fix eviction of large individuals
for(i in (n/2+1):n) {
G[n,i]<-G[n,i]+1-sum(G[,i])
P[,i]<-G[,i]*S[i]
}

# ...and we recalculate our kernels:
F=h*outer(y,y,f.yx,params=params) # reproduction
K=P+F # full matrix
```

Let's plot our new column sums and see if our data looks better now:


![Eviction check: plotting probability of survival and model values. The line shows the fitted survival model and the dots display observed values from model (column sums of growth/survival matrix) ](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/unnamed-chunk-11-1.jpeg){ dpi=300 } 

## References
Armstrong, D. P., Keevil, M. G., Rollinson, N., & Brooks, R. J. (2018). Subtle individual variation in indeterminate growth leads to major variation in survival and lifetime reproductive output in a long‐lived reptile. *Functional Ecology, 32*(3), 752-761.

Doak, D. F., Waddle, E., Langendorf, R. E., Louthan, A. M., Isabelle Chardon, N., Dibner, R. R., ... & DeMarche, M. L. (2021). A critical comparison of integral projection and matrix projection models for demographic analysis. *Ecological Monographs, 91*(2), e01447.

Erickson, R. A., Eager, E. A., Brey, M. K., Hansen, M. J., & Kocovsky, P. M. (2017). An integral projection model with YY-males and application to evaluating grass carp control. Ecological Modelling, 361, 14-25.

Gonzalez, E.J., Childs, D.Z., Quintana-Ascencio, P.F. and Salguero-Gomez, R. (2021), Integral projection models. In: *Demographic Methods Across the Tree of Life*. Edited by Roberto Salguero-Gomez and Marlene Gamelon, Oxford University Press.

Merow, C., Dahlgren, J. P., Metcalf, C. J. E., Childs, D. Z., Evans, M. E., Jongejans, E., ... & McMahon, S. M. (2014). Advancing population ecology with integral projection models: a practical guide. *Methods in Ecology and Evolution, 5*(2), 99-110.
