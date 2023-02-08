---
title: "Unstructured Stochasticity"
author: "Zitao He"
date: "2023-01-27"
---


# Module 1: Unstructured Population Models
## Chapter 3: Population dynamics and stochasticity
### Deterministic vs. stochastic factors
- **Deterministic factors** are predictable, such as predation, competition, etc.
- **Stochastic factors** are unpredictable

### Basic forms of stochasticity and definitions
#### Demographic stochasticity

**Demographic stochasticity** refers to chance events of individual mortality and reproduction (inevitable deviation in mean birth and death rates) (Lande *et al*., 2003). 

- Only significant in small populations
- *Example* 1: Flipping a coin 10,000 times, one will get approximately 5,000 times heads; flipping the same coin 100 times, there could be some deviations from the expected 50:50; flipping the same coin 10 times, it is not suprising that one only gets 2 heads. The probability of getting head is approaching 0.5 as the number of trials increases. Let's do some experiments with R:

```r
# Toss a coin 10/100/10,000 times
# Generate random numbers from {0,1} with the same probability
# We assume: 1 - heads, 0 - tails
toss10 <- sample(c(0,1), size = 10, prob = c(0.5,0.5), replace = TRUE)
toss100 <- sample(c(0,1), size = 100, prob = c(0.5,0.5), replace = TRUE)
toss10k <- sample(c(0,1), size = 10000, prob = c(0.5,0.5), replace = TRUE)

# Record the results in a matrix
# Notice: sum = number of 1's = number of heads
results <- data.frame(c(sum(toss10), 10-sum(toss10)),
                      c(sum(toss100), 100-sum(toss100)),
                      c(sum(toss10k), 10000-sum(toss10k)))
colnames(results) <- c("10 tosses", "100 tosses", "10,000 tosses")
rownames(results) <- c("heads", "tails")
results
```

```
##       10 tosses 100 tosses 10,000 tosses
## heads         7         52          5051
## tails         3         48          4949
```
- *Example 2*: The expected sex ratio for a newborn is 50:50. When there are 3 new births, we cannot have 50% males and 50% females. Unbalanced sex ratio will influence future birth rate, especially in a small population. 
- *Example 3*: A death rate of 0.2 does not mean after a year an animal is 0.8 alive--it either survives or dies. When the population size is large, we may use the product of the total populatiom and a mean birth/death rate to estimate the number of births/deaths. However, such estimation is not accurate when the population size is small. (A difference of 2 deaths might not seem to be a big issue in a population of size 1000, but will be significant in a population of size 20.)

#### Environmental stochasticity

**Environmental stochasticity** often refers to temporal fluctuations in the probability of mortality and reproduction (unpredictable catastrophes) (Lande *et al*., 2003)

- Often driven directly or indirectly by weather
- *Example 1*: Climate factors have a strong influence on the ecology of red deer on Rum (Albon *et al*., 1987). Real-world data between 1971 and 1991 has shown that the changes in red deer population size correlates strongly with annual rainfall (Benton *et al*., 1995).

