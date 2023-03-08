

## Temporal environmental stochasticity in matrix models

### Environmental conditions are not constant in time
We saw in the section on unstructured population models, environmental stochasticity can act to change the rate of population increase. 

Similarly, we may expect impacts of temporal variation in environmental conditions on structured populations.

- e.g., good years may increase reproductive rate, bad years might decrease survivorship or somatic growth rates

In this case our population size and structure at time t+1 will depend on a time varying projection matrix, A(t), as: $$\boldsymbol{n}(t+1)=\boldsymbol{A}(t)\boldsymbol{n}(t)=\boldsymbol{A}(t)\boldsymbol{A}(t-1) \ldots \boldsymbol{A}(0)\boldsymbol{n}_0$$ 


###  Simplest method of including temporal environmental stochasticity
- simplest method to add environmental variation is to use actual projection matrices measured from a number of different time periods
- can then randomly select a matrix to use for each projected time interval, multiply by the population vector and repeat the process many times
- process is analogous to randomly selecting a per capita growth rate for each time interval in an unstructured model
- preserves any correlations between life history components

### Including environmental cycles or autocorrelation
- this simple process can accommodate autocorrelation or regular cycles in environmental factors
- for example we could randomly sample from matrices appropriate to each part of a cycle
- or estimate the correlation between different environmental conditions and ensure our sampling routine takes this correlation into account

### Methods of incorporating temporal stochasticity 
1. assume a limited # of discrete environmental states, and randomly draw a matrix that corresponds to the frequency and autocorrelation of those environmental states (see Morris and Doak 2002). Probably only feasible for a small number of states (e.g. wet years vs dry years))
2. if we know how vital rates depend on environmental variable (e.g., thru thermal performance curves), we can generate random environmental conditions with appropriate autocorrelation or cycles, calculate life history rates from those conditions, and then construct a projection matrix for that year. Requires lots of data!
3. form matrices by drawing vital rates from appropriate statistical distributions (Caswell 2001, Morris and Doak 2002, Kaye and Pyke 2003).

### the stochastic population growth rate
Caswell (2019)
$$ln \lambda_S =\lim_{t \to \infty}\frac{1}{t} log || \boldsymbol{A}(t-1) \ldots \boldsymbol{A}(0) \boldsymbol{n}_0||$$
-what is the specific norm here?

### estimate the stochastic population growth rate ($\lambda_S$): Simulation
- given a stochastic matrix model, we will want to estimate relevant quantities, the population growth is probably the most important of these
- to estimate via simulation:
		1. project population size for many years using random matrices
		2. calculate the arithmetic mean of $ln(N_{t+1}/N_t)$ to approximate $\lambda_S$ as:  
	$$log \lambda_S \approx \lim_{t \to \infty}\frac{1}{t} log \left[\frac{N(t)}{N(0)}\right] $$

- Need tens of thousands of growth increments for reasonable estimates

### estimate the stochastic population growth rate ($\lambda_S$): Tuljapurkar's approximation
-  can use an analytical technique for estimate if we assume that variation among the matrices for each time internal is not large, and that the matrix elements are uncorrelated from one time interval to the next, and 
- approximate using Tuljapurkar's (1982) method $$ ln \lambda_S \approx ln \bar{\lambda}_1-\frac{1}{2}\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right), $$ where $\bar{\lambda}_1$ is the dominant eigenvalue of the mean matrix $\bar{A}$ which we would obtain by averaging each element of our time interval specific matrices, where the we weight this mean by the frequency with which they are expected to occur. 
- The quantity $\tau^2$ is given as: $\tau^2 = \sum^{S}_{i=1}\sum^{S}_{j=1}\sum^{S}_{k=1}\sum^{S}_{l=1}Cov(a_{ij}, a_{k,l})\bar{S}_{ij}\bar{S}_{lk}.$ 



