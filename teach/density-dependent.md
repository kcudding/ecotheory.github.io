## Density-dependence

Density-dependent population models are used to describe population dynamics in which the growth or decline of a population is influenced by the population's own density.


###  Negative density dependence

In a population that has already been established, resources begin to become scarce, and competition starts to play a role. As a result, the population growth will be negatively affected by increasing density. This is called **negative density dependence**.

Increasing population size gives rise to:

  + shortages in food or other limiting resources

  + greater intraspecific aggression

  + increased predation risks
  
  + greater risks of disease outbreak

Negative density dependence decreases population growth at high density and increases it at low density.

Here is another example from the duckweed showing how population size can limit the population growth of duckweed in a controlled environment. We see that the number of duckweed has been increasing, but the rate of increase has been slowing down as there are less nutrients and available space.

![Logistic growth of duckweed in the lab environment](duckweek_log.jpg)


### Logistic growth model

Recall that with exponential growth, per capita growth rate is:

$$ r = \frac{dN}{dtN} $$

* $dN/dt$: The net number of new individuals in a population over a unit of time (also called recruitment or yield)
* $r$: Intrinsic growth rate
* $N$: Population size

Of all the ways that the per capita growth rate could decrease with increasing population density, we consider the simplest scenario in which this relationship is linear. Now we have:

$$ \frac{dN}{dtN} = r(1-\frac{N}{K})$$

where $K$ is the carrying capacity and $1-\frac{N}{K}$ describes the linear negative effects an increasing population density has on the per capita growth rate (see the plot below).

![Per capita growth rate in exponential and logistic growth](density-dependent_files/figure-html/unnamed-chunk-1-1.jpeg){width=80%}

<br>
Re-arrange the above equation and we have the **continuous logistic growth model**:

$$ \frac{dN}{dt} = r \frac{K-N}{K} N $$

* $K − N$: How many more individuals can be added to the population before
it hits carrying capacity
* $K − N/K$: The fraction of the carrying capacity that has not yet been
“used up”

<!-- include the graph for exponential and logistic growth -->
![The contrast between exponential and logistic growth (adapted from Mills, 2013)](density-dependent_files/figure-html/unnamed-chunk-2-1.jpeg)

<br>
The maximum per capita growth rate, $r$, occurs when population density is zero, and decreases until it finally reaches zero. The population density at which the per capita growth rate is zero, $K$, is sometimes called the **carrying capacity**.

* *Note*: Do not think of carrying capacity as the maximum population size observed. A population can exceed $K$ temporarily.

Now we have developed the model for logistic population growth, we should look at the population dynamics in more details.

#### Stability

The **stability** of a system is a measure of how much it tends to stay the same, in spite of external disturbances or changes in the state of the system. A logistic population growth model is a system with stability, and carrying capacity $K$ is the stable equilibrium point. Population size above $K$ will decrease to $K$; while population size below $K$ will increase to $K$. In other words, we always end up at $K$ regardless of the starting population size.

Consider a logistic growth model with a carrying capacity $K=500$ and per capita growth rate $r=0.18$:

* When the population number is at 100 (point b) or 200 (point c), the population will grow, moving along the x-axis, until population growth rate slows so much that it comes to rest where $N=K=500$.

* When the population number is at 550 (point e), $dN/dt$ is negative, so $N$ shrinks back down to $N=K=500$.

* When population number is at 0 (point a) or 500 (point d), the population growth rate is at zero so that the density will not change.

![](density-dependent_files/figure-html/unnamed-chunk-3-1.jpeg)


### Discrete time logistic growth

For many populations, reproduction and mortality occur at very particular periods of the year (in discrete intervals of time).

To model discrete logistic population growth, we start from recalling our model of geometric growth for a single time step:

$$ N_{t+1} = \lambda N_t$$

We can decompose $\lambda$ into two parts to illustrate that this year's population density $N_t+1$ is equal to the previous year's population, $N_t$, plus a proportional change, $r_dN_t$:

