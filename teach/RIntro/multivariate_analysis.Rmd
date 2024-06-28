---
title: "Multivariate analysis"
author: "Eddie Wu"
date: "`r Sys.Date()`"
output:
  html_document: 
    toc: yes
    number_sections: no
    toc_float:
      collapsed: no
      smooth_scroll: no
    keep_md: yes
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(message = FALSE, dev = "jpeg", dpi = 300)
```

# Libraries and imports

```{r import}
library(readxl)
library(ggplot2)
library(tidyverse)
library(factoextra)
library(knitr)

# xlsx files
ham <- read_excel("ind dates flat all parameters Hamilton only FOR Kim.xlsx")
#colnames(ham)
#str(ham)
#View(ham)
#table(ham$Station_Acronym)

#summary(ham$calanoid[ham$Station_Acronym=="HH6"])

#ham$calanoid[ham$Station_Acronym=="HH6" & ham$year==2016]
#ham$calanoid[ham$Station_Acronym=="HH6" & ham$year==2015]

ham$area_group <- as.factor(ham$area_group)
ham$season <- as.factor(ham$season)

```

```{r data ploting, eval = FALSE}
plot(calanoid~SamplingDate, data=ham, col=area_group)
legend("topleft", legend=levels(ham$area_group), 
       pch=1,col=c(1:length(levels(ham$area_group))))

samps=as.data.frame(table(ham[,c("year","area_group")]))
samps$year=as.numeric(as.character(samps$year))
plot(Freq~year,data=samps[samps$area_group=="deep",],
     xlim=c(min(samps$year), max(samps$year)),
     ylim=c(min(samps$Freq), max(samps$Freq)),
     col="black", type="b", main="Samples per year by area group")
lines(Freq~year,data=samps[samps$area_group=="NE",],
      col="red", type="b")
lines(Freq~year,data=samps[samps$area_group=="west",],
      col="blue", type="b")
lines(Freq~year,data=samps[samps$area_group=="wind",],
      col="green", type="b")

legend("topleft", legend=levels(ham$area_group), lty=1,
       pch=1,col=c("black", "red", "blue", "green"))

# similar plot using ggplot
ggplot(samps, aes(x = year, y = Freq, 
    group = area_group, colour = area_group)) + geom_line()

```

# Multivariate analysis


## Learning goals

put in the same format as the previous sections...

## Introduction to multivariate analysis

In previous sections, we have discussed scenarios where there is one response variable. If we have multiple responses, $y_1$...$y_n$, and multiple predictors, $x_1$...$x_n$, then we need multivariate approaches.

These methods allow us to represent the variables or observations in a lower-dimensional space, such as a two-dimensional or three-dimensional plot, while preserving the overall structure of the data.

**OUTLINE: "Large zooplankton such as Daphnia, large copepods or predatory Cladocera (Bythotrephes, Cercopagis, Leptodora) are much better prey for forage fishes, so changes in their populations (or shifting drivers) are of particular interest."**

*Question: What are the major drivers of Diaphnia biomass?*

*Variables*: Daphnia biomass (mg/m3), water column temperature (°C), epilimnion temperature(°C), particulate organic nitrogen (mg/L), dissolved inorganic carbon (mg/L), particulate organic carbon (mg/L)


```{r multivariate data}
## Select the variables interested
ham.multi <- ham %>% 
  select(area_group, season, Station_Acronym,Daphnia,
         watercolumn_temp,mean_mixing_depth_temp,
         PON_ECCC1m,DIC_ECCC1m,POC_ECCC1m) %>% 
  na.omit()

# Rename the columns
colnames(ham.multi) <- c("area","season","station","daphnia","column.temp",
                         "epili.temp","pon","dic","poc")


## Visualize the multivariate response variables
ggplot(ham.multi, aes(x=season, y=daphnia))+
  geom_bar(stat = "identity")
```


## Principle Component Analysis (PCA)

Principle component analysis is a linear transformation method that converts the original set of variables into a new set of linearly uncorrelated variables, called principal components (PCs), which are sorted in decreasing order of variance.


### Correlation examination

First of all, we need to examine the correlation between our variables. We can either run a correlation test, or create a correlation plot.

```{r correlation}
## Correlation table
cor.df <- cor(ham.multi[4:9])
kable(cor.df)

## Correlation plot
pairs(ham.multi[4:8], main = "Ham Data",
      pch = as.numeric(ham$season), col = (ham$season))

