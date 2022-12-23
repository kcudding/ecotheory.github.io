---
title: BIOL 652 Advanced Ecology
author:
- Kim Cuddington^[[University of Waterloo](http://uwaterloo.ca)]
toc-title:
- Contents
fontsize: 15px 
output: 
 html_document:
  toc: true
  toc_float: true
---

# Wk 1 
## Epistemology: How do we gain knowledge?
### Gaining knowledge in science
- reality
- data: a biased subset of reality
- opinion: what we believe about reality

<span style="color:#8b0000; font-weight: bold">$\rightarrow$**Science**
</span>: an attitude linking belief and data, whereby we do not, 
at least in principle, maintain beliefs that are not supported by data 

### Scientific Theory
- We may refer to beliefs supported by data, or which at least
do not always contradict data, as <span style="font-weight: bold">theories</span>

- We will like theories to have a few other properties such as: 
    - logical consistency
    - coherence with other scientific theories

### What are models?
- **Model**: a representation of reality

- A structure that: 
    - embodies some of our beliefs about reality 
    (e.g., predators negatively impact prey populations $\frac{dN}{dt}=f(N)-g(N,P)$)
	
    - mimics some aspect of data 
	(e.g., linear regression $y_i=\beta_0+\beta_1x_i+\epsilon$)
	
    - combines these two components by making a statement about the expected pattern of data in light of theory 
    (e.g., predator consumption rate can be described as a type II functional response: $\frac{g(N,P)}{P}=\frac{aN}{N+N_0}$)


### Types of models (activity-based classification)

|                               |                      |
|:------------------------------|:--------------------:|
| conceptual (e.g., a statement)|"predators can positively impact prey" |
| physical (e.g., lab experiment)|Bell & Cuddington (2018) ![Bell & Cuddington (2018)](https://github.com/kcudding/theorydata/raw/main/theorydata/laurawormscropped.jpg  "Bell & Cuddington (2018)")|
|mathematical (e.g., ODE)        | $\frac{dN}{dt}=f(N,E)+g(N,P,E)$           |
|data-driven (e.g., regression)  | $E(y_i)=\beta_0+f(x_i)+\epsilon$|
| computational (e.g., IBM)|Cuddington & Yodzis (1990)           ![Cuddington & Yodzis (1999)](https://raw.githubusercontent.com/kcudding/theorydata/main/theorydata/euclidIBM.jpg "Cuddington & Yodzis (1999)")|


### Main characteristic of models 

-models are always false in some aspects of their representation theory or data

Theory $\neq$ Model $\neq$ Reality 

### Other characteristics of models 
- trade off precision, generality and realism (Levins 1966)
- a model is more specific than a theory, but less detailed than reality
- why? a one-to-one scale map of a city may include all details but is useless as a guide to finding your hotel

>"We actually made a map of the country, on the scale of a mile to the mile!"
>"Have you used it much?" I enquired.
>"It has never been spread out, yet," said Mein Herr,
>"the farmers objected: they said it would cover the whole country, and shut out the sunlight! So we now use the country itself, as its own map, and I assure you it does nearly as well.
>
>Lewis Carroll - The Complete Illustrated Works. Gramercy Books, New York (1982)

### Why model: to gain knowledge!
1. Explanation 
2. Prediction


## The role of mechanism in modelling

### What is mechanism?
- "a natural or established process by which something takes place or is brought about" 
	OED
- answers the "how" question
- explains the patterns in data by identifying the cause

### What is a mechanistic model?
- something is a "mechanistic model", because it includes *a priori* knowledge of ecological processes (rather than patterns)

- e.g., mechanistic niche model based on first principles of biophysics and physiology vs correlational niche model based on environmental associations derived from analyses of geographic occurrences of species (see [Peterson et al. 2015](https://doi.org/10.1515/eje-2015-0014) )


### Phenomenological models describe pattern
- a phenomenological model does not explain why
- simply describes the relationship between input and output
- sometimes, the authors of these models make the assumption that the relationship extends past the measured values
- but of course, that is always a problem (e.g., extrapolation of linear regression beyond input data range)

### All models can include phenomenological or mechanistic components or both
- and in general it is a spectrum rather than a dichotomy
 ![](https://github.com/kcudding/theorydata/raw/main/theorydata/unnamed-chunk-2-1.png "Bell & Cuddington (2018)")
 - particularly true for models at large scale, we will often code small-scale mechanisms as phenomenological components
	 - (i.e., when modelling forest stand dynamics, we may not include a mechanistic description of photosynthesis and evapotranspiration)
### Data-driven models, used by themselves, are generally phenomenological

- Data-driven: I'm including here standard statistical models (both frequentist and Bayesian), as well as machine learning models
- these models are good at finding patterns
- in the machine learning literature sometimes referred to as the ‘inductive capability’ of algorithms (from past data, one can identify patterns) 

## Phenomenological models and prediction

- under novel conditions, phenomenological models will not be suitable for prediction (or at least, there is no guarantee they will be) 
  $\rightarrow$ extrapolation problem

<p float="left">
  <img src="https://github.com/kcudding/theorydata/raw/main/theorydata/extrapolate.png" width="300" />
  <img src="https://imgs.xkcd.com/comics/extrapolating.png" width="300" /> 

</p>

![alt-text-1](https://github.com/kcudding/theorydata/raw/main/theorydata/extrapolate.png){ width=300 } ![alt-text-2](https://imgs.xkcd.com/comics/extrapolating.png "title-2"){ width=300 }
[https://xkcd.com/605/](https://xkcd.com/605/)


| [![extrapolation](https://github.com/kcudding/theorydata/raw/main/theorydata/extrapolate.png)](https://github.com/kcudding/theorydata/raw/main/theorydata/extrapolate.png)  | [![XKCD](https://imgs.xkcd.com/comics/extrapolating.png)](https://imgs.xkcd.com/comics/extrapolating.png) | 
|:---:|:---:|
| |[https://xkcd.com/605/](https://xkcd.com/605/)|

[Presentation about the use of models in science](https://www.ecotheory.ca/theorydata/datatheory.html)
![[datatheory.md]]
Other stuff?

<img align="right" width="100" height="100" src="https://imgs.xkcd.com/comics/extrapolating.png">

### why do we model?
----------- ------- --------------- -------------------------
   First               row            12.0                           Example of a row that
                                                                              spans multiple lines.

  Second           row            5.0                            Here's another one. Note
                                                                             the blank line between
                                                                             rows.
----------- ------- --------------- -------------------------