$$N_{t+1} = \lambda N_t = N_t(1+r_d) = N_t+r_dN_t$$

Now we can try to incorporate density dependence into that proportional change $r_dN_t$. We use $1/K$ to represent this negative effect on population growth. As a result, $r_d(1- \frac{N_t}{K})$ becomes the new per capita growth increment rate.

And we have an equation that describes **discrete logistic growth**:

$$N_{t+1} = N_t+r_d(1- \frac{N_t}{K})N_t = N_t+r_d(1-\frac {N_t}{K})N_t$$

where $K$ is the carrying capacity.

From the equation, we can see that the population abundance at time $t+1$ depends on the abundance at time t. This time lag makes sense for many populations, where birth and death rates respond to the population's density at some time in the past, instead of current density.


#### Chaos

In discrete time logistic population growth, there is usually a built in delay, or time lag, of one time step, because the growth increment makes a single leap of one time step. This time delay in population growing with absolutely no stochasticity showing dynamics that bounce, or cycle, or become entirely unpredictable.

**Chaos** is a non-repeating, deterministic fluctuating trajectory, that is bounded, and sensitive to initial conditions.

<br>
Let's look at the following example:

We have a population that has an initial population density of $N=10$, and carrying capacity $K=100$. With different values of $r$, we can see very different population growth trajectories.

![Population growth with an initial population density of $N=10$, carrying capacity $K=100$. With different values of per capita growth rate $r$, the population growth trajectories are very different](density-dependent_files/figure-html/unnamed-chunk-4-1.jpeg)

When $r$ is close to zero, we have a steady simple asymptotic approach to K (Fig. a). As $r$ increases, we see the population overshoot the carrying capacity and exhibit **damped oscillations** (Fig. b). At $r=2.2$, we see a stable limit cycle of two points (Fig. c). As $r$ increases further, a four-point limit cycle is observed (e.g., at $r=2.5$, Fig. d), then an eight-point cycle, a 16-point limit cycle, and so on. As $r$ increases further, however, stable limit cycles shift into chaos (Fig. e).

**Bifurcation Graph**
We can also demonstrate the chaotic dynamics using a bifurcation plot, which examines $N$ as a function of $r$. As $r$ increases the number of $N$ will continue to double, growing geometrically. Eventually, we reach a point when there becomes an infinite number of unique points.

![Long term dynamics of discrete logistic population growth, with an initial population density of $N=10$, and carrying capacity $K=100$ (Stevens, 2009)](density-dependent_files/figure-html/unnamed-chunk-5-1.jpeg)

* Note that chaos is different from stochasticity or randomness. If you start with exactly the same initial conditions under chaotic dynamics, you will get exactly the same population trajectories every time

Chaos is **very sensitive to initial conditions**. Slightly changing the initial population number $N_0$ would result in very distinct results.

* Here we start with two populations that have initial size of 10 and 11 (all other parameters remain the same). As shown on the graph below, we see completely different trajectories for population growth.

![Chaotic dynamics with different initial conditions. Black solid line demonstrates the population trajectory for a population that has an initial size of 10; red dotted line demonstrates the population trajectory for a population that has an initial size of 11](density-dependent_files/figure-html/unnamed-chunk-6-1.jpeg)


**Biological significance of chaos in population growth**

Chaos brings more complexity into predicting population growth, especially for species with relatively large $r_d$ value. For example, for temperate-zone insects in particular, even if the natural world was 100 % predictable, the population dynamics could still in some circumstances be indistinguishable from chaos (May, 1975).


### Other types of density dependent population models

The linear decline in per capita growth rate with density modeled above is not necessarily general. In fact, most species exhibit **nonlinear** declines in growth rate under negative density dependence.

#### Concave and convex density dependences

