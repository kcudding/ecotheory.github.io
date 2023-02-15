---
title: "Structured Introduction"
author: "Eddie Wu"
date: '2023-02-08'
output:
  html_document: 
    toc: yes
    number_sections: yes
    toc_float:
      collapsed: no
      smooth_scroll: no
    keep_md: yes
bibliography: intro_bibliography.bib
nocite: '@*'
---



# Structured population models

## Introduction to population structure

So far, we have limited our prediction of wild populations by assuming that all individuals in a population are identical. However, many plants and animals have demonstrated distinct age or stage structure in their populations. In fact, ecologists care about these particular parts of a population as much as they do the population as a whole. To truly understand and predict population growth, we cannot avoid discussing the dynamics of these particular ages and stages.

### Age and stage structure

In the same population, individuals can have markedly different dynamics depending on their age.

* Coulson et al. (2001) found that individual susceptibility to changing environmental conditions differs between Soay sheep of different ages. Young and old individuals are more severely affected by adverse weather conditions than adults of prime reproductive age.

![A pair of Soay sheep on Hirta © Eileen Henderson, CC BY-SA 2.0](images/soay.jpg)

<br>
While for many species (especially for amphibians, fish, and insects), differences in vital rates in wild populations often depend on developmental or morphological stages, rather than ages.

* For example, common frogs can be divided into three stages according to their developmental status: Pre-juvenile, juvenile, and adults. The vital rates within each stage are relatively constant. [](Biek et al., 2001)

**Size structure** is another commonly used category. For many fish species, age and body size (fork length) is highly correlated. Since fish length is much easier to measure and obtain, it is common to categorize fish into different size groups when building a population matrix.


### Life tables

A **life table** is a record of survival and reproductive rates in a population, broken out by age, size, or developmental stage.

Consider the same common frog example we discussed above:

* Common frogs can be divided into three stages according to their developmental status: Pre-juvenile, juvenile, and adults. We can record the demographic vital rates and transition probabilities for each stage in a table:

<br>
<table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Stages </th>
   <th style="text-align:right;"> Survival </th>
   <th style="text-align:right;"> Transition </th>
   <th style="text-align:right;"> Reproduction </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Pre-juvenile </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.019 </td>
   <td style="text-align:right;"> 0.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Juvenile </td>
   <td style="text-align:right;"> 0.25 </td>
   <td style="text-align:right;"> 0.080 </td>
   <td style="text-align:right;"> 52.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Adult </td>
   <td style="text-align:right;"> 0.43 </td>
   <td style="text-align:right;"> 0.000 </td>
   <td style="text-align:right;"> 279.5 </td>
  </tr>
</tbody>
</table>
Table 1. Demographic vital rates and tansition probabilities for different common frog developmental stages (data from Biek et al., 2001)

<br>
**Different ways to construct life history tables**


### Life history stage diagram

We can use a life stage diagram to represent the dynamics in a population.

* From the life table in the previous section, we can create a life history diagram showing the vitals rates in different population stages.


```{=html}
<div id="htmlwidget-bae0cec23c18dfd9fed2" style="width:672px;height:480px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-bae0cec23c18dfd9fed2">{"x":{"diagram":"digraph {\n\ngraph[layout = dot, rankdir = LR]\n\nPrejuvenile\nJuvenile\nAdult\n\nPrejuvenile -> Juvenile [label = \"0.019\"]\nJuvenile -> Adult [label = \"0.08\"]\n\nAdult -> Prejuvenile [label = \"279.50\", style = dashed]\nJuvenile -> Prejuvenile [label = \"52.00\", style = dashed]\n\nAdult -> Adult [label = \"0.43\"]\nJuvenile -> Juvenile [label = \"0.25\"]\n\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```
Figure 1. Life history stage diagram showing the vital rates of common frog in three different developmental stages (data from Biek et al., 2001)


### Use matrix to represent population dynamics

Compared to life tables and life history diagrams, population matrices are more versatile and practical tools for presenting how structure affects wildlife population dynamics.

A handy way to decipher the biological meaning of any matrix element is to label the rows and columns of the matrix with the consecutive stages of the target organism. Each element gives the transition from the current column number to the current row number.

* For example, $a_{i,j}$ represents the number of individuals contributed on average by each individual in class j this year to class i next year.

Consider the following matrix, common frog has three stages, pre-juvenile, juvenile, and adult. The time step is 1 year.

* The first row ($a_{1,2} = 52, a_{1,3} = 279.5$) represents reproduction from each stage to the next year.

* The diagonal ($a_{2,2} = 0.25, a_{3,3} = 0.43$) represents the proportion of individuals in a stage that will survive and still be in the same stage next year.

* The sub-diagonal ($a_{2,1} = 0.019, a_{3,2} = 0.08$) represents the proportion surviving and advancing to the next stage.