```

### PCA with standardized data

Now we can start with running our principle component analyses. PCA can be computed using various functions in R, such as prcomp() in *stats* package, princomp() in *stats* package, rda() in *vegan* package.

Here we demonstrate the simplest method using prcomp() function.

```{r pca run}
## Run PCA analysis
pca.ham <- prcomp(ham.multi[, 4:9], scale = TRUE) #subset for all continuous variables
summary(pca.ham)
```


After completing the dimension reduction, each sample now appears as a point in space specified by its new position along the principle component axes. There coordinates are the **scores** returned by the PCA.

**Loadings** are the coefficients of the linear combinations of the original variables that define the principle components. They essentially tell us how much weight each original variable has in forming a particular principal component.

These information can be extracted from the PCA object very easily.

```{r pca loadings and scores}
## Get scores
score <- as.data.frame(pca.ham$x)

## Get loadings
loadings <- as.data.frame(pca.ham$rotation)
barplot(pca.ham$rotation[,1], main = "") # loadings on PC1
barplot(pca.ham$rotation[,2], main = "") # loadings on PC2
```


### Screeplot

Now, we need to determine how many principle components to retain for further analysis. The screeplot() function allows us to visualize the variance explained by each of the principle component axes. Ideally, a curve should be steep, and then bend at an "elbow", after which the curve flattens out. The first few principle components usually account for a large portion of the variance in the data, and should be retained.

```{r pca screeplot}
## Screeplot
screeplot(pca.ham, type = ("lines"), main = "Screeplot", pch = 16, cex = 1)

## Another ploting method using factoextra package
fviz_eig(pca.ham, col.var="blue")
```

The first two principle components together explain roughly 72% of the total variance in this dataset. So we are confident to use the first two principle components to interprate our results.


### Plot ordination

After we chose our principle component axes, we can start visualizing our multidimensional data in a 2-dimensional space.

First of all, we would like visualize the positions of our samples on the new axes (PC1 and PC2).

```{r pca score plot}
## Use base R plot function
pvar <- round(summary(pca.ham)$importance[2, 1:2], 2)
pvar

plot(pca.ham$x[, 1:2], col = as.numeric(ham.multi$season) + 1,
     ylim = c(-3,3), cex = 1, pch = as.numeric(ham.multi$season) + 14,
     xlab = paste0("PC1 (",pvar[1] * 100, "%)"),
     ylab = paste0("PC2 (", pvar[2] * 100,"%)"))

legend("topright", legend = unique(ham.multi$season),
       pch = as.numeric(unique(ham.multi$season)) +14,
       col = c(2, 3, 4,5), bty = "n")


## Use factoextra package
fviz_pca_ind(pca.ham)
```

We can also plot how much influence each variable has on each of the two principle components. We can get such information from the loadings scores we extracted earlier, and create a loading plot.

```{r pca loading plot}
## Use base R plot function
plot(NA, ylim = c(-8, 8), xlim = c(-6, 6),
     xlab = paste0("PC1 (",pvar[1] * 100, "%)"),
     ylab = paste0("PC2 (", pvar[2] * 100,"%)"))

abline(v = 0, col = "grey90")
abline(h = 0, col = "grey90")

# Get co-ordinates of variables (loadings), and multiply by 10
l.x <- loadings[, 1] * 10
l.y <- loadings[, 2] * 10

# Draw arrows
arrows(x0 = 0, x1 = l.x, y0 = 0, y1 = l.y, col = 4, length = 0.15,
    lwd = 1.5)

# Label position
l.pos <- l.y  # Create a vector of y axis coordinates
lo <- which(l.y < 0)  # Get the variables on the bottom half of the plot
hi <- which(l.y > 0)  # Get variables on the top half
# Replace values in the vector
l.pos <- replace(l.pos, lo, "1")
l.pos <- replace(l.pos, hi, "3")
l.pos[4] <- "3"
l.x[3:4] <- l.x[3:4] + 0.75
# Variable labels
text(l.x, l.y, labels = row.names(loadings), col = 2, pos = l.pos,
    cex = 1)


## Use factoextra package
fviz_pca_var(pca.ham)
```

Remember that positively correlated variables are grouped close together (formed angle around 0 degree); variables with about a 90 degree angle are not correlated; negatively correlated variables are positioned on opposite sides of the plot origin (~180 degree angle). The distance between the variables and the origin measure the contribution of that variable to the ordination. A shorter arrow indicates its less importance for the ordination. A longer arrow means the variable is better represented.

Finally, we can visualize all above information (loadings and scores) on one graph using a biplot.

```{r pca biplot}
## Samples
plot(pca.ham$x[, 1:2], col = as.numeric(ham.multi$season) + 1,
     ylim = c(-6,6), xlim = c(-5,7),
     cex = 1, pch = as.numeric(ham.multi$season) + 14,
     xlab = paste0("PC1 (",pvar[1] * 100, "%)"),
     ylab = paste0("PC2 (", pvar[2] * 100,"%)"))

