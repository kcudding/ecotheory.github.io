# BIOL 652 L2 Exercises

1. The following matrix describes the life history transitions of a structured population:

$\begin{bmatrix} 0 & 0 & 12 & 24\\ 0.1 & 0 & 0 & 0\\ 0 & 0.5 & 0.25 & 0\\ 0 & 0 & 0.7 & 0.8 \end{bmatrix}$

a. Does the matrix describe an age- or stage-structured population? How do you know?
b. Write down the equations that correspond to the matrix
c. The dominant eigenvalue of the matrix is 0.98. What does it mean?
d. If the population has not reached a stable age distribution, how can you predict future population size?

2. You are the manager of a small nature reserve and you notice a new invasive plant (spotty fundingcut) is suddenly quite prevalent. You search the literature and find that the self-fertilizing plant is perennial, but that reproductive output is size-dependent. After one year plants are reproductively mature adults; but small plants do not have enough energy to produce many seeds. 

a. Draw a graph to describe the life history of the plant

b. To track the species, you establish 50, 1 m2 sample plots located randomly throughout the reserve. For two years you sample in early summer when fruits are on the plants. In all plots, you tag all first year plants, and all older plants, and count the number of fruits on each (there is one seed per fruit). For every 100 fruits counted in the first year, 30 one-year-old plants were found in the next year. You find the 50% of small adult plants become large adult plants in the next year. Once large, plants have a 90% chance of surviving from year to year. Small plants produced about 0.5 seeds per year, but each large plant produced 20 seeds. Use the matrix() command to construct the stage-structured projection matrix named L that corresponds to your data

c. Your last census revealed that there were 100 seeds, 250 small plants, and 50 large plants on the reserve. Create a vector of these values using the matrix() command, and then use matrix multiplication to project the estimated population size one year into the future. Matrix multiplication in R is indicated as ``` %*%```. So for example,  ```N1<-L%*%N0```.

d. Set up a matrix to store the values of the vector for each year, and project forward for 6 years. Plot your results, and determine if you have a management problem.

e. Farther into the future you might expect the population to reach a stable age distribution, and consequently, you should be able to calculate the population growth rate as a scalar. Remember that the population growth rate is given by the dominant eigenvalue of the matrix describing the life history. Use the function eigen() to find the eigenvalues and eigenvectors of your matrix. The real part of the largest eigenvalue will be your growth rate. What do you think? Will spotty fundingcut continue to increase in your reserve?

f. Find the stable age distribution that corresponds to this growth rate and express as percentage of the total population. After enough time, what percentage of the population will be found in each stage? Create a barplot() that illustrates the expected stable age distribution.

g. The reproductive value of a stage is the expected contribution of individuals in the stage to present and future reproduction. We can find the reproductive value of a stage by solving for the left eigenvector corresponding to the dominant eigenvalue. Like the right eigenvector that gives the stable age distribution, the left eigenvector is proportional to the reproductive values. We normally scale this vector by the reproductive value of the first stage. We get left eigenvector by performing eigenanalysis on the transpose of the life history matrix using the t() function and the eigen() function. You'll also discarded the imaginary parts of the vector using the Re() function which just takes the real part of each element. What stage has the highest reproductive value?


h. Sensitivity tells us the importance of each vital rate in determining the population growth rate. These are derived from the stable age distribution and the reproductive values as: $\frac{\partial\lambda}{\partial a_{ij}} =\frac{v_{ij}w{ij}}{\boldsymbol{v} \boldsymbol{\cdot} \boldsymbol{w}}$ where $\lambda$  is the dominant eigenvalue, and $v_i w_j$ is the product of each pairwise combination of elements of the dominant left and right eigenvectors, $\boldsymbol{v}$ and $\boldsymbol{w}$. The dot product $\boldsymbol{v} \boldsymbol{\cdot} \boldsymbol{w}$ is the sum of the pairwise products of each vector. Dividing by this sum causes the sensitivities to be relative to the magnitudes of $\boldsymbol{v}$ and $\boldsymbol{w}$. To find the sensitivity let’s first calculate the denominator:

   ``` R
    S.dem<-sum(repv*sad)
	# repv is the vector of reproductive value
	# sad is the stable age distribution
```
    
Then we can use two loops to calculate the sensitivity of each element of the A matrix:
    
``` R
s=A; n=dim(L)[1];
  for(i in 1:n) {
  for(j in 1:n) {
  s[i,j]=repv[i]*sad[j]/S.dem;

} }
```

According to this, which is the most important life history component?
    
i.  Elasticities are sensitivities weighted by the transition probabilities, and tell us about the proportional effects of a change in a life history component. So that elasticity of each element, $e_{ij}$ , is given by $\frac{a_{ij}}{\lambda}\frac{\partial \lambda}{\partial a_{ij}}$. This is easy to calculate in R: 
 
 ``` R 
elas<-Re(A/dom.eig*s)
```

Elasticities have two nice properties. First, impossible transitions have values of zero, since we multiply by the life history matrix, and second, elasticities sum to one, so it easy to compare the different rates, or between populations.
    
j.  Based on the elasticities, choose a management action that to control spotty fundingcut. Provide an argument that your action will be the least expensive and most effective plan.