```
##              Pre-juvenile Juvenile  Adult
## Pre-juvenile        0.000    52.00 279.50
## Juvenile            0.019     0.25   0.00
## Adult               0.000     0.08   0.43
```
Anatomy of a female-based projection matrix for common fog (adapted from Biek et al., 2002)

#### Leslie Matrix - for age structure

* The Leslie Matrix is a discrete, age-structured model of population growth. In a Leslie model, the population is divided into groups based on age classes. The (i,j)th cell in the matrix indicates how many individuals will be in the age class i at the next time step for each individual in stage j. (Leslie, 1945) (Leslie, 1948)

* In a Leslie Matrix, an individual can only survive and transition to the next stage, or die, so everything below the first row and not on the subdiagonal of the matrix must be zero. (different from the Lefkovitch matrix)


\begin{bmatrix}
f_0 & f_1 & f_2 & \cdots & f_{m-1}& f_{m} \\
s_0 & 0 & 0 & \cdots & 0 & 0 \\
0 & s_1 & 0 & \cdots & 0 & 0 \\
0 & 0 & s_2 & \cdots & 0 & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & 0 & \cdots & s_{m-1} & 0 \\
\end{bmatrix}

A leslie matrix consists of $m+1$ rows and $m+1$ columns. $f$ represents the reproductive rate of that age class in the population, $s$ represents the probability for surviving and transitioning to the next age class.

#### Lefkovitch Matrix - for stage/size structure

* The use of Lefkovitch matrix is usually associated with stage structure (or size structure), rather than age structure. (lefkovitch, 1965)

* Unlike age-structured population models, animals can remain in some stages or size groups for multiple time steps. Therefore, a lefkovitch matrix appears to be a more accurate representation of these population models.


## Structured population models

### Project the matrix

Once the matrix model is filled with vital rates it can be projected through time, keeping track of both total population size and numbers of individuals in each stage.

To determine the population size vector next year $n(t+1)$, multiply the matrix $M$ of vital rates by the vector of individuals at current time $n(t)$:

$$n(t+1) = M*n(t)$$

<br>
**How to conduct matrix multiplication?**

Matrix multiplication first requires you to go across each row of the matrix, multiply each element $j$ by the same element of the vector. Then you need to add up the products for one row to obtain the total number of individuals in that element of the vector.

Mathematically speaking, the multiplication of matrix $X$ and $Y$ is conducted as:

$$A_{i,j} = \sum_{k=1}^{N}X_{i,k}Y_{k,j}$$
where $k$ is the total number of stages, $i$ is the row number, and $j$ is the column number.

<br>
**Example:**

Consider the population model of common frog we have been discussing. The population can be divided into three developmental stages, and the vital rates are reported in the matrix in the previous section. In 2010, the population consists of **70 pre-juveniles, 20 juveniles, and 10 adults** (initial population), what is the population number for each stage in 2011 (one time step later)?

By multiplying the number of frogs times the matrix of mean vital rates, we project the population forward for a year.

* The matrix $\times$ Population vector in 2010 = Population vector in 2011



$$
\begin{bmatrix}0&52&279.5 \\0.019&0.25&0 \\0&0.08&0.43 \\\end{bmatrix} \times \begin{bmatrix}70 \\20 \\10 \\\end{bmatrix} = 
 \begin{bmatrix}
  (0 \times 70) + (52 \times 50) + (279.5 \times 10) \\
  (0.019 \times 70) + (0.25 \times 50) + (0 \times 10)  \\
  (0 \times 70) + (0.08 \times 50) + (0.43 \times 10) \\
 \end{bmatrix} = 
\begin{bmatrix}3835 \\6 \\6 \\\end{bmatrix}
$$
Projecting the population number of common frog through time (adapted from Mills, 2013).


## Paper discussion

![](images/carp_reading.png)

### Knowledge gap

* Australia’s Murray–Darling Basin (MDB) is a highly flow regulated river system. Water in the MDB is altered for a range of different purposes. This have placed significant pressure on the local aquatic ecosystems.

* In response, environmental water allocation programs are necessary for restoring the health of river ecosystems.

* Invasive carps, which has long been a problem in the MDB, can benefit from some environmental river allocations.

* It is necessary to consider the potential changes to carp populations and their impacts.

**Objectives:**

* Uses a population model to assess the likely responses of carp populations to river flows at three key sites along the Murray River, in the southern MDB.

### Methods

* An age-based stochastic population model with 28 age classes.

* Flow-habitat types determination:

  + **Flow type** determines whether or not adult carp gets access to a habitat.

  + Assessment of early life history survival (1st year) for each **habitat type**. 

### Discussions

* There is an existing large number of fishes in the Lower Lakes of the Murray River (terminal lakes), therefore, within-channel water transfer will have limited effects.

* Interaction between the rivers and the floodplain can increase the carp population. Especially during summer months when water irrigation takes place, carp can have seasonal access to the adjacent wetlands, thus potentially promotes their population growth.

* Population demographic data from monitoring are needed to improve model capacity and test model predictions.

# References
