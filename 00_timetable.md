# Semester timetable
This is the timetable we followed last time but I will update it as we go along.



## Week 1

* Intro to data science

  * 3 cultures
  * Models, algorithms, workflows
  * Algorithm classes: model, training, inference

* Productive programming tools

  * IDEs, screen real estate, pseudocode, flowcharts

* Structured programming

* Sequence structure

* Homework

  * Skills: Get set up with Git and GitHub.

  * Mini lecture: What is an algorithm?

  * Reading: How algorithms unite data science



## Week 2

* Version control workflow

* Designing algorithms

* Selection structures

  * Single: if
  * Double: if/else
  * Multiple: if/else if

* Repetition structures

  * Sentinel control: while
  * Counter control: for i in 1:n
  * Vector control: foreach element in vector

* Stacking & nesting control structures

* Homework

  * Skills: Git and GitHub: stage, commit, push, backtrack

  * Mini lecture: Selection structures

  * Coding: Selection structures problem set
  * Coding: sentinel and counter controlled repetition



## Week 3
* Repetition structures

  * until, do-while, foreach object in list

* Model algorithms

  * Simple linear model in math and code

  * Data generating process
  * Stochastic processes
  * Generating random numbers
  * Design an algorithm for animal movement data

* Training algorithms

  * Vary model parameters to minimize distance from data
  * Optimization: grid search
  * Design a grid search algorithm for linear regression


* Homework
  * Mini lecture: Further repetition structures
  * Mini lecture: 3 classes of algorithms
  * Mini lecture: Intro to training algorithms
  * Skills: Using code styles
  * Coding: Repetition structures problem set




## Week 4

* Structured programming: Functions
  * Making programs modular
  * R syntax
  * Scope
* Training models general recipe
  1. Biology function
  2. Error function
  3. Optimize
* Training algorithms: optimization
  * Descent methods: Nelder-Mead simplex algorithm using `optim()`
  * Numerical/analytical methods: SSQ QR decomposition algorithm used in `lm()`
* Inference algorithms intro
  * Inference problems/goals
  * Statistical inference is about accuracy, reliability, uncertainty
  * Looking back or looking forward
  * Looking back: considering the ways data could have happened
* Frequentist inference algorithms
  * The sampling distribution algorithm considers the ways a sample could have happened
  * Plug in principle
  * Confidence intervals from the sampling distribution
  * Coverage algorithm
  * P-value algorithm
  * Prediction intervals

* Homework

  * Mini lecture: Optimization algorithms
  * Mini lecture: Inference algorithms
  * Reading: Sampling distribution
  * Skills: Git and GitHub: amend, .gitignore, GUI

  * Coding: grid search for linear model
  * Coding: grid search training algorithm for mechanistic population growth model
  * Coding: descent training algorithm for mechanistic population growth model



## Week 5

* Frequentist inference algorithm for prediction intervals

* Bootstrap algorithm
  * Plug in a computational sampling algorithm
  * Non-parametric, empirical, parametric
  * Bootstrapped confidence interval
  * Bootstrapped p-value

* Homework
  * Mini lecture: frequentist inference algorithms for `lm()` simple linear model
  * Reading: Bootstrap algorithm
  * Skills: Git and GitHub: branch, merge
  * Coding: confidence versus prediction intervals
  * Coding: bootstrap algorithms

  

## Week 6

* Homework: skills
  * Reproducible science
  * Writing markdown documents
* Homework: reading
  * Pitfalls of p-values
  * Conceptual foundations of likelihood
  * Likelihood inference for the linear model

* Homework: mini lecture
  * Likelihood

* Homework: problem set
  * Likelihood problems from McElreath Ch 2

* Likelihood inference
  * Conditional probability: P(y|theta)
  * Likelihood principle, likelihood function, likelihood ratio
  * Training algorithm: maximum likelihood
  * Inference algorithm: likelihood profiles
  * Pure likelihood intervals
* Homework:
  * Coding likelihood intervals for the linear model

## Week 7

* Homework: skills
  * Practice git branch and merge with your own code
* Homework: reading and mini lecture
  * Bayes' theorem, prior, posterior
* Homework: problem set
  * Bayesian problems from McElreath Ch 2
* Homework: reading & active coding
  * Bayesian model notation
  * Bayesian inference algorithm
  * Coding problems from McElreath Ch 4
* Bayesian inference algorithms
  * Posterior sampling
  * Histograms as approximations to posterior distribution
  * Credible intervals: central posterior interval, highest posterior density interval
  * Prediction intervals
  * Inference for linear models

## Week 8

* Homework: skills
  * Reproducible workflow
  * Render an R script to markdown
* MCMC algorithms for Bayesian training
  * Metropolis-Hastings, Gibbs sampling, Hamiltonian Monte Carlo
  * Stan, rstan, rstanarm
  * MCMC diagnostics
* Further Bayesian topics
  * Choosing priors
  * Posteriors for derived quantities
* Homework: coding
  * McElreath Ch 8 problems
  * Coding the Rosenbluth (Metropolis) algorithm

## Week 9

* Homework: skills
  * Visualization
  * Theory and concepts behind ggplot
  * Using ggplot
* Class: ant species richness dataset
* Model diagnostics
  * Checking model assumptions
  * Assessing training robustness
  * Residuals, influence, leverage, outliers, QQ plots, nonlinearity, non-constant variance
  * Case deletion diagnostics for influence
* Homework: coding
  * Diagnostics for the naive ants linear model

* Generalized linear models (GLMs)
  * Link functions
  * Data distributions in the exponential family

## Week 10

* Homework: skills
  * Data manipulation with `dplyr`
* GLMs: ant data case study
  * Frequentist/likelihood analysis using `glm()`
  * Bayesian analysis using `stan_glm()`


## Week 11

* Homework: skills
  * Tidy data
* Homework: individual project
  * Preproposal
* Data visualization
  * Exploratory data analysis of hierarchical data
  * Using `dplyr` and `ggplot`
* Model formulae in R
  * Shorthand notation for linear model design matrix
* Introduction to multilevel models (Normal, linear)
  * Grouping variables
  * Fixed vs random effects
  * Partial pooling and shrinkage
  * Using `lmer()` and `stan_lmer()`
* Workflow algorithm
  * Sketch the data design
  * Write the equations
  * Linear model syntax

Homework: reading

* Radon multilevel case study (Gelman & Hill Ch 12)

## Week 12

* Homework: skills
  * R markdown
* Homework: individual project
  * Project proposal
  * Begin EDA using dplyr and ggplot
* Radon multilevel case study
  * Likelihood and Bayesian algorithms
  * Predictor variables at different scales
  * Alternative parameterizations
  * Credible and prediction intervals

## Week 13

* Homework: skills
  * Using LaTeX to write equations
* Homework: individual project
  * Modeling predictors at different scales
    * Scales of grouping & predictor variables
    * Sketch data structure, write math, write R model formulae
* Multiple nested scales: math and R formulae
* How multilevel models account for autocorrelation
* Generalized linear mixed models (GLMM)
* Accounting for overdispersion using multilevel models
* Case study: revisiting the ants data as multilevel
  * Math and R formulae
  * Using `glmer()` and `stan_glmer()`

## Week 14

* Homework: individual project
  * Fit multilevel model
* Homework: reading & exercises
  * Experimental design
* Binomial GLMM
* Study design: experimental design and sampling design
  * Replication, randomization, control
  * Multiscale experimental and sampling design (randomized blocks, split plots etc)
  * Grouping models for multilevel designs

## Week 15

* Homework: individual project
  * Draft report
* Homework: reading
  * Cross validation
  * Model selection
* Model selection from various perspectives (frequentist, Bayesian, IC)
  * CV, AIC, BIC, WAIC, LOOIC
* Introduction to machine learning
  * Cross validation algorithm
* Either individual meetings about project or maybe these topics:
  * Priors in multilevel models
  * Zero inflated models

* Fake data simulation of multilevel designs
* Posterior predictive check in Bayesian (and potentially frequentist) models
* Leave-one-out influence check
* Homework: individual project
  * Advanced diagnostics
    * Fake data simulation
    * Posterior predictive check
    * LOO influence check

## Where next?

I am currently designing a full two-semester sequence of this course and am writing a textbook *Data Science for Ecology*. These topics will be covered in the book and a selection in future semesters and seminars:

* Bayes factors
* Permutation inference algorithms
* rstan - beyond GLMMs, general hierarchical models
* Machine learning (see my course website from [Spring 2022](https://github.com/EBIO5460Spring2022/class-materials))
  * regression trees, random forest, boosting, neural networks & deep learning
* Time series analysis
* Spatio-temporal models
* Structural equation models
* Unsupervised learning (aka "multivariate statistics")
* Ecological forecasting (see my course website from [Spring 2020](https://github.com/EBIO6100Spring2020/Class-materials))