### more variance = lower population growth
-  The term $\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ approximates the temporal variance of the log population growth rate caused by environmental stochasticity, and is the equivalent of $\sigma^2$ for unstructured populations. 
- we can see from the equation $ln \lambda_S \approx ln \bar{\lambda}_1-\frac{1}{2}\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ , that an increase in variance, as measured by $\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ will decrease the population growth rate
- $\bar{S_{ij}}$ is the sensitivity of $\bar{\lambda}_1$ to changes in $\bar{a_{ij}}$
- so, we expect variation in a given matrix element $a_{ij}$ will contribute to variation in the growth rate only to the extent that the population growth responds, or is sensitive, to that matrix element, and the variation is relatively large

### Covariance between matrix elements
-reasonable to expect both positive and negative covariance between matrix elements



- e.g., good years for reproduction in age 3 individuals also likely to be good for 4-year-olds

- good environmental conditions may be good for both reproduction and survival, or reproduction may come at a cost for somatic growth

### Covariance between matrix elements
- in our equation the quantity $Cov(a_{ij}a_{kl})$ is the covariance between matrix elements $a_{ij}$ and $a_{kl}$. 

- If $i \neq k$ and $j \neq l$ we have two different matrix elements and $Cov(a_{ij}a_{kl})$ is a measure of the tendency of the two elements to change in synchrony across time intervals. If $i=k$ and $j=l$, then we have the same element, and this is just a measure of variance over different time intervals

-positive correlation between two matrix elements mean that either both will be high or low will tend to cause larger variation in the population growth rate

-negative correlation will cause a tendency for the impacts of variation to to "cancel out" with reduced variation on population growth rates


### Sensitivity analysis for stochastic matrix models
- Caswell (2001) argued that deterministic sensitivity values for a mean matrix are generally good approximations for stochastic matrix models
- probably reasonable for long-lived organisms that are reasonably buffered from environmental stochasticity
- less likely to be true for short-lived organisms highly influenced by environmental conditions
 - more complicated to complete sensitivity analysis  because need to incorporate mean rates, variances, covariances, and characterisitics of the environmental temporal variation

 
 ### Sensitivity analysis of the long term growth rate
 
 
 When calculating the sensitivities of a stochastic matrix model, we will need to use the time‐specific stage distribution $\boldsymbol{w}(t)$, the time‐specific reproductive value vector $\boldsymbol{v}(t)$, and the time-specific population growth rate $\lambda_t$. This last term is calculated as 
 $\lambda_t=\frac{e^T \boldsymbol{n}(t+1)}{e^T \boldsymbol{n}(t)}$
where $e^T$ is a vector of ones (Tuljapurkar 1990).

Caswell (2005) showed that the sensitivity of long‐run population growth to a parameter $\theta$  (with current value $\\theta^*$) upon which some demographic rates depend is:
$$\frac{\partial ln \lambda_S}{\partial \theta}=\lim_{L\to\infty}\frac{1}{L}\sum^{L-1}_{t=0}\frac{\boldsymbol{v}^T(1+1)\frac{\partial \boldsymbol{A}(t)}{\partial \theta}\boldsymbol{w}(t)}{\lambda_t \boldsymbol{v}^T(t+1)\boldsymbol{w}(t+1)} $$

which is a stochastic analog of the previous expression for sensitivity analysis,  where the derivative should be understood as evaluated at $\theta$  =$\theta^*$  . 

The main approach to estimate  $\frac{\partial ln \lambda_S}{\partial \theta}$ is via stochastic simulations  (Caswell, 2001, Morris & Doak 2002) 

Giaimo, S., & Traulsen, A. (2022). Age‐specific sensitivity analysis of stable, stochastic and transient growth for stage‐classified populations. _Ecology and Evolution_, _12_(12), e9561.


