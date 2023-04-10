


## Sensitivities, elasticities, and management applications

Remember how populations which achieved a stable stage distribution (SSD) maintain a constant proportion of organisms in each stage? Each of these stages contributes differently to the overall population, which is indicated by specific reproductive values. Thus, we can expect that vital rates for a stage with more individuals and/or larger reproductive values will have a greater impact to population growth rates. **Sensitivity and elasticity analyses** are performed to determine the importance of each vital rate (survival or reproduction) within stages to the growth of a given population. While **sensitivities** represent absolute differences, **elasticities** enable a proportional comparison between vital rates. The theory and mathematical notations used in this section are based on Caswell (2001).

### Why are sensivities and elasticities important to population ecology studies?

By identifying the most important vital rates to population dynamics, the analysis of sensitivities and elasticities has the potential to guide management decisions in terms of targeting actions to specific life stages. It enables life history comparisons, managing extinction risk, and population growth control (Manlik, Lacy, & Sherwin, 2018). Such analyses are also useful for understanding how a given societal, environmental, or policy change will affect wildlife, and how population fitness evolves as a response to phenotypic changes (Caswell, 2019).

One of the first studies which applied sensitivity analysis found that management strategies for endangered loggerhead sea turtles should focus on young adults in the ocean more than hatchlings moving from the sand to the sea. This is because elasticity values for young adult survival are greater than elasticities for eggs and hatchlings. High mortality for young adults was attributed to turtles accidentally trapped in fishing gear. After implementing turtle excluder devices (TED) as a management strategy, temporary population increases were observed (Crouse, Crowder, & Caswell, 1987). A more recent study identified that this strategy has contributed to a deep reduction in turtle mortality, including other endangered species (Finkbeiner et al., 2011). Such findings contribute to the choice and application of successful management strategies which result in population growth of endangered species. 