* **Concave density dependence**: Per capita population growth rate declines rapidly at low density, and then flattens out as carrying capacity is approached. This could happen due to resource preemption, where a small of individuals at low population density sequester large amounts of resources, causing subsequent population growth to slow down. For example, larger tropical seagrass arriving at sites would preempy available space to prevent subsequent individuals from competing for these resources (Moreira-Saporiti et al., 2021)

* **Convex density dependence**: Per capita population growth rate exhibits strong density dependence only near K. This could be related to territoriality. For example, dickcissel birds (*Spiza americana*) need a minimum territory size of approximately 0.9 acres. If male density is greater than this, some males will be forced into territories that contain less suitable vegetation and they are found to be less active in finding mates and building nests. As a result, the per capita growth rate will decline more rapidly compared to before (Zimmerman, 1971)

#### Theta-Ricker model

The most common way to model non-linear density dependent population growth is the Theta-Ricker model. By varying $\theta$, we can change the linear density dependence of the simple logistic model to curvi-linear density dependence.

$$ N_{t+1} = N_t e^{r_0[1-(N_t/K)^\theta]} $$

* The effects of $\theta$ on density dependence control the shape of relation between growth rate and population size, as seen in the following figure:

![Per capita growth rate vs. population size with different theta values](density-dependent_files/figure-html/unnamed-chunk-7-1.jpeg){width=80%}

* When $\theta$>1, this weakens density dependence at low N, so the population grows faster than logistic, all else being equal (concave). When $\theta$<1, this strengthens density dependence at low N, causing the population to grow more slowly than logistic, all else being equal (convex):

![Population size vs. time with different theta values](density-dependent_files/figure-html/unnamed-chunk-8-1.jpeg){width=80%}


#### Positive density dependence

In many cases, cooperation or facilitation leads to mutually positive interactions among members of a population. Positive density dependence occurs when vital rates or populations increase as density increases.

##### Allee effect

Allee & Bowen (1932) initially noticed that goldfish grew faster in waters which had previously contained other goldfish, than in waters that had not contained them. He further experimented with a number of different species and showed that larger group size or some degree of crowding may stimulate reproduction, prolong survival in adverse conditions (through resistance to desiccation or by social thermoregulation), and enhance protection from toxic reagents.

The Allee effect occurs when there is a positive correlation between population density and individual fitness at low population density.

