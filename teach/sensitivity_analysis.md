


## Sensitivities, elasticities, and management applications

Remember how populations which achieved a stable stage distribution (SSD) maintain a constant proportion of organisms in each stage? Each of these stages contributes differentially to the overall population, which is indicated by specific reproductive values. Thus, we can expect that vital rates for a stage with more individuals and/or larger reproductive values will have a greater impact to $\lambda$ growth rates. **Sensitivity and elasticity analyses** are performed to determine the importance of each vital rate (survival or reproduction) within stages to the growth of a given population. While **sensitivities** represent absolute differences, **elasticities** enable a proportional comparison between vital rates. The theory and mathematical notations used in this section are based on Mills (2012).

### Why are sensivities and elasticities important to population ecology studies?

By identifying the most important vital rates to population dynamics, the analysis of sensitivities and elasticities has the potential to guide management decisions in terms of targeting actions to specific life stages. It enables life history comparisons, managing extinction risk, and population growth control (Manlik, Lacy, & Sherwin, 2018). Such analyses are also useful for understanding how a given societal, environmental, or policy change will affect wildlife, and how population fitness evolves as a response to phenotypic changes (Caswell & Caswell, 2019).

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

Because the sensitivity analysis is based in absolute values, changes applied to small values have a disproportional effect in comparison to changes to larger values, which can make comparisons problematic. This is especially true because fecundity rates are usually measured using different units than survival rates. A solution is considering vital rate sizes and making sensitivities proportional to them. Such rescaled sensitivites are then called **elasticities** and can be represented by:

$$\text{Elasticity of }a_{i,j} = \text{(sensitivity of }a_{i,j})*\frac{a_{i,j}}{\lambda}$$

![](sensitivity_analysis_files/figure-html/unnamed-chunk-1-1.jpeg)<!-- -->

In this plot, you can see how hypothetical absolute sensitivity values change when scaled into elasticities. Matrix elements which are very sensitive (eg., juvenile survival in our plot) greatly alter $\lambda$ rates. But to compare vital rates, we need elasticities. Our elasticities tell us that adult reproduction is proportionally the most significant in terms of impacting growth rates. Thus, a very sensitive element may end up having a low relative elasticity value. In this case, we could recommend to wildlife managers looking at an endangered species to focus on adult reproduction first.

### Component sensitivity and elasticity

This type of analysis is applicable for the following situations:

* When both survival and reproduction rates affect a given matrix element

* When a certain vital rate impacts more than one matrix element

Component sensitivities and elasticities can be obtained by changing the $\lambda$ SSD by a small amount (eg., 0.01 in the equation below), obtaining the resulting matrix, and obtaining the new  $\lambda$ SSD for this changed matrix. Then, you proceed with this calculation for a given vital rate x:

$$x = \frac{\lambda_{x+0.01}-\lambda_{original}}{0.01}$$

And for the elasticity:

$$\text{Component elasticity of vital rate x} = \text{(component sensitivity of vital rate x) }*\frac{x}{\lambda_{original}}$$

### Practicing the calculation of sensitivities and elasticities

Let's pretend that we want to identify the most important vital rates affecting the population dynamics of a critically endangered South American pine species, *Araucaria angustifolia*. This ancient tree originated in the Triassic period and is now threatened by habitat loss and climate change (Marchioro, Santos, & Siminski, 2020; Thomas, 2013). 

