## How do we go about implementing an IPM for our species of interest?

This diagram shows the main steps to implement an IPM. You have already learnt about the steps in blue (the first two and last two steps). 

![Flowchart of the key steps to build an IPM](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/flowchart.jpg){ dpi=300 } 

In addition to using regression models for vital rates, performing an IPM involves combining functions into a projection kernel, dividing kernels into classes (bins), and integrating between them to calculate transition rates. An iterative analysis of IPMs outputs ensures the model is improved so that it is biologically plausible. After obtaining the overall kernel corresponding to a large matrix, the same population analyses performed for matrix projection models (MPMs) can be carried out, such as stable distribution and sensitivity analyses.

### Numerical integration methods: midpoint rule

A projection kernel obtained in IPMs is analogous to projection matrices of MPMs, as $hK(z_j, z_i)$ is an $m\times m$ matrix (Gonzalez et al., 2021). To create an IPM kernel, we need to put vital rate functions together. To calculate the probability of transitioning to the next size within each group (or bin), the midpoint rule is a commonly used integration technique consisting of dividing the size range into several groups *m* with an equal length *h*. *z~i~* is the midpoint of the *i~th~* size class: 

$$n(z_j,t+1)\approx h\sum_{i=1}^mK(z_j,z_i)n(z_i,t)$$ 

Let's continue using our snapping turtle example to make a kernel. First, we define the matrix size, size range, boundary points, mesh points, and step size:

```r
min.size=.9*min(c(d$size,d$sizeNext),na.rm=T)
max.size=1.1*max(c(d$size,d$sizeNext),na.rm=T)
n=100 # amount of cells in the matrix
b=min.size+c(0:n)*(max.size-min.size)/n # boundary points (edges of matrix)
y=0.5*(b[1:n]+b[2:(n+1)]) # mesh points (matrix points for midpoint evaluation)
h=y[2]-y[1] # step size  (widths)
```

The IPM matrices can now be created using the regression parameters we have previously calculated and the settings we have just defined. First, individual matrices are created for growth, reproduction, and survival. The function outer() is used to create the kernels for growth and fecundity by evaluating all pairwise combinations of vectors y in the 2 step sizes. Next, the full matrix is obtained by matrix multiplication and addition:

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
           [,1]        [,2]        [,3]        [,4]
[1,] 0.01356856 0.006496783 0.002770993 0.001054756
[2,] 0.02704788 0.014710900 0.007123478 0.003073161
[3,] 0.04685943 0.028954129 0.015925140 0.007798911
[4,] 0.07055146 0.049528360 0.030947397 0.017213537
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

### Model diagnostics and improvement

During the iterative process of model output analysis, we can improve specific functions to better correspond to the observed patterns in our data. Consider these scenarios: if size measurements become more variable in larger individuals, growth variance can be added as a function of size; a given fecundity function can be changed to add the probability of reproduction, which is more realistic considering that we do not observe reproduction in all individuals (Merow et al, 2014). In these cases, population analyses can be re-done and compared to previously run IPMs, where we can check how such improvements affect population dynamics projections. To verify if a given IPM model is biologically realistic, we can calculate several life history events such as  life expectancy and maximum size, and observe how well the model describes our species. 

In terms of survival, an important error to check for is called **eviction**. Eviction consists of individuals transitioning to size classes which are outside the range selected for the model, thus impacting survival projections. To diagnose eviction, you can plot the relevant matrix elements against the fitted survival model and check for discrepancies. Misplaced individuals can then be returned to the next size class within the established range for the IPM (Merow et al, 2014). Now let's exemplify the eviction check using duckweed (*Lemna minor*) population data we collected in our lab. After running regressions and creating our IPM matrix the same way as we demonstrated using the snapping turtle example, we begin the eviction check by plotting the survival model fit and observations from the IPM matrix:






![Eviction check: plotting probability of survival and model values. The line shows the fitted survival model and the dots display observed values from model (column sums of growth/survival matrix) ](https://raw.github.com/kcudding/kcudding.github.io/main/teach/IPM_implementation_files/unnamed-chunk-9-1.jpeg){ dpi=300 } 

And here we see that eviction is occurring among large individuals. To correct this, we can modify our matrix to place evicted individuals at the closest bin within the model boundaries (eg., individuals which are too small are placed in the bin for the smallest size, and individuals who are too big are placed in the bin for the largest size, such as in our scenario). 


```r
# loop to fix eviction of small individuals (not necessary for our specific example)
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