![Figure: © Charles J. Sharp, [Red deer (_Cervus elaphus_)](https://commons.wikimedia.org/wiki/File:Red_deer_(Cervus_elaphus)_young_stag.jpg), [Creative Commons  CC-BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/)](red_deer.jpg)

- *Example 2*: Cold-blooded insects like mosquitoes thrive in hot and humid weather, which results in the seasonality of many vector-borne diseases, such as malaria and dengue. There are massive research on modelling the mosquito population dynamics and how they affect the transmission of those diseases. An example would be Beck-Johnson *et al*. (2013).


#### Sampling error

**Sampling error** (or sampling variance) is the measurement error in estimates of population size or density. Some researchers categorized it as a basic form of stochasticity (Lande *et al*., 2003), while some distinguished it from deterministic and stochastic factors (Mills, 2007).

### Implications of variation in population growth
- An obvious outcome is that future population size outcomes become more uncertain and more variable.
- A less intuitive outcome is that the likelihood of any particular population size at time $t$ in the future becomes more skewed. (Specifically, most populations being relatively small, with a tiny fraction being huge.) We will discuss it soon.

### Stochastic effects to population growth rates

To answer the question why population size tends to shrink because of stochasticity, we need to understand two important concepts--arithmetic and geometric means.

#### Arithmetic mean vs. geometric mean
- Let $\lambda_A$ and $\lambda_G$ denote the arithmetic and geometric mean, respectively. We have the following definitions:
	$$\lambda_A=\frac{1}{k}\sum_{i=1}^k\lambda_i,$$
	$$\lambda_G=\left(\prod_{i=1}^k\lambda_i\right)^{\frac{1}{k}}.$$
- *Example*: Consider $N_{t}=\lambda_tN_{t-1}$, where $N_t$ is the population at time $t$, and during each time interval $(t-1,t)$ the growth rate is $\lambda_t$. Assume $\lambda_t=1.55$ or $\lambda_t=0.55$ with the same probability. Assuming that the population grows at a constant arithmetic mean rate $\lambda_A=(1.55+0.55)/2=1.05$, the population at $t=16$ is
	$$N_{16}=1.05^{16}N_0=2.18N_0.$$
	Instead, if we assume that the growth rate alternated between $1.55$ and $0.55$, the population at $t=16$ becomes
	$$N_{16}=1.55^8\times0.55^8N_0=[(1.55\times0.55)^{1/2}]^{16}N_0=0.28N_0,$$
	which indicates that the variation in population growth leads to a likely decline for the population, even though the (arithmetic) average growth rate is larger than 1 (Mills, 2007). In fact, the geometric mean growth rate is $\lambda_G=(1.55\times0.55)^{1/2}\approx 0.9233$. Here we simulate 100 possible population changes during a time period of 16 years. From the left boxplot we can see that only 4 of them (circles) end up with a relatively large population, while the majority stay quite small. We remove the outliers (extreme cases) and plot the right boxplot, where we can see that most of the populations actually shrink, and the median (bald horizontal line) is a bit less than 0.3, which is consistent with the above calculation.

```r
# Initialize
N0 <- 1
lambda <- matrix(rbinom(1600, 1, 0.5), ncol = 16)
lambda[lambda==1] <- 1.55
lambda[lambda==0] <- 0.55
# lambda is a 100-by-16 matrix
# Each row represents a possible population change in 16 years

# Calculate the outcomes, and plot
outcome <- N0*apply(lambda, 1, prod)
par(mfrow=c(1,2))
boxplot(outcome, main = "Boxplot with outliers", 
        ylab = "Final population size")
boxplot(outcome, outline = FALSE, main = "Boxplot without outliers")
```

![Figure: Boxplots of final population sizes. (left) All outcomes; (right) outcomes with outliers (extreme cases) ignored](popsize_boxplot.png){width=80%}

- *Conversion between $\lambda$ and $r$*: It would be helpful to know the relationship between the arithmetic mean of $r$ and the geometric mean of $\lambda$. Recall that $r=\ln\lambda$, so
	$$\ln(\lambda_1\lambda_2\cdots\lambda_k)=\ln\lambda_1+\ln\lambda_2+\cdots+\ln\lambda_k=r_1+r_2+\cdots+r_k,$$
	which gives
	$$\ln(\lambda_1\lambda_2\cdots\lambda_k)^{1/k}=\frac{1}{k}\ln(\lambda_1\lambda_2\cdots\lambda_k)=\frac{1}{k}(r_1+r_2+\cdots+r_k),$$
	and thus
	$$\ln\lambda_G=r_A.$$
- *Variation around $\lambda$*: An interesting but less intuitive fact is that when fixing the arithmetic mean of growth rates, highly variable growth rates will more likely result in a smaller final population. In other words, increasing the variance of the growth rates ($\sigma_\lambda^2$) makes the geometric mean growth rate less than the arithmetic mean. Let $\lambda_t=\lambda_A+\epsilon_t$, where $\epsilon_t$ is the deviation of $\lambda_t$ from the arithmetic mean $\lambda_A$ with zero mean. Using the Taylor expansion of $\ln(1+x)$, one could obtain
	$$\begin{aligned}\ln\lambda_t & =\ln\lambda_A+\ln(1+\epsilon_t/\lambda_A)\\~ & =\ln\lambda_A+
		\epsilon_t/\lambda_A-(\epsilon_t/\lambda_A)^2/2+O(\epsilon_t^3),\end{aligned}$$
	where $O(\epsilon_t^3)$ denotes the higher order terms. Hence, taking the expectation of both sides gives
	$$r_A=E(\ln\lambda_t)\cong\ln\lambda_A-\frac{E[(\lambda_t-\lambda_A)^2]}{2\lambda_A^2}=\ln\lambda_A-\frac{\sigma_\lambda^2}{2\lambda_A^2},$$
	which further gives
	$$\lambda_G\cong\exp\left(\ln\lambda_A-\frac{\sigma_\lambda^2}{2\lambda_A^2}\right).$$
	In fact, the geometric mean is **always no larger** than the arithmetic mean (and they are equal if and only if every term is the same).

#### Temporal autocorrelation
- Above examples assume that $r_t$ does not depend on previous growth rates, nor will it influence subsequent growth rates. The autocorrelation describes the relationship between $r_t$ and $r_{t+\tau}$, its value at a time lag $\tau$. One way to incorporate teporal autocorrelation is to:
	$$r_{t+\tau}=r_A+\rho(r_{t}-r_A)+\epsilon_{t+\tau},$$
	where $\rho$ is the coefficient of lag-$\tau$ autocorrelation, and $\epsilon_t\sim N(0,\sigma_\epsilon^2)$ is white noise with zero mean and constant variance. An example would be the case $\tau=1$ (lag-1 autocorrelation), where $r_{t+1}=r_A+\rho(r_t-r_A)+\epsilon_{t+1}$. When $\rho=0$, $r_{t+1}=r_A+\epsilon_{t+1}$ and there is no temporal autocorrelation. Here we present examples of exponential growth rates with zero autocorrelation and positive lag-1 autocorrelation.

```r
# We assume that the mean exponential growth rate r_A = 0.3,
# and the noise term epsilon_t is a standard normal random variable,
# We look at a time period of 20 years
rA <- 0.3
e <- rnorm(20, mean = 0, sd = 1)
r <- data.frame(year = 1:20, zero = rA + e)
```
```r
# Calculate exponential growth rates with positive lag-1 autocorrelation
# We compare different coefficients rho = 0.2, 0.5, 0.8
pos1 = replicate(20, rA + e[1])
for (i in 2:20) {
  pos1[i] <- r[i,'zero'] + 0.2*(pos1[i-1] - rA)
}
r$pos1 <- pos1

pos2 = replicate(20, rA + e[1])
for (i in 2:20) {
  pos2[i] <- r[i,'zero'] + 0.5*(pos2[i-1] - rA)
}
r$pos2 <- pos2

pos3 = replicate(20, rA + e[1])
for (i in 2:20) {
  pos3[i] <- r[i,'zero'] + 0.8*(pos3[i-1] - rA)
}
r$pos3 <- pos3

# Plot the results
matplot(r[2:5], type = "b", pch=1, col = 1:4,
        main = 'Exponential growth rates with different lag-1 autocorrelation coefficients',
        xlab = 'year', ylab = 'exponential growth rate', lty = c(1,2,2,2))
legend(x = "bottomright", legend = c('rho = 0', 'rho = 0.2', 'rho = 0.5', 'rho = 0.8'),
       col = 1:4, lty = c(1,2,2,2))
```

![Figure: Plots of exponential growth rates with different levels of positive lag-1 autocorrelation](autocorrelation.png){width=80%}

### Estimating population growth rates

Now we move on to an important section, where we try to estimate the growth rate from data, assuming some very simple model. But first, let's talk about different types of errors we might encounter.

#### Process error

**Process error** results from variation in true population size due to biotic or abiotic processes (Ahrestani *et al*., 2013).

- Environmental and demographic stochasticity are examples of process errors
- When only process error exists, the population at each time $t$, $N_t$, is known and accurate. The growth rate $\lambda_t$ is a random variable. For example, a geometric model with only process error can be described as
	$$\begin{aligned}N_{t+1} & =\lambda_tN_t,\\\lambda_t & \sim N(\bar\lambda,\sigma_p^2),\end{aligned}$$
	where $\lambda_t$ follows a normal distribution with mean $\bar\lambda$ and variance $\sigma_p^2$.
- Since the population at each time $t$, $N_t$, is known and accurate, we can calculate the estimated growth rate using geometric mean
	$$\hat\lambda=\left(\prod_{i=1}^t\frac{N_{i}}{N_{i-1}}\right)^{\frac{1}{t}},$$
	or equivalently,
	$$\hat r=\frac{1}{t}\sum_{i=1}^t\ln\frac{N_i}{N_{i-1}}.$$
- We can notice that the estimated growth rate is only related to the initial and the final population size, as all the terms between them can be cancelled out. In other words,
	$$\hat\lambda=\left(\frac{N_t}{N_0}\right)^{\frac{1}{t}}$$
	and
	$$\hat r=\frac{\ln N_t-\ln N_0}{t}.$$
	Here is a toy example: Suppose we observe the following number of fish in a lake during the first 8 years. Assuming a geometric model, what is the average growth rate?
	
```r
# Create a dataframe
N <- data.frame(year = 0:8,
                size = c(100, 120, 98, 152, 298, 302, 383, 575, 728))

# Calculate annual growth rates
lambda <- replicate(8, 0)
for (i in 1:8) {
  lambda[i] <- N[i+1,'size']/N[i,'size']
}

# Calculate the geometric mean growth rate
lambda_avg <- prod(lambda)^(1/8)
# The average growth rate is 1.2816, which is the same as (728/100)^(1/8)

# Calculate the theoretical population size, assuming geometric growth
N$pred <- 100*lambda_avg^N$year

# Plot the results
plot(N$year, N$size, pch = 19, col = 'blue', main = 'Population growth with process error only',
     xlab = 'year', ylab = 'size')
lines(N$year, N$pred, col = 'red', lty = 2)
legend(x = 'topleft', legend = c('data', 'prediction'), col = c('blue', 'red'), lty = c(1, 2))
```

![Figure: Plots of data and the predicted population growth using a geometric model, when considering process error only](process_error_example.png){width=80%}

#### Observation error

**Observation error** results from variation in the methodology used to obtain the population size (Ahrestani *et al*., 2013).

- Examples of observation error include difficulty in counting animals, which might due to lack of technical expertise, insufficient funding, etc.
- When only observation error exists, the growth rate is accurate. A possible geometric model with only observation error can be described as
	$$\begin{aligned}\ln N_t & =\ln N_0+rt+\eta_t,\\\eta_t & \sim N(0,\sigma_o^2),\end{aligned}$$
	where $\eta_t$ follows a normal distribution with mean 0 and variance $\sigma_o^2$. Here we ignore the subscript of $r$ as we assume the growth rate is some constant. We could also convert the above equation to
	$$N_{t+1}=\lambda^tN_te^{\eta_t},$$
	where $e^{\eta_t}>0$ so that the population is always non-negative.
- The equation $\ln N_t=\ln N_0+rt+\eta_t$ is in the form of a linear model in which $\ln N_t$ is the response variable and $t$ is the predictor variable. Using simple linear regression, the slope of the fitted function is the estimated $r$. Moreover, the $y$-intercept is the estimated $\ln N_0$. Here we provide another toy example with the same data as the previous example on process error:

```r
# Create a dataframe, and calculate the log-transformed population sizes
N <- data.frame(year = 0:8,
                size = c(100, 120, 98, 152, 298, 302, 383, 575, 728))
N$log <- log(N$size)

# Run a linear regression with log-transformed population sizes as response variables
# and year as predictor variables
lm1 <- lm(log~year, data = N)
# After running the regression, we obtain the following coefficients:
# (Intercept) 4.40771
# year        0.26756

# Plot the results
plot(N$year, N$log, pch = 19, col = 'blue', main = 'Population growth with observation error only',
     xlab = 'year', ylab = 'log-transformed size')
abline(lm1, col = 'red', lty = 2)
legend(x = 'topleft', legend = c('data', 'prediction'), col = c('blue', 'red'), lty = c(1, 2))
```

![Figure: Plots of data and the predicted population growth using a geometric model, when considering observation error only](observation_error_example.png){width=80%}

### Paper discussion
Drever, M. C., Clark, R. G., Derksen, C., Slattery, S. M., Toose, P. and Nudds, T. D. (2012) Population vulnerability to climate change linked to timing of breeding in boreal ducks, _Global Change Biology_, **18**:480--492.

![© Nrik Kiran, [Mallard (_Anas platyrhynchos_)](https://commons.wikimedia.org/wiki/File:Mallard_(Anas_platyrhynchos)_02.jpg), [Creative Commons  CC-BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/)](mallard.jpg){height=300 width=450}
![© Judy Gallagher, [American Wigeon (_Anas americana_)](https://commons.wikimedia.org/wiki/File:American_Wigeon_-_Anas_americana,_Oakley_Street,_Cambridge,_Maryland.jpg), [Creative Commons  CC-BY-2.0 license](https://creativecommons.org/licenses/by/2.0/)](american_wigeon.jpg){height=300 width=450}

![© MPF, [Greater Scaup (_Aythya marila_)](https://commons.wikimedia.org/wiki/File:2017-03-24_Aythya_marila,_male,_Killingworth_Lake,_Northumberland_18.jpg), [Creative Commons  CC-BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/)](scaup.jpg){height=300 width=450}
![© Andy Reago & Chrissy McClarren, [Surf scoter (_Melanitta perspicillata_)](https://commons.wikimedia.org/wiki/File:Surf_Scoters_in_the_fog_(43836307370).jpg), [Creative Commons  CC-BY-2.0 license](https://creativecommons.org/licenses/by/2.0/)](scoter.jpg){height=300 width=450}

Figures: (top left) © Nrik Kiran, [Mallard (_Anas platyrhynchos_)](https://commons.wikimedia.org/wiki/File:Mallard_(Anas_platyrhynchos)_02.jpg), [Creative Commons  CC-BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/); (top right) © Judy Gallagher, [American Wigeon (_Anas americana_)](https://commons.wikimedia.org/wiki/File:American_Wigeon_-_Anas_americana,_Oakley_Street,_Cambridge,_Maryland.jpg), [Creative Commons  CC-BY-2.0 license](https://creativecommons.org/licenses/by/2.0/); (bottom left) © MPF, [Greater Scaup (_Aythya marila_)](https://commons.wikimedia.org/wiki/File:2017-03-24_Aythya_marila,_male,_Killingworth_Lake,_Northumberland_18.jpg), [Creative Commons  CC-BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/); (bottom right) © Andy Reago & Chrissy McClarren, [Surf scoter (_Melanitta perspicillata_)](https://commons.wikimedia.org/wiki/File:Surf_Scoters_in_the_fog_(43836307370).jpg), [Creative Commons  CC-BY-2.0 license](https://creativecommons.org/licenses/by/2.0/)


#### Snapshot of the study
- Ducks are perfect test objects because they exhibit diverse breeding strategies.
- The authors examined how snow cover duration affected population dynamics of duck species breeding in the western boreal forest of North America, 1973--2007.
- Four species of ducks (mallard, American wigeon, scaup and scoter) were studied. Study areas (Alberta, Saskatchewan, Manitoba, Northwest Territories, Yukon and Alaska) were further divided into different survey strata.
- Four models were developed based on the existence of variations in (a) density dependence, and/or (b) effect of snow cover duration over different strata.
- The effect of snow cover duration on population dynamics tended to be consistent across stratam but differed by species.
	- For mallard, neither density dependence nor effect of snow cover duration varied among strata.
	- For American wigeon, the effect of density dependence varied strongly among strata, while the effect of snow cover varied weakly.
	- For fixed-window species (scaup and scoter), the effect of density dependence varied among strata, but the effect of snow cover were similar among strata.
- Population fluctuations of scaups and scoters were positively linked to spring snow cover duration. Duck densities were higher after springs with longer snow cover duration. Similar but weaker effect of snow cover duration were observed in American wigeon populations. Mallard population dynamics were negatively associated with spring snow cover duration.

### References
Ahrestani, F., Hebblewhite, M. and Post, E. (2013) The importance of observation versus process error in analyses of global ungulate populations. *Sci Rep*, **3**:3125.

Albon, S. D., Clutton-Brock, T. H. and Guinness, F. E. (1987) Early development and population dynamics in red deer. II. Density-independent effects and cohort variation, *J. Anim. Ecol.*, **56**: 69--81.

Beck-Johnson, L. M., Nelson, W. A., Paaijmans, K. P., Read, A. F., Thomas, M. B. and Bjonstad, O. N. (2013) The Effect of Temperature on Anopheles Mosquito Population Dynamics and the Potential for Malaria Transmission. *PLoS ONE*, **8**(11):e79276.

Benton, T. G., Grant, A. and Clutton-Brock, T. H. (1995) Does environmental stochasticity matter? Analysis of red deer life-histories on Rum, *Evolutionary Ecology*, **9**:559--574.

Beverton, R. and Holt, S. J. (1957) *On the Dynamics of Exploited Fish Populations*. Ministry of Agriculture, Fisheries and Food, London, UK.

Case, T. (2000) *An Illustrated Guide to Theoretical Ecology*, Oxford University Press.

Lande, R., Engen, S. and Saether, B. (2003) *Stochastic Population Dynamics in Ecology and Conservation*, Oxford Series in Ecology and Evolution.

Mills, L. S. (2007) *Conservation of Wildlife Populations: Demography, Genetics, and Management*, Wiley-Blackwell Publishing.
