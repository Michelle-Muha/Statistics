---
title: "Stats_CP1"
author: "Michelle Muha"
date: "May 19, 2015"
output: html_document
---
##Statistical Inference Course Project - Simulation Exercise

```{r global_options}
knitr::opts_chunk$set(fig.width=6, fig.height=4, size = "small")
```

###Summary
This project consists of simulating the exponential distribution for a population for 40, 1000 times. The simulated data is then compared with the theoretical distribution

###Simulation
This code chunk simulates the exponential distribution for a population for 40, with lambda = 0.2, 1000 times
```{r}
vect <- NULL
for (i in 1:1000) vect = c(vect, mean(rexp(40, 0.2)))
hist(vect, xlab="Mean of simulated distribution", main="Simulated Means")
```

###Sample Mean vs. Theoretical Mean
The theoretical mean for these sets of distributions is 1/lambda = 1/0.2 = 5
```{r}
Sample_Mean <- mean(vect)
Sample_Mean
hist(vect, xlab="Mean of simulated distribution", main="Simulated Means")
abline(v=5,col="red")
abline(v=Sample_Mean,col="blue")
```
It can be seen from the histogram that the sample mean (blue line) is very close to the theoretical mean (red line)

###Sample Variance vs. Theoretical Variance
The theoretical standard error for these sets of distributions is (1/lambda)/sqrt(n) = (1/0.2)/sqrt(40) = 0.7906, which gives a theoretical variance of (0.7906)^2 = 0.625
```{r}
Sample_Variance <- var(vect)
Sample_Variance
curve(500*dnorm(x, mean = 5, sd = 0.7906), from = 0, to = 10, add = FALSE, col = "red", xlab = "Mean", ylab = "Frequency", main = "Sample vs. Theoretical Variance" )
curve(500*dnorm(x, mean = Sample_Mean, sd = sqrt(Sample_Variance)), from = 0, to = 10, add = TRUE, col = "blue")
```
It can be seen from the plot that the sample variance (blue line) is very close to the theoretical variance (red line)

###Distribution
```{r}
hist(vect, xlab="Mean of simulated distribution", main="Sample Distribution vs. Normal Distribution")
curve(500*dnorm(x, mean = 5, sd = 0.7906), from = 0, to = 10, add = TRUE, col = "red")
```
It can be seen from the plot that the sample distribution approximately fits the normal distribution (red line)