legend("topright", legend = unique(ham.multi$season),
       pch = as.numeric(unique(ham.multi$season)) +14,
       col = c(2, 3, 4,5), bty = "n")


## Variables
# Get co-ordinates of variables (loadings), and multiply by 10
l.x <- loadings[, 1] * 10
l.y <- loadings[, 2] * 10

# Draw arrows
arrows(x0 = 0, x1 = l.x, y0 = 0, y1 = l.y, col = 4, length = 0.15,
    lwd = 1.5)

# Label position
l.pos <- l.y  # Create a vector of y axis coordinates
lo <- which(l.y < 0)  # Get the variables on the bottom half of the plot
hi <- which(l.y > 0)  # Get variables on the top half
# Replace values in the vector
l.pos <- replace(l.pos, lo, "1")
l.pos <- replace(l.pos, hi, "3")
l.pos[4] <- "3"
l.x[3:4] <- l.x[3:4] + 0.75
# Variable labels
text(l.x, l.y, labels = row.names(loadings), col = 2, pos = l.pos,
    cex = 1)


## Package
fviz_pca_biplot(pca.ham, label = "none",
                habillage = ham.multi$season,
                addEllipses = TRUE)
```

## Non-metric multidimensional scaling (nMDS)

The produced biplot in PCA represents well the distance among objects, but fails to represent the whole variation dimensions of the ordination space. Unlike PCA, non-metric multidimensional scaling (nMDS) does not to preserve the exact dissimilarities (distance) among objects in an ordination plot, instead it represents as well as possible the ordering relationships among objects in a small and specified number of axes.

In other words, the goal of nMDS is to represent the original position of samples in multidimensional space as accurately as possible using a reduced number of dimensions.

```{r nMDS run}
library(vegan)
nmds.ham <- metaMDS(ham.multi[,4:9], distance = "bray", k = 2, trace = FALSE)

## Stress
nmds.ham$stress
```

*Stress*: How well points fit within the specified number of dimensions.

*A good rule of thumb for stress:*

* $>0.2$ Poor (risk in interpretation)
* $0.1-0.2$ Fair (some distances misleading)
* $0.05-0.1$ Good (inferences confident)
* $<0.05$ Excellent representation


### Shepard Plot

We can use a Shepard plot to learn about the distortion of representation. On the x-axis, it plots the original dissimilarity (original distances in full dimensions). On the y-axis, it plots the distances in the reduced dimensional space. Ideally, a really accurate dimension reduction will produce a straight line.


```{r nMDS shepard plot}
## Shepard plot
stressplot(nmds.ham, pch = 16, las = 1,
           main = "Shrepad plot")
```



### Ordination plot

```{r nMDS ordination}
## Simple plot
ordiplot(nmds.ham, type = "n", main = "Ordination")
orditorp(nmds.ham, display = "sites", labels = F,
         pch = as.numeric(ham.multi$season) + 14,
         col = c(2, 3, 4, 5) [as.numeric(ham.multi$season)],
         cex = 1) # add sites
legend("bottomright", legend = unique(ham.multi$season),
       pch = as.numeric(unique(ham.multi$season)) + 14,
       col = c(2,3,4,5), bty = "n", cex = 1) # add legend

# Add the species variables
#' Envfit fits environmental vectors or factors onto an ordination
spp.fit <- envfit(nmds.ham, ham.multi[,4:9], permutations = 999)
plot(spp.fit, p.max = 0.01, col = "black", cex = 0.7)
```




## Other resources

*Multivariate analyses tutorials*

* [Building Skills in Quantitative Biology](!https://www.quantitative-biology.ca/index.html)
* [QCBS R Workshop Series - Multivariate Analyses in R](!https://r.qcbs.ca/workshop09/book-en/index.html)
* [Running NMDS using 'metaMDS'(nMDS tutorial with vegan package)](!https://rpubs.com/CPEL/NMDS)

*Useful R packages*

* factoextra (for visualizing PCA results)
* [learnPCA (an R package for PCA learning)](!https://bryanhanson.github.io/LearnPCA/)
* ggbiplot