### Sensitivity analysis of the time-specific growth rate
Finally, time‐specific growth (sometimes called the transient population growth rate) $ln \lambda_t$  is susceptible of sensitivity analysis too. Combining and differentiating Equations [3](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-disp-0003) and [5](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-disp-0005), Caswell ([2007](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-bib-0010), eq. 43) found that
$$\frac{\partial ln \lambda_S}{\partial \theta}=\frac{e^T}{N(t+1)}\frac{\partial \boldsymbol{n}(t+1)}{\partial \theta} - \frac{e^T}{N(t)}\frac{\partial \boldsymbol{n} (t)}{\partial \theta}$$

where the vectors $\frac{\partial \boldsymbol{n}(t)}{\partial \theta}$ are computed via the recursion

$$\frac{\partial \boldsymbol{n}(t+1)}{\partial \theta}=\frac{\partial \boldsymbol{A}(t)}{\partial \theta}\boldsymbol{n}(t)+\boldsymbol{A}(t)\frac{\partial \boldsymbol{n}(t)}{\partial \theta}$$

from given initial vectors $\boldsymbol{n}(0)$ and $\frac {\partial \boldsymbol{n}𝐧(0)}{\partial \theta}$ and 𝜕𝐧(0)/𝜕𝜃. Caswell ([2007](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-bib-0010)) gives information on how to set the latter vector. A particularly relevant case is when 𝜃 has no effect on the initial population and 𝜕𝐧(0)/𝜕𝜃 is the zero vector. The derivatives in Equations [7](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-disp-0007) and [8](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9763023/#ece39561-disp-0008) should be understood as evaluated at 𝜃's current value.

We can state the sesitivtiy of matrix elemt


### Example: reintroduction of critically endangered plant
Bialic-Murphy, L., Knight, T. M., Kawelo, K., & Gaoue, O. G. (2022). The Disconnect Between Short-and Long-Term Population Projections for Plant Reintroductions. _Frontiers in Conservation Science_, _2_, 124.

-"stochastic transient projections are more appropriate than asymptotic projections to characterize the near-term population growth rate because it explicitly incorporates the effects of the initial stage structure and captures more realistic environmental variation based on current field conditions. 

-"We also illustrate that the near-term population projections of plant reintroductions established with mature individuals can be overly optimistic of long-term outcomes.

### References
Bialic-Murphy, L., Knight, T. M., Kawelo, K., & Gaoue, O. G. (2022). The Disconnect Between Short-and Long-Term Population Projections for Plant Reintroductions. _Frontiers in Conservation Science_, _2_, 124.

Caswell, H. (2001). Matrix population models: construction, analysis, and interpretation. 2nd edn Sinauer Associates. _Inc., Sunderland, MA_.

Kaye, T. N., & Pyke, D. A. (2003). The effect of stochastic technique on estimates of population viability from transition matrix models. _Ecology_, _84_(6), 1464-1476.

Morris, W. F., & Doak, D. F. (2002). Quantitative conservation biology. _Sinauer, Sunderland, Massachusetts, USA_.

Tuljapurkar, S. D. (1982). Population dynamics in variable environments. II. Correlated environments, sensitivity analysis and dynamics. _Theoretical Population Biology_, _21_(1), 114-140.

Tuljapurkar, S., & Haridas, C. V. (2006). Temporal autocorrelation and stochastic population growth. _Ecology Letters_, _9_(3), 327-337.
_________


Environmental stochasticity can be incorporated into a model by making the parameters  process is analogous to randomly selecting a per capita growth rate for each time interval in an unstructured model
random variables. As an example, consider making the reproductive rate of adults >2 years old a  
random variable with a normal distribution with mean BA>2 and standard deviation SD(BA>2).

Another distribution  
useful for generating random survival rates (and possibly reproductive rates in some  
circumstances) is the beta distribution. Random beta variables can be generated in spreadsheets  
with the BETAINV function. Advantages of the beta distribution are that random values can be  
constrained to specified intervals. For example, survival rates can be constrained to the interval  
0-1. T