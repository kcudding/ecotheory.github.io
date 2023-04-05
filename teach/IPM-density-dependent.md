---
title: "IPM-density-dependent"
author: "Eddie Wu"
date: "2023-04-05"
output: 
  html_document:
    toc: true
    toc_float:
      collapsed: false
      smooth_scroll: false
    keep_md: yes
---



## Density dependence in IPM

Like in unstructured population models and matrix population models, density-dependence also occurs in integral projection models. However, a general guide to building density-dependent IPMs is impossible, as there are too many possibilities. Any demographic rate can be affected by competition, and the dependence can take many possible forms. So instead, we will present this section by first introducing a famous example of density-dependent recruitment on Platte thistle (*Cirsium canescens*). Then, we will explain the theories behind the model construction.


### Modeling density dependence

Platte thistle (*Cirsium canescens*) is a native thistle species endemic to North America. Its population demography is strongly affected by an invasive herbivore insect *Rhinocyllus conicus*. Rose et al. (2005) tried to determine how demographic rates of Platte thistle varied with plant size and damage by *R. conicus*.

![© Jerry Oldenettel, [Cirsium canescens. AKA(Platt Thistle).](https://www.flickr.com/photos/jroldenettel/1734332992), [Creative Commons CC BY-NC-SA 2.0 license](https://creativecommons.org/licenses/by-nc-sa/2.0/)](platte_thistle_1.jpg){width=70%}

#### Recruitment with density dependence

For a plant that reproduces by seeds, the number of new recruits in a given year is proportional to the number of seeds produced the previous year. This means that the recruitment is density-dependent. Based on Rose et al. (2005), the relationship between the number of new recruits at year $t+1$ and the number of seeds at time $t$ is $Recruits = Seeds^{0.67}$ for *Cirsium canescens*.

![](IPM-density-dependent_files/figure-html/unnamed-chunk-1-1.jpeg)<!-- -->

Now we can define the density-independent demographic functions. (Rose et al., 2005)

* Flowering probability $p_b(z)$: logit $p_b = −10.22 + 4.25z$

* Mean *R. conicus* eggs per plant: $ε(z) = exp(e0 + 1.71z)$

* Seedling size $c_0(z')$: $z' ∼ Norm(μ = 0.75, σ^2 = 0.17)$

* Survival $s(z)$: logit $s = −0.62 + 0.85z$

* Growth $G(z',z)$: $z' ∼ Norm(μ = 0.83 + 0.69z, σ^2 = 0.19)$

Seed set number is a little more complicated to define. Two factors can impact the seed set number: the plant size and the invasive *R. conicus* egg number. Thus, the seed set function $b(z)$ can be defined as a result of two submodels: A function of plant size; and a negative binomial distribution for the number of *R. conicus* eggs with mean depending on plant size.

* Seed set number $b(z)$: $b(z) = e^{(-0.55+2.02z)}\times(1+\frac{ε(z)}{16})^{-0.32}$

, where $z$ is the size measure, $ε$ is the mean number of *R. conicus* eggs oviposited on a plant of size $z$.


<br>

#### Fit an IPM model with density-dependent recruitment

Now we can construct an IPM with density-dependent recruitment. The survival kernel P is density-independent,

$$ P(z',z) = (1-p_b(z))s(z)G(z',z) $$

The total number of seeds is

$$ S(t) = \int_L^U{p_b(z)b(z)n(z,t)}dz$$

and they will produce $S(t)^{0.67}$ recruits whose size distribution is $c_0(z')$.

Combining the recruits and the survivors, we have

$$ n(z',t+1) = c_0(z')S(t)^{0.67} + \int_L^U{P(z',z)n(z,t)}dz\\
= c_0(z')(\int_L^U{p_b(z)b(z)n(z,t)}dz)^{0.67} + \int_L^U{(1-p_b(z))s(z)G(z',z)n(z,t)}dz $$


### Theories behind density-dependent IPM models

From the previous example, we built an IPM with density-dependent recruitment. For IPMs, recall that the kernel $K$ is consisted of two components: survival $P$ and reproduction $F$. We can incorporate density-dependence into either one of these two kernels, or both of them.

#### IPMs with density-dependent reproduction

For plants such as platte thistle, where competition only affects seedling establishment. The survival kernel $P$ is density-independent and the reproduction kernel $K$ is density-dependent. They can be written as

$$ P(z',z) = (1-p_b(z))s(z)G(z',z) $$

$$ F(z',z,N) = p_r(N)c_0(z')p_b(z)b(z) $$


To generalize, this type of density-dependent IPM can be written as

$$ n(z',t+1) = c_0(z')p_r(N(t))N(t) + \int_L^U{P(z',z)n(z,t)dz} $$

where $N(t)$ is the total seed production

$$ N(t) = \int_L^U{p_b(z)b(z)n(z,t)}dz $$

and $p_r$ is the density-dependent recruitment probability, generally a decreasing function of population density $N$.


#### IPMs with density-dependent survival

IPMs with density-dependent survival kernel are far less common, but can be constructed the same way. Recall that the survival kernel $P(z',z)$ can be further separated into survival probability $s(z)$ and size transition $G(z',z)$. Biologically speaking, individual survival is more likely to be affected by population density, so we incorporate density-dependence in the survival probability component.

$$ P(z',z, N) = s(z,N)G(z',z) $$

where $s(z,N)$ can be written as a function of size and population density

$$ logit (s(z,N)) = \alpha_s + \alpha_{s,z} + \beta_s^z*z + \beta_s^N*N $$


### Application of density-dependent IPM to an ecological problem

Here we go back to the same soay sheep example that we have been discussing. In the soay sheep population, density affects three processes in the kernel:

* The probability that a newborn lamb successfully recruits into the population, $p_r$.

* The size distribution of new recruits, $C_0$.

* The survival of adults $s$.

![(a) Density-dependent adult survival (solid line), and recruitment probability (dashed line) plotted over the observed range of female densities. (b) Offspring mean mass (as a proxy for offspring mean size) plotted over the observed range of female densities. Note that adult survival and offspring size are plotted for a typical-size adult female, z = 2.9. (code adapted from Ellner et al., 2016)](soay_ipm_dd.jpeg)

To construct a density-dependent IPM model on soay sheep, we first define the true population parameters (data and code from Ellner et al., 2016):

```r
m.par.true <- c(## survival (density dependent)
                surv.int= 1.06e+0, surv.z= 2.09e+0, surv.Nt= -1.80e-2,
                ## growth (NOT density dependent)
                grow.int= 1.41e+0, grow.z= 5.57e-1, grow.sd= 7.99e-2,
                ## reproduce or not (NOT density dependent)
                repr.int= -7.23e+0, repr.z= 2.60e+0,                
                ## recruit or not (density dependent)
                recr.int= 4.43e+0, recr.Nt= -9.19e-3,
                ## recruit size (density dependent)
                rcsz.int= 5.40e-1, rcsz.z= 7.10e-1,
                rcsz.Nt= -6.42e-4, rcsz.sd= 1.59e-1)
```

From literature data we can define the three density-dependent demographic functions:

```r
## Recruitment function (N.B - from birth in spring to first summer), logistic regression
pr_z <- function(Nt, m.par) {
    linear.p <- m.par["recr.int"] + m.par["recr.Nt"] * Nt
    p <- 1/(1+exp(-linear.p))
    return(p)
}

## Recruit size function
c_z1z <- function(z1, z, Nt, m.par) {
    mean <- m.par["rcsz.int"] + m.par["rcsz.Nt"] * Nt + m.par["rcsz.z"] * z
    sd <- m.par["rcsz.sd"]
    p.den.rcsz <- dnorm(z1, mean = mean, sd = sd)
    return(p.den.rcsz)
}

## Survival function, logistic regression
s_z <- function(z, Nt, m.par) {
    linear.p <- m.par["surv.int"] + m.par["surv.Nt"] * Nt + m.par["surv.z"] * z 
    p <- 1/(1+exp(-linear.p))                                                 
    return(p)
}
```

The growth and reproduction function are density-independent, we define them as:

```r
## Growth function, given you are size z now returns the pdf of size z1 next time
g_z1z <- function(z1, z, m.par) {
    mean <- m.par["grow.int"] + m.par["grow.z"] * z           
    sd <- m.par["grow.sd"]                                    
    p.den.grow <- dnorm(z1, mean = mean, sd = sd)
    return(p.den.grow)
}

## Reproduction function, logistic regression
pb_z <- function(z, m.par) {
    linear.p <- m.par["repr.int"] + m.par["repr.z"] * z       
    p <- 1/(1+exp(-linear.p))                                 
    return(p)
}
```

With all the demographic function defined, now we can construct build the IPM kernels P, F, and K:

```r
## Define the survival kernel
P_z1z <- function (z1, z, Nt, m.par) {
    return( s_z(z, Nt, m.par) * g_z1z(z1, z, m.par) )
}

## Define the reproduction kernel
F_z1z <- function (z1, z, Nt, m.par) {
    return( 0.5* s_z(z, Nt, m.par) * pb_z(z, m.par) * pr_z(Nt, m.par) *             c_z1z(z1, z, Nt, m.par) )
}
```

### References

Ellner, Stephen P., Dylan Z. Childs, and Mark Rees. 2016. _Data-Driven Modelling of Structured Populations: A Practical Guide to the Integral Projection Model._ Lecture Notes on Mathematical Modelling in the Life Sciences. Switzerland: Springer.

“Example of a Simple, Stochastic, Kernel-Resampled Model with Density Dependence.” n.d. Accessed March 27, 2023.

Rose, Karen E., Svata M. Louda, and Mark Rees. 2005. “Demographic and Evolutionary Impacts of Native and Invasive Insect Herbivores on Cirsium Canescens.” _Ecology (Durham) 86_ (2): 453–65. https://doi.org/10.1890/03-0697.