![© Webysther Nunes, ["Araucária" (*Araucaria angustifolia*)](https://commons.wikimedia.org/wiki/File:Webysther_20190413132108_-_Arauc%C3%A1ria_%28Araucaria_angustifolia%29.jpg), [Creative Commons CC-BY-SA 4.0 BR license](https://creativecommons.org/licenses/by-sa/4.0/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/araucaria.jpg){ fig.width=180 fig.height=120 dpi=300 }

What is the importance of the survival of seedlings vs. adult reproduction for this population?


```r
# Here are the hypothetical vital rates we want to investigate
seedl_surv <- 0.3
adt_reprod <- 30

# These rates can be visualized in the following matrix
library(kableExtra)
label <- c("Seedling", "Juvenile", "Adult")

pop0 <- matrix(c(rbind(c(0,40,adt_reprod),c(seedl_surv,0,0),
                                    c(0,0.5,0.9))), nrow=3, 
                                    dimnames = list(label, label))

knitr::kable(pop0,"simple", caption = "Original population matrix")
```



Table: Original population matrix

            Seedling   Juvenile   Adult
---------  ---------  ---------  ------
Seedling         0.0       40.0    30.0
Juvenile         0.3        0.0     0.0
Adult            0.0        0.5     0.9


```r
# We want to know the effects of a 10% change (or another observed variance)
# in these vital rates
seedl_surv1 <- seedl_surv + seedl_surv*0.1
adt_reprod1 <- adt_reprod + adt_reprod*0.1

# These changes are now incorporated in our original matrix
# This is the scenario for a change in seedling survival:
pop1_surv <- matrix(c(rbind(c(0,40,adt_reprod1),c(seedl_surv,0,0),
                                    c(0,0.5,0.9))), nrow=3, 
                                    dimnames = list(label, label))

knitr::kable(pop1_surv,"simple", caption = "Changed population matrix: seedling survival")
```



Table: Changed population matrix: seedling survival

            Seedling   Juvenile   Adult
---------  ---------  ---------  ------
Seedling         0.0       40.0    33.0
Juvenile         0.3        0.0     0.0
Adult            0.0        0.5     0.9


```r
# And this is the scenario for a change in adult reproductive rates:
pop1_reprod <- matrix(c(rbind(c(0,40,adt_reprod),c(seedl_surv1,0,0),
                                    c(0,0.5,0.9))), nrow=3, 
                                    dimnames = list(label, label))

knitr::kable(pop1_reprod,"simple", caption = "Changed population matrix: adult reproduction")
```



Table: Changed population matrix: adult reproduction

            Seedling   Juvenile   Adult
---------  ---------  ---------  ------
Seedling        0.00       40.0    30.0
Juvenile        0.33        0.0     0.0
Adult           0.00        0.5     0.9


```r
# Let's now obtain the original lambda
lambda0 <- as.numeric(format(round(eigen(pop0)$value[1], 2), nsmall = 2))

# And the changed lambdas
# For a change in seedling survival
lambda_surv <- as.numeric(format(round(eigen(pop1_surv)$value[1], 2), nsmall = 2))

# Change in adult reproduction
lambda_reprod <- as.numeric(format(round(eigen(pop1_reprod)$value[1], 2), nsmall = 2))

knitr::kable(rbind(c("Original lambda","Lambda for change in seedling survival",
                            "Lambda for change in adult reproduction"),
                            c(lambda0,lambda_surv,lambda_reprod)),"simple")
```



----------------  ---------------------------------------  ----------------------------------------
Original lambda   Lambda for change in seedling survival   Lambda for change in adult reproduction 
3.69              3.71                                     3.86                                    
----------------  ---------------------------------------  ----------------------------------------


```r
# And here is the sensitivity we get by using the equation we have just seen
sensitivity_surv <- as.numeric(format(round((lambda_surv-lambda0)/(seedl_surv1-seedl_surv),
                                            2), nsmall = 2))

sensitivity_reprod <- as.numeric(format(round((lambda_reprod-lambda0)/(adt_reprod1-adt_reprod),
                                            2), nsmall = 2))

knitr::kable(rbind(c("Sensitivity for change in seedling survival",
                     "Sensitivity for change in adult reproduction"),
                            c(sensitivity_surv,sensitivity_reprod)),"simple")
```



--------------------------------------------  ---------------------------------------------
Sensitivity for change in seedling survival   Sensitivity for change in adult reproduction 
0.67                                          0.06                                         
--------------------------------------------  ---------------------------------------------


```r
# We now scale the sensitivity to get the elasticity
elasticity_surv <- as.numeric(format(round(sensitivity_surv*(seedl_surv/lambda0),2), nsmall = 2))

elasticity_reprod <- as.numeric(format(round(sensitivity_reprod*(adt_reprod/lambda0),2), nsmall = 2))

knitr::kable(rbind(c("Elasticity for change in seedling survival",
                     "Elasticity for change in adult reproduction"),
                            c(elasticity_surv,elasticity_reprod)),"simple")
```



-------------------------------------------  --------------------------------------------
Elasticity for change in seedling survival   Elasticity for change in adult reproduction 
0.05                                         0.49                                        
-------------------------------------------  --------------------------------------------

By looking at the elasticities of seedling survival (0.05) and adult reproduction (0.49), we conclude that adult reproduction is more important to the growth of this population. Although this is a hypothetical example, a sensitivity analysis actually found that adult reproduction is the most important vital rate for this tree species. This is because this is a long-lived species with low adult mortality, while most seedlings do not survive. You can read more in Paludo et al. (2016).

If we keep doing this analysis for all vital rates in a given population matrix, we can them compare them to understand their relative impact to population growth.

### Advantages of elasticities as compared to sensitivites

Elasticities are useful in population biology studies due to the following properties:

* Elasticities for several vital rates can be directly compared within and between populations

* The sum of elasticities of all matrix elements equals 1

* The sum of 2 or more elasticities enable analyzing the grouped effect of vital rates

* General life history patterns can be considered when analyzing elasticities. For instance, long-lived species tend to have a higher elasticity for survival in comparison with reproduction. Thus, when observing significant changes in population growth rates, adult survival elasticities should be considered first.

### Limitations of sensitivity and elasticity analyses

* Assumption that populations have a stable stage distribution

* They are not enough to describe vital rate dynamics under natural or management conditions: this is because high and low sensitivities and elasticities need to be considered together with the variance of vital rates. For example, a given vital rate with a high elasticity but low variance may be less important than another vital rate with a low elasticity but which changes a lot.

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

#### Management applications 

* Recall that, in the broad sense, a sensitivity analysis encompasses these various analytical and simulation techniques we have been talking about

* Such techniques include sensitivity and elasticity calculations together with other important management aspects, such as the joint consideration of vital rate variance and sensitivity/elasticity analyses

* Past and future management actions can be compared in terms of their impacts to vital rates, which ultimately affects population density

One of the first studies which applied sensitivity analysis found that management strategies for endangered loggerhead sea turtles should focus on young adults in the ocean more than hatchlings moving from the sand to the sea. This is because elasticity values for young adult survival are greater than elasticities for eggs and hatchlings. High mortality for young adults was attributed to turtles accidentally trapped in fishing gear. After implementing turtle excluder devices (TED) as a management strategy, temporary population increases were observed (Crouse, Crowder, & Caswell, 1987). A more recent study identified that this strategy has contributed to a deep reduction in turtle mortality, including other endangered species (Finkbeiner et al., 2011). Such findings contribute to the choice and application of successful management strategies which result in population growth of endangered species. 

![© T. Moore, [Loggerhead Turtle](https://commons.wikimedia.org/wiki/File:Loggerhead_Turtle_%285884715439%29.jpg), Public use provided by the [National Institute of Standards and Technology (NIST), US](https://www.nist.gov/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/turtle.jpg){ fig.width=180 fig.height=120 dpi=300 } 

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

#### Sensitivity analysis demonstration
Now let's use an actual population matrix to make a sensitivity analysis and try to figure out the most important vital rates to an oak tree (*Quercus mongolica*) population. In Asia, the native range for this plant, populations have been suffering steep decreases in size due to the spread of a fungal disease vectored by a beetle (Choi et al., 2022). 

![(left) © MPF, [*Quercus mongolica*](https://commons.wikimedia.org/wiki/File:Quercus_mongolica_in_June.jpg), [Creative Commons CC BY-SA 3.0 license](https://creativecommons.org/licenses/by-sa/3.0/deed.en); (right) © William M. Ciesla, [Oak wilt](https://www.invasive.org/browse/detail.cfm?imgnum=0758073#), [Creative Commons CC BY-NC 3.0 license](https://creativecommons.org/licenses/by-nc/3.0/)](https://raw.github.com/kcudding/kcudding.github.io/main/teach/oak.jpg){ fig.width=180 fig.height=120 dpi=300 }

It is important to know life history aspects affecting the population growth for this species when predicting disease impacts and planning management actions. A mean matrix for this plant can be found on the [Compadre database](https://compadre-db.org/Species/47241).


```r
# We paste the matrix elements found in the Compadre database
oak <- matrix(c(0.407,0,0,0.606,0.606,
                    0.483,0.701,0,0,0,
                    0.002,0.239,0.832,0,0,
                    0,0,0.117,0.929,0,
                    0,0,0,0.037,0.977), nrow=5, byrow=TRUE,
                  dimnames=list(c("5-8cm","9-16cm","17-32cm","33-64cm",">64cm"),
                  c("5-8cm","9-16cm","17-32cm","33-64cm",">64cm")))

knitr::kable(oak,"simple")
```

           5-8cm   9-16cm   17-32cm   33-64cm   >64cm
--------  ------  -------  --------  --------  ------
5-8cm      0.407    0.000     0.000     0.606   0.606
9-16cm     0.483    0.701     0.000     0.000   0.000
17-32cm    0.002    0.239     0.832     0.000   0.000
33-64cm    0.000    0.000     0.117     0.929   0.000
>64cm      0.000    0.000     0.000     0.037   0.977

The popbio package calculates sensitivity and elasticity matrices in the same manner as we did in our previous example

```r
library(popbio)
sensit <- sensitivity(oak, zero = FALSE)
knitr::kable(sensit,"simple",caption="Sensitivity matrix")
```



Table: Sensitivity matrix

               5-8cm      9-16cm     17-32cm     33-64cm       >64cm
--------  ----------  ----------  ----------  ----------  ----------
5-8cm      0.0896726   0.1114987   0.1042040   0.0759845   0.0250011
9-16cm     0.1258554   0.1564882   0.1462501   0.1066441   0.0350890
17-32cm    0.2045556   0.2543438   0.2377036   0.1733311   0.0570310
33-64cm    0.4501133   0.5596695   0.5230536   0.3814054   0.1254935
>64cm      0.4832427   0.6008624   0.5615516   0.4094777   0.1347301

```r
elast <- elasticity(oak)
knitr::kable(elast,"simple",caption="Elasticity matrix")
```



Table: Elasticity matrix

               5-8cm      9-16cm     17-32cm     33-64cm       >64cm
--------  ----------  ----------  ----------  ----------  ----------
5-8cm      0.0335001   0.0000000   0.0000000   0.0422658   0.0139067
9-16cm     0.0557970   0.1006912   0.0000000   0.0000000   0.0000000
17-32cm    0.0003755   0.0557970   0.1815311   0.0000000   0.0000000
33-64cm    0.0000000   0.0000000   0.0561725   0.3252329   0.0000000
>64cm      0.0000000   0.0000000   0.0000000   0.0139067   0.1208234

We can sum up elasticities related to fecundity, stasis, and growth components so that we have an overview of their importance to the demography of our species:

```r
fecund <- sum(elast[1,4:5])
growth <- sum(elast[2,1],elast[3,1:2],elast[4,1:3],elast[5,1:4])
stasis <- sum(diag(elast))

pie(c(growth, fecund, stasis), col = c("#999999", "#E69F00", "#56B4E9"),
    labels=c("Growth", "Fecundity", "Stasis"), cex.lab=1.2, las=1, lwd=1.5)
```

![](sensitivity_analysis_files/figure-html/unnamed-chunk-10-1.jpeg)<!-- -->

And now we manually disturb populations by introducing some changes to be applied to each vital rate at a time (5%, 10%, and 15% change, respectively)

```r
changes <- c(1.05, 1.1, 1.5)

# This function will calculate the changed lambda for each scenario and save as a list 
out_matrix <- list()
for (x in 1:length(changes)) {
  result <- matrix(0, nrow=nrow(oak), ncol=nrow(oak))
  
  for (i in c(1:nrow(oak))) {
    for (j in c(1:nrow(oak))) {
      if (oak[i,j] == 0) {result[i,j] <- 0} else {
        matrix <- oak
        matrix[i,j] <- oak[i,j]*changes[x]
        result[i,j] <- Re(eigen(matrix)$values[1])
      }
    }
  }
  out_matrix[[x]] <- result
}

# Summarize population growth rate change scenarions from our list in a single matrix
summary <- matrix(NA, nrow=length(changes), ncol=length(which(as.vector(t(out_matrix[[1]])) >0)))
for (w in c(1: length(changes))) {
  summary[w,] <- as.vector(t(out_matrix[[w]]))[which(as.vector(t(out_matrix[[w]])) >0)]
}

colnames(summary) <- c("Surv_stas_5-8cm","Reprod_33-64cm","Reprod_>64cm","Surv_grow_5-8cm","Surv_stas_9-16cm",
                       "Surv_grow_5-8cm","Surv_grow_9-16cm","Surv_stas_17-32cm","Surv_grow_17-32cm","Surv_stas_33-64cm","Surv_grow_33-64cm","Surv_stas_>64cm")
```

We can now plot the changed $\lambda$ resulting from the rate change scenarios we simulated. Here we selected a comparison between growth rate changes for survival in 2 immature stages versus 1 mature stage of this population:

```r
lower <- 0.8 # To improve visualization, we choose a growth rate as the starting point for plotting results

barplot(summary[,c(4,7,12)]-lower, beside=TRUE, ylim=c(lower, 1.5), ylab="population growth rate",
        col=c("#56B4E9", "#009E73", "#F0E442"), offset= lower, cex.lab=1.2, las=1, lwd=1.5)
abline(h=lower, lwd=2)
abline(h= (Re(eigen(oak)$values[1])), lwd=2, col="red")
legend("topleft", inset=c(0.01,0.01), c("+5% rate change","+10% rate change",
                                         "+15% rate change"),
       fill=c("#56B4E9", "#009E73", "#F0E442"), cex=0.8, lty = c(NA,NA,NA,1))
text(4.5, 1.11, "Lambda", col="red")
```

![](sensitivity_analysis_files/figure-html/unnamed-chunk-12-1.jpeg)<!-- -->
And we conclude that small survival vital rate increases of 5% and 10% would not significantly change the population growth for these immature and mature stages. However, a 15% vital rate increase in mature survival would benefit the growth of this population more than the same extent of increase in immature survival. Thus, a management program focused on increasing the survival of mature oaks in 15% has a potential for positive impacts for the overall population growth.

## Resources
* popbio package: https://rdrr.io/cran/popbio/man/01Introduction.html

## References
Caswell, H. 2001. *Matrix Population Models* (2nd Edn.). Sinauer Associates, Sunderland, MA.

Caswell, H., & Caswell, H. (2019). Introduction: Sensitivity Analysis–What and Why?. *Sensitivity Analysis: Matrix Methods in Demography and Ecology*, 3-12.

Choi, W. I., Lee, D. H., Jung, J. B., & Park, Y. S. (2022). Oak decline syndrome in Korean forests: History, biology, and prospects for Korean oak wilt. *Forests, 13*(6), 964.

Clark, W. R., Bogenschutz, T. R., & Tessin, D. H. (2008). Sensitivity analyses of a population projection model of ring‐necked pheasants .*The Journal of Wildlife Management, 72*(7), 1605-1613.

Crouse, D. T., Crowder, L. B., & Caswell, H. (1987). A stage‐based population model for loggerhead sea turtles and implications for conservation. *Ecology, 68*(5), 1412-1423.

Finkbeiner, E. M., Wallace, B. P., Moore, J. E., Lewison, R. L., Crowder, L. B., & Read, A. J. (2011). Cumulative estimates of sea turtle bycatch and mortality in USA fisheries between 1990 and 2007. *Biological Conservation, 144*(11), 2719-2727.

Gonzalez de Leon, S., Herrera, I., & Guevara, R. (2016). Mating system, population growth, and management scenario for *Kalanchoe pinnata* in an invaded seasonally dry tropical forest. *Ecology and evolution, 6*(13), 4541-4550.

Manlik, O., Lacy, R. C., & Sherwin, W. B. (2018). Applicability and limitations of sensitivity analyses for wildlife management. *Journal of Applied Ecology, 55*(3), 1430-1440.

Marchioro, C. A., Santos, K. L., & Siminski, A. (2020). Present and future of the critically endangered Araucaria angustifolia due to climate change and habitat loss. *Forestry: An International Journal of Forest Research, 93*(3), 401-410.

Mills, L.S. (2012). *Conservation of wildlife populations*: Demography, genetics, and management. Wiley- Blackwell.

Paludo, G. F., Lauterjung, M. B., dos Reis, M. S., & Mantovani, A. (2016). Inferring population trends of *Araucaria angustifolia* (Araucariaceae) using a transition matrix model in an old-growth forest. *Southern Forests: a Journal of Forest Science, 78*(2), 137-143.

Thomas, P. 2013. *Araucaria angustifolia*. *The IUCN Red List of Threatened Species 2013*: e.T32975A2829141. https://dx.doi.org/10.2305/IUCN.UK.2013-1.RLTS.T32975A2829141.en.
