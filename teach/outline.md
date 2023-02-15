---
title: "Structured Population Models Outline"
author: "Eddie Wu"
date: '2023-02-02'
output:
  html_document: 
    toc: yes
    number_sections: yes
    toc_float:
      collapsed: no
      smooth_scroll: no
    keep_md: yes
bibliography: outline_bibliography.bib
nocite: '@*'
---



# Learning outcomes

1. Distinguish age and stage structure, and understand how they can be applied in more complicated population models.

2. Develop the skills to create a projection matrix of vital rates. Project the matrix through time to predict future population dynamics. Being able to interperate the results of a structured population model.

3. Be able to read the population trajectories of structured population model predictions. Understand what is stable stage/age distribution and transient dynamics. 

4. Understand what is sensitivity and elasticity. Develop the skills to conduct sensitivity and elasticity analysis.

5. Understand how stochasticity can be applied to structured population models.


# Structured population models

## Introduction to population structures

### Age and stage structure

#### Age structure
#### Stage structure
#### Size structure

* explain with real-life biology examples


### Life tables

A **life table** is a record of survival and reproductive rates in a population, broken out by age, size, or developmental stage.

* common frog example (Biek et al., 2001)

#### Different Methods for conducting life tables


### Life history stage diagram


```{=html}
<div id="htmlwidget-097c1dfb34bb27816dae" style="width:672px;height:480px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-097c1dfb34bb27816dae">{"x":{"diagram":"digraph {\n\ngraph[layout = dot, rankdir = LR]\n\nPrejuvenile\nJuvenile\nAdult\n\nPrejuvenile -> Juvenile [label = \"0.019\"]\nJuvenile -> Adult [label = \"0.08\"]\n\nAdult -> Prejuvenile [label = \"279.50\", style = dashed]\nJuvenile -> Prejuvenile [label = \"52.00\", style = dashed]\n\nAdult -> Adult [label = \"0.43\"]\nJuvenile -> Juvenile [label = \"0.25\"]\n\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```


### Use matrix to represent population dynamics


```
##              Pre-juvenile Juvenile  Adult
## Pre-juvenile        0.000    52.00 279.50
## Juvenile            0.019     0.25   0.00
## Adult               0.000     0.08   0.43
```
Anatomy of a female-based projection matrix for common fog (adapted from Biek et al., 2002)

#### Lefkovitch Matrix - for stage structure (Lefkovitch, 1965)

#### Leslie Matrix - for age structure (Leslie, 1945) (Leslie, 1948)


## Structured population models

### Project the matrix

To determine the population size vector next year $n(t+1)$, multiply the matrix $M$ of vital rates by the vector of individuals at current time $n(t)$:

$$n(t+1) = M*n(t)$$
**Example calculation**

* Use the common frog example from Biek et al., 2001


### Stable age distribution (SSD)

Any wildlife population with a particular set of constant vital rates can achieve a certain distribution of individuals across stages (SSD).

* Demonstrate using a matrix population calculation example

### Reproductive Value


## Sensitivities and Elasticities

### Sensitivity

**Analytical sensitivity** can be defined as the tiny absolute change in $\lambda$ caused by a tiny absolute change in a vital rate, while all other rates are held constant.

### Elasticity

**Elasticity** are proportional sensitivity that describe tiny proportional change in $\lambda$ with a tiny proportional change in a vital rate.

Elasticity of matrix element $a_{i,j}$ = (sensitivity of $a_{i,j}$)$\frac{a_{i,j}}{\lambda}$

### Component sensitivity and elasticity    


## Transient dynamics

A population with a stage distribution different from that expected at SSD will experience **transient dynamics** until it settles down to the asymptotic growth rate at SSD.

### Population inertia
#### Population momentum
(read Koons et al., 2007)


## Stochasticity in age and stage-structured populations

(use examples to illustrate)

### Environmental stochasticity
### Demographic stochasiticity
### Applying density-dependence in strucutured population models


## Paper discussion

### Classical paper of the topic

![](images/classical_reading.png)

#### Knowledge gaps

* The soay sheep population on the island of Hirta (northwest of Scotland) fluctuates dramatically, and previous researches were unable to distinguish the interactions between density dependence, unexplained variation, and demography.

* **Objective**: Develop a more complex population model with more data. Explore age- and sex-specific associations between survival, density, and weather.

#### Methods

* Use a mark-recapture-recovery analysis from field-collected individual data between 1986 and 1996.

#### Discussion

* Simulated populations of the same initial size, under the same weather conditions, but with different age and sex structure, can have different population trajectories.

  + The more lambs and older females (the survival of which are more strongly related to weather and density-dependence) in the population, the more likely the population is to decline from high densities.

* Generally good climate conditions allow the population to increase; a bad weather interacts with density and demography to produce a crash.

  + When the weather becomes wetter and stormier, the mean population size declines.

  + The importance of environmental variation, especially with global climate change.

* The necessity to incorporate age and sex into accurately predict population dynamics.


### Latest paper of the topic

![](images/latest_reading.png)

#### Knowledge gaps

* Burbot were illegally introduced into the Green River basin during the 1990s, and they pose a threat to native fishes by direct predation.

* Data on nonnative Burbot population structure and dynamics are needed before initiating a suppression program.

* The difference between lotic (slow-growing) and lentic (fast-growing) populations of Burbot remains unclear.

* **Objective:** Describe the population characteristics of Burbot, as well as any differences that exit between the lotic and lentic populations. Estimate the appropriate exploitation goals that would be needed to suppress the Burbot population below replacement level.

#### Methods

* Field-collected Burbot fish samples. Obtained and calculated vital rates.

* A female-based Leslie matrix.
![Brauer et al., 2018](images/matrix.png)

#### Discussions:

* From the age-structured population model, lentic Burbot mature earlier, grow faster, and have lower mortality. The population will increase at an annual rate of 23% in the absence of exploitation.

* Model limitation: did not consider the movement of Burbot between lentic and lotic environments.

* The age-structured population model showed fast population growth for Bubort in this reservoir ($\lambda$ = 1.18).

* Removal of age-1 or age-2 fish would be the most effective. However, current fishing techniques can only effectively target age-3 and older individuals. Therefore, exploitation would need to exceed 33% annually to effectively suppress Burbot in the study reservoirs.


## References:
