---
title: "finalProject"
author: "Jessica Zhu"
date: "12/3/2019"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
```{r}
data = read.csv("heart.csv")
names(data)[1] <- "age"
data = data[c("age","sex","trestbps","target")]
```
Hierarchical Logistic Regression 
```{r}
# bayesian model
prior<-c(set_prior("normal(0,1)", class="b"),
         set_prior("cauchy(0,5)", class="sd", group="age"))
#no residual sigma for the binomial
fit.b<-brm(target~sex+trestbps+(1|age), data=data, family=bernoulli(),
              prior = prior, 
              warmup=500, 
              iter=1000, chains=2, 
              cores=2,seed = 1115,
              save_model="test.txt")
print(fit.b, digits=3)
```
```{r}
rstan_gg_options(fill = "skyblue", color = "skyblue4", pt_color = "red")
stanplot(fit.b)+ggtitle("Posterior Density for Between school Intercept Variance")
```
trestbps doesnt have affect -> do we have to normalize values?
dont quite understand how this code works
have difficulty finding examples working on hierarchical logistical regression