![© flowcomm, [African wilddogs hunting in packs](https://live.staticflickr.com/5117/13949089869_e175469efc_b.jpg), [Creative Commons CC BY 2.0 license](https://creativecommons.org/licenses/by/2.0/)](african_w_dog.jpg)

**Example**

* African wild dogs usually live in a pack of 6-20 individuals

* Increasing pack size can:

  + increase the likelihood of a successful kill in a given hunt
  
  + provide a better predator defense
  
  + help babysit pups (packs with 10 or more adults raised three times as many yearlings compared to packs with 9 or fewer adults)

##### Weak and strong Allee effects

* **Weak Allee effects**: A weak Allee effect is where the population growth rate is small but positive for small N. The population does not contain a critical population size or density under which the growth rate becomes negative

* **Strong Allee effects**: A strong Allee effect describes a population that can grow at intermediate population densities but declines when the number of organisms is either too small or too large

* **Allee effect population threshold**: A population size below which the per capita growth rate is negative and the population declines towards extinction. Populations that are subject to Allee effects can collapse and become extinct if their population size falls below the critical threshold

![No Allee effects (green line), weak Allee effects (red line), and strong Allee affects (blue line, $a=50$) acting on a population that has an intrinsic population growth rate $r=0.18$ and carrying capacity $K=500$](density-dependent_files/figure-html/unnamed-chunk-9-1.jpeg)

To plot population growth rate as a function of abundance:

$$\frac{dN}{dt} = rN(\frac{N}{a}-1)(1-\frac{N}{K})$$
where a is the critical point of the population, below which the population growth rate (or recruitment) becomes negative, and the population is driven towards extinction.

##### Stability in Allee effects

From previous sections we learned that carrying capacity $K$ is a stable equilibrium point in a negative density-dependent logistic growth model (no Allee effects). 

For a population model with a strong Allee effect. It has two stable (represented by black circles on the graph below) and one unstable equilibria point (represented by an red triangle on the graph below). The stable point is when population size equals $N=0$ or carrying capacity $N=K$. The single unstable equalibrium point lies at $N=A$, where $A$ is the critical population size.

![Stability in density-dependent population growth with strong allele effects. The red triangle represents the unstable equilibrium point; while the black circles represent two stable equalibrium points](density-dependent_files/figure-html/unnamed-chunk-10-1.jpeg)

### Illustration of current application

Density-dependent condition and growth of invasive lionfish in the northern Gulf of Mexico (Dahl et al., 2019). This research paper discusses how increasing population density can affect invasive lionfish size-at-age (growth) and population dynamics.

![© Bernard Dupont, [Red lionfish](https://commons.wikimedia.org/wiki/File:Red_Lionfish_%28Pterois_volitans%29_%288479302765%29.jpg), [Creative Commons CC BY-SA 2.0 license](https://creativecommons.org/licenses/by-sa/2.0/deed.en)](lionfish.jpg)

#### Snapshot of the study

* Indo-Pacific red lionfish (*Pterois volitans*) have invaded the Gulf of Mexico over the past 30 years. Their invasion success is likely due to a release of predation pressure in the novel environment.

* Their invasion poses long-term threats to the native communities by altering trophic structures through direct predation, and reducing species richness.

* An exponential increase in lionfish density at both natural and artificial reefs was observed beginning in 2010 through 2014, after which mean lionfish density on both reef types reached an apparent peak. Throughout the following years, the population number is fluctuating around this peak value (check the plot below).

* The growth of invasive lionfish appears to be density-dependent. Lionfish inhabiting densely populated reefs exhibited smaller mean size at age (slower growth).


#### Calculate the population growth of invasive lionfish

```r
# First, let's create a data frame containing population counts as in Dahl et al. (2019):
lionfish <- data.frame(year = c(2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017),
                    density_natural = c(0, 0.02, 0.15, 0.49, 0.57, 0.34, 0.43, 0.56),
                    density_artificial = c(0, 2, 8, 14.7, 32.98, 30.5, 20.45, 32.98))

# We can plot the population trajectories for both populations inhabiting natural
# and artificial reefs:
par(mfrow=c(1,2))

plot(lionfish$year, lionfish$density_natural, type="o",
     pch=16, lwd=1.5, bty="l", cex.lab=1.2, cex.main=0.8,
    main="(a)", 
    xlab="years", ylab="population size")

plot(lionfish$year, lionfish$density_artificial, type="o",
     pch=16, lwd=1.5, bty="l", cex.lab=1.2, cex.main=0.8,
     main="(b)", 
     xlab="years", ylab="population size")
```

![Invasive lionfish mean density estimated from remotely operated vehicle video samples at northern Gulf of Mexico natural (a, n = 16) and artificial (b, n = 22) reef locations (Dahl et al., 2019)](density-dependent_files/figure-html/unnamed-chunk-11-1.jpeg)
From both figures, we can see that the invasive lionfish population increases exponentially during the first years (2011-2014). After potentially reaching carrying capacity in 2014, it starts to fluctuate around that peak value. If this trend continues, a density-dependent logisitic growth curve will represent well the growth patterns for these populations.


#### Takeaways from this example

* The population growth of invasive lionfish in the Gulf of Mexico is likely to be density-dependent. Population trends suggest that this species may have already reached carrying capacity.

* Future studies should examine other potential density-dependent demographic rates (e.g. movement, fecundity, mortality) in invasive lionfish populations to capture the full extent of density-dependent effects.

* Knowing the population dynamics for this species enables the application of effective fish removal programs.
