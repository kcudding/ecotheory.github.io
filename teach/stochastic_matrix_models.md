

## Environmental stochasticity in matrix models

### Environmental conditions are not constant in time
We saw in the section on unstructured population models, environmental stochasticity can act to change the rate of population increase. Similarly, we may expect impacts of temporal variation in environmental conditions on structured populations (e.g., good years may increase reproductive rate, bad years might decrease survivorship or somatic growth rates)

In this case our population size and structure at time t+1 will depend on a time varying projection matrix, A(t), as: $$\boldsymbol{n}(t+1)=\boldsymbol{A}(t)\boldsymbol{n}(t)=\boldsymbol{A}(t)\boldsymbol{A}(t-1) \ldots \boldsymbol{A}(0)\boldsymbol{n}_0$$ 


###  Simplest method of including temporal environmental stochasticity
The simplest method to add environmental variation is to use actual projection matrices measured from a number of different time periods. We can then randomly select a matrix to use for each projected time interval, multiply by the population vector and repeat the process many times. This method is analogous to randomly selecting a per capita growth rate for each time interval in an unstructured model, and similarly preserves any correlations between life history components.

In addition, this simple process can accommodate autocorrelation or regular cycles in environmental factors. For example we could randomly sample from matrices appropriate to each part of a cycle or estimate the correlation between different environmental conditions and ensure our sampling routine takes this correlation into account

### Other methods of incorporating temporal stochasticity 

There are at least two other methods of including environmental stochasticity. So, we have our simple method:

1. assume a limited # of discrete environmental states, and randomly draw a matrix that corresponds to the frequency and autocorrelation of those environmental states (see Morris and Doak 2002). This is probably only feasible for a small number of states (e.g. wet years vs dry years)).

However, if we know how vital rates depend on environmental variable (e.g., thru thermal performance curves), we can 

2. generate random environmental conditions with appropriate autocorrelation or cycles, calculate life history rates from those conditions, and then construct a projection matrix for that year. This may requires lots of data!

We can also, 
3. form matrices by drawing vital rates from appropriate statistical distributions (Caswell 2001, Morris and Doak 2002, Kaye and Pyke 2003).

### Stochastic population growth rate
Caswell (2019) provides proof that for small fluctuations, the long run stochastic growth rate does exist. We can estimate the stochastic population growth rate ($\lambda_S$) via simulation. To do so we need to
		1. project population size for many years using random matrices
		2. calculate the arithmetic mean of $ln(N_{t+1}/N_t)$ to approximate $\lambda_S$ as:  
	$$log \lambda_S \approx \lim_{t \to \infty}\frac{1}{t} log \left[\frac{N(t)}{N(0)}\right] $$

We will need tens of thousands of growth increments for reasonable estimates

We can also estimate the stochastic population growth rate ($\lambda_S$) using Tuljapurkar's small fluctuation approximation. This method requires that we assume that variation among the matrices for each time internal is not large, and that the matrix elements are uncorrelated from one time interval to the next. The formula is:  
 $$ ln \lambda_S \approx ln \bar{\lambda}_1-\frac{1}{2}\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right), $$ where $\bar{\lambda}_1$ is the dominant eigenvalue of the mean matrix $\bar{A}$ which we would obtain by averaging each element of our time interval specific matrices, where the we weight this mean by the frequency with which they are expected to occur. The quantity $\tau^2$ is given as: $\tau^2 = \sum^{S}_{i=1}\sum^{S}_{j=1}\sum^{S}_{k=1}\sum^{S}_{l=1}Cov(a_{ij}, a_{k,l})\bar{S}_{ij}\bar{S}_{lk}.$ 

The formula illustrates that for larger variance we have a smaller population growth rate. The term $\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ approximates the temporal variance of the log population growth rate caused by environmental stochasticity, and is the equivalent of $\sigma^2$ for unstructured populations. We can see from the equation $ln \lambda_S \approx ln \bar{\lambda}_1-\frac{1}{2}\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ , that an increase in variance, as measured by $\left(\frac{\tau^2}{\bar{\lambda}_1^2}\right)$ will decrease the population growth rate. 

Next, $\bar{S_{ij}}$ is the sensitivity of $\bar{\lambda}_1$ to changes in $\bar{a_{ij}}$. So, we expect variation in a given matrix element $a_{ij}$ will contribute to variation in the growth rate only to the extent that the population growth responds, or is sensitive, to that matrix element, and the variation is relatively large

### Covariance between matrix elements

It is reasonable to expect both positive and negative covariance between matrix elements (e.g., good years for reproduction in age 3 individuals also likely to be good for 4-year-olds). Further, good environmental conditions may be good for both reproduction and survival, or reproduction may come at a cost for somatic growth

In our equation the quantity $Cov(a_{ij}a_{kl})$ is the covariance between matrix elements $a_{ij}$ and $a_{kl}$. If $i \neq k$ and $j \neq l$ we have two different matrix elements and $Cov(a_{ij}a_{kl})$ is a measure of the tendency of the two elements to change in synchrony across time intervals. If $i=k$ and $j=l$, then we have the same element, and this is just a measure of variance over different time intervals

 A positive correlation between two matrix elements mean that either both will be high or low will tend to cause larger variation in the population growth rate, while a negative correlation will cause a tendency for the impacts of variation to to "cancel out" with reduced variation on population growth rate.


### Sensitivity analysis for stochastic matrix models
Caswell (2001) argued that deterministic sensitivity values for a mean matrix are generally good approximations for stochastic matrix models. This is probably reasonable for long-lived organisms that are reasonably buffered from environmental stochasticity, but less likely to be true for short-lived organisms highly influenced by environmental conditions. 
 
 It is more complicated to complete sensitivity analysis for stochastic models because we need to incorporate mean rates, variances, covariances, and characterisitics of the environmental temporal variation

 
 ### Sensitivity analysis of the long term growth rate
 
 When calculating the sensitivities of a stochastic matrix model, we will need to use the time‐specific stage distribution $\boldsymbol{w}(t)$, the time‐specific reproductive value vector $\boldsymbol{v}(t)$, and the time-specific population growth rate $\lambda_t$. This last term is calculated as 
 $\lambda_t=\frac{e^T \boldsymbol{n}(t+1)}{e^T \boldsymbol{n}(t)}$
where $e^T$ is a vector of ones (Tuljapurkar 1990).

Caswell (2005) showed that the sensitivity of long‐run population growth to a parameter $\theta$  (with current value $\\theta^*$) upon which some demographic rates depend is:
$$\frac{\partial ln \lambda_S}{\partial \theta}=\lim_{L\to\infty}\frac{1}{L}\sum^{L-1}_{t=0}\frac{\boldsymbol{v}^T(1+1)\frac{\partial \boldsymbol{A}(t)}{\partial \theta}\boldsymbol{w}(t)}{\lambda_t \boldsymbol{v}^T(t+1)\boldsymbol{w}(t+1)} $$

which is a stochastic analog of the previous expression for sensitivity analysis,  where the derivative should be understood as evaluated at $\theta$  =$\theta^*$  . 

The main approach to estimate  $\frac{\partial ln \lambda_S}{\partial \theta}$ is via stochastic simulations  (Caswell, 2001, Morris & Doak 2002) 