![© T. Moore, [Loggerhead Turtle](https://commons.wikimedia.org/wiki/File:Loggerhead_Turtle_%285884715439%29.jpg), Public use provided by the [National Institute of Standards and Technology (NIST), US](https://www.nist.gov/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/turtle.jpg){ fig.width=180 fig.height=120 dpi=300 } 

### Analytical sensitivity analysis

How sensitive is population growth to small changes in different vital rates? We can investigate this by looking at how $\lambda$ is impacted (or how sensitive it is) following a very small change in a vital rate within a given population matrix, considering that all of the other matrix elements remain unchanged. This is called analytical sensitivity, which is given by the following:

$$a_{i,j} = \frac{\partial\lambda}{\partial a_{i,j}} = \frac{v_{i}*w_{j}}{\sum_{k=1}{(v_k*w_k)}}$$
Where:
a(i,j) = a given matrix element  
$\partial$ = partial derivative denoting a very small change applied to rates while all other variables are held constant  
$\lambda$ = rate of population change  
v(i) = reproductive value  
w(j) = stable stage distribution (SSD) value  
v(k) = reproductive value for class k
w(k) = stable stage distribution (SSD) value for class k  

### From sensitivity to elasticity

Because the sensitivity analysis is based in absolute values, changes applied to small values have a disproportional effect in comparison to changes to larger values, which can make comparisons problematic. This is especially true because fecundity rates are usually measured using different units than survival rates. A solution is considering vital rate sizes and making sensitivities proportional to them. Such rescaled sensitivites are then called **elasticities** and can be represented by:

$$\text{Elasticity of }a_{i,j} = \text{(sensitivity of }a_{i,j})*\frac{a_{i,j}}{\lambda}$$

Soon you will learn how to calculate the sensitivities and elasticities you see in the following plot. For now, try to focus on the fact that absolute sensitivity values change when scaled into elasticities. Matrix elements which are very sensitive (eg., survival of 9-16cm trees in our plot) seem to have the potential to greatly alter $\lambda$ rates. But to compare vital rates, we need elasticities. Our elasticities tell us that survival for bigger trees is proportionally more significant in terms of impacting growth rates. Thus, a very sensitive element may end up having a low relative elasticity value. In this case, we could recommend to wildlife managers looking at an endangered species to focus on taller individuals first.

![Sensitivities and elasticities for several tree sizes (in cm) in an oak population](https://raw.github.com/kcudding/kcudding.github.io/main/teach/sensitivity_analysis_files/unnamed-chunk-6-1.jpeg){ dpi=300 }

### Practicing the calculation of sensitivities and elasticities through the analytical method
Now let's use an actual population matrix to make a sensitivity analysis and try to figure out the most important vital rates to an oak tree (*Quercus mongolica*) population. In Asia, the native range for this plant, populations have been suffering steep decreases in size due to the spread of a fungal disease vectored by a beetle (Choi et al., 2022). 

![A healthy (left) and an infected (right) oak tree; (left) © MPF, [*Quercus mongolica*](https://commons.wikimedia.org/wiki/File:Quercus_mongolica_in_June.jpg), [Creative Commons CC BY-SA 3.0 license](https://creativecommons.org/licenses/by-sa/3.0/deed.en); (right) © William M. Ciesla, [Oak wilt](https://www.invasive.org/browse/detail.cfm?imgnum=0758073#), [Creative Commons CC BY-NC 3.0 license](https://creativecommons.org/licenses/by-nc/3.0/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/oak.jpg){ fig.width=180 fig.height=120 dpi=300 }  

It is important to know life history aspects affecting the population growth for this species when predicting disease impacts and planning management actions. A mean matrix for this plant can be found on the [Compadre database](https://compadre-db.org/Species/47241).




           5-8cm   9-16cm   17-32cm   33-64cm   >64cm
--------  ------  -------  --------  --------  ------
5-8cm      0.407    0.000     0.000     0.606   0.606
9-16cm     0.483    0.701     0.000     0.000   0.000
17-32cm    0.002    0.239     0.832     0.000   0.000
33-64cm    0.000    0.000     0.117     0.929   0.000
>64cm      0.000    0.000     0.000     0.037   0.977

We first find the stable stage distribution through an eigen analysis:


```r
# Run the eigenanalysis
eigen_L <- eigen(L)

# Find the index position of the largest absolute value of the eigenvalues
position <- which.max(eigen_L[["values"]])

# Extract the dominant eigenvalue and retain only its real part
lambda <- Re(eigen_L[["values"]][position])

# Obtain the stable stage distribution
eigenvectors <- Re(eigen_L[["vectors"]][, position])
ssd <- eigenvectors/sum(eigenvectors)

# Transpose projection matrix and do eigen analysis
eigenanalysis <- eigen(t(L))

# Extract left eigenvector corresponding to dominant eigenvalue
left <- Re(eigenanalysis$vectors[, which.max(Re(eigenanalysis$values))])

# Scale the left eigenvector by the reproductive value of the first stage
repv <- left/left[1]

# Sum the products of the vector of reproductive value and the stable stage distribution
S.dem<-sum(repv*ssd)
```

And now we are ready to get the sensitivities and elasticities for our oak population:


```r
# We can use two loops to estimate the sensitivity for each matrix element
s=L; n=dim(L)[1];
  for(i in 1:n) {
  for(j in 1:n) {
  s[i,j]=repv[i]*ssd[j]/S.dem;
  }}

# And we weight the sensitivities by the transition probabilities to get elasticities
elas<-Re(L/eigen(L)$values[1]*s)
```

Finally, we visualize sensitivities and elasticities for each vital rate and stage in these bar plots:


![Comparing sensitivities and elasticities for the reproduction and survival of several tree sizes (in cm) in an oak population](https://raw.github.com/kcudding/kcudding.github.io/main/teach/sensitivity_analysis_files/r-1.jpeg){ dpi=300 }  


By looking at the elasticities for survival and reproduction, we conclude that **adult survival** for trees between the sizes of 17 and 64 cm are the most important vital rates to the growth of this population. Thus, such sizes can be prioritized in management programs focused on disease prevention. 

Alternatively, you can use the popbio package, which calculates sensitivity and elasticity matrices in the same manner as we have just done:

```r
library(popbio)
sensit <- sensitivity(L, zero = FALSE)
elast <- elasticity(L)
```

### Component sensitivity and elasticity

Component sensitivity is a numerical approximation of sensitivity which you have just learnt how to calculate. In addition to being used as an approximation to analytical sensitivities, component sensitivities can be used in cases in which both survival and reproduction rates affect the same matrix elements or when a certain vital rate appears in more than one matrix element. They can be calculated by changing the $\lambda$ SSD by a small amount (eg., 0.01 in the equation below), obtaining the resulting matrix, and obtaining the new $\lambda$ SSD for this changed matrix. Then, you proceed with this calculation for a given vital rate x:

$$x = \frac{\lambda_{x+0.01}-\lambda_{original}}{0.01}$$

And for the elasticity:

$$\text{Component elasticity of vital rate x} = \text{(component sensitivity of vital rate x) }*\frac{x}{\lambda_{original}}$$

### Advantages of elasticities as compared to sensitivites

Elasticities are useful in population biology studies due to the following properties:

* Elasticities for several vital rates can be directly compared within and between populations

* The sum of elasticities of all matrix elements equals 1

* The sum of 2 or more elasticities enable analyzing the grouped effect of vital rates

* General life history patterns can be considered when analyzing elasticities. For instance, long-lived species tend to have a higher elasticity for survival in comparison with reproduction. Thus, when observing significant changes in population growth rates, adult survival elasticities should be considered first.

### Limitations of sensitivity and elasticity analyses

Sensitivities and elasticities are calculated based on the assumption that populations have a stable stage distribution. However, they are not enough to describe vital rate dynamics under natural or management conditions: this is because high and low sensitivities and elasticities need to be considered together with the variance of vital rates.

Sensitivity analyses using a mean matrix can be misleading in some situations, such as when environmental conditions have a large influence on a given population. Mean matrices also disregard transient dynamics following management actions. In this case, phenomena such as population inertia may occur, in which growth occurs in opposite trends as the predicted by asymptotic elasticity as a result of a large change to a vital rate with a high elasticity. Our section entitled [**Temporal environmental stochasticity in matrix models**](https://www.ecotheory.ca/teach/BIOL652.html#structured-population-models) details analyses considering sensitivities and elasticities for transients and stochastic scenarios.

### Sensitivity analysis & variance in vital rates

A high elasticity and low variation in a vital rate may be less important to population growth than another vital rate characterized by a low elasticity but a great variability. An example is juvenile survival for several species: even if a low elasticity is found for this vital rate, it may be more variable than vital rates for adults, as juveniles have more mortality due to predation, poor conditions, and density-dependent factors. Mean matrices are not appropriate for this type of analysis, as it requires knowing how much vital rates change in nature or under management and how this change affects population growth.

### Life-stage simulation analysis

Life-stage simulation analysis is a method which considers both sensitivity and variance in vital rates. It is done by applying realistic changes to averages and variances in field-collected rates to simulate several potential future scenarios. Thus, several matrices are built using the vital rates specified in a distribution function, and $\lambda$ SSDs are calculated for each matrix to investigate the probability of a population to increase or decrease in time. By considering each matrix as a replicate, we can compare ratings of elasticities across scenarios. To include stochasticity, random vital rates can be used and $\lambda$S can be calculated instead of $\lambda$ SSD. 

Life-stage simulation analyses can also be done by regressing $\lambda$ values against each vital rate (for each replicate), considering that all other vital rates are also changing at the same time. In this case, the coefficient of determination ($R^2$) corresponds to how much variation in population growth is explained by variation in that specified vital rate. The slope of line represents the analytical sensitivity; if using log-transformed data, the slope corresponds to the elasticity.
