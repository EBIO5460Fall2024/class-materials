# Semester timetable
Detailed topics for each week



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
  * Coding: Sentinel and counter controlled repetition



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
  * Skills: Using code styles
  * Mini lecture: Further repetition structures
  * Mini lecture: 3 classes of algorithms
  * Mini lecture: Intro to training algorithms
  * Coding: Repetition structures problem set



## Week 4

* Structured programming: functions
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
  * Skills: Git and GitHub: amend, .gitignore, GUI
  * Mini lecture: Optimization algorithms
  * Mini lecture: Inference algorithms
  * Reading: Sampling distribution
  * Coding: Grid search for linear model
  * Coding: Grid search training algorithm for mechanistic population growth model
  * Coding: Descent training algorithm for mechanistic population growth model



## Week 5

* Frequentist inference algorithm for prediction intervals

* Bootstrap algorithm
  * Plug in a computational sampling algorithm
  * Non-parametric, empirical, parametric
  * Bootstrapped confidence interval
  * Bootstrapped p-value

* Homework
  * Skills: Git and GitHub: branch, merge
  * Mini lecture: Frequentist inference algorithms for `lm()` simple linear model
  * Reading: Bootstrap algorithm
  * Coding: Confidence versus prediction intervals
  * Coding: Bootstrap algorithms



## Week 6

* Likelihood inference
  * Conditional probability: P(y|theta)
  * Likelihood principle, likelihood function, likelihood ratio
  * Training algorithm: maximum likelihood
  * Inference algorithm: likelihood profiles
  * Pure likelihood intervals

* Homework
  * Skills: Reproducible science
  * Skills: Writing markdown documents
  * Mini lecture: Likelihood
  * Reading: Pitfalls of p-values
  * Reading: Conceptual foundations of likelihood
  * Reading: Likelihood inference for the linear model
  * Problem set: Likelihood problems from McElreath Ch 2
  * Coding: Likelihood intervals for the linear model



## Week 7

* Bayesian inference algorithms
  * Posterior sampling
  * Histograms as approximations to posterior distribution
  * Credible intervals: central posterior interval, highest posterior density interval
  * Prediction intervals
  * Inference for linear models

* Homework
  * Skills: Practice git branch and merge with your own code
  * Mini lecture & reading: Bayes' theorem, prior, posterior
  * Problem set: Bayesian problems from McElreath Ch 2
  * Reading & active coding:
    * Bayesian model notation
    * Bayesian inference algorithm
    * Coding problems from McElreath Ch 4



## Week 8

* MCMC algorithms for Bayesian training
  * Rosenbluth-Metropolis-Hastings, Gibbs sampling, Hamiltonian Monte Carlo
  * Stan, rstan, rstanarm
  * MCMC diagnostics

* Further Bayesian topics
  * Choosing priors
  * Posteriors for derived quantities

* Homework
  * Skills: Reproducible workflow
  * Skills: Render an R script to markdown
  * Coding: McElreath Ch 8 problems
  * Coding: Rosenbluth (Metropolis) algorithm



## Week 9

* The art of modeling
  * Formulating and writing a model
  * Making assumptions explicit
  * Mapping science questions to models
  * Scope of inference and data design

* Homework
  * Skills: Visualization using ggplot
  * Reading: Theory and concepts behind ggplot



## Week 10

* Visualization
  * Theory
  
  * Grammar of graphics (GOG) theory
  
  * GOG with any plotting tools (including base R)
  
  * GOG with ggplot
  
* Model checking
  * Evaluating model assumptions
  * Assessing training robustness
  * Residuals, leverage, outliers, QQ plots, nonlinearity, non-constant variance
  * Leave one out (case deletion) algorithm for influence
* Generalized linear models (GLMs)
  * Link functions
  * Data distributions
* Homework
  * Skills: Data manipulation with `dplyr`
  * Mini lecture: Model checking
  * Mini lecture: R model formula syntax
  * Coding: Frequentist and likelihood diagnostics for the linear Normal model



## Week 11

* GLMs: ant data case study
  * Bayesian analysis using `ulam` and `stan_glm()`
  * Frequentist/likelihood analysis using `glm()` and bootstrap
  * Derived quantities from posterior or bootstrap samples

* Model checking for Bayesian models
  * MCMC diagnostics
  * Posterior predictive checks

* Priors in Bayesian models
  * From flat to informative
  * How to decide?
  * Visualizing priors and prior predictive distribution

* Homework
  * Skills: Tidy data
  * Reading: Radon multilevel case study (Gelman & Hill Ch 12)
  * Individual project: Preproposal




## Week 12

* Introduction to multilevel models (Normal, linear)
  * Grouping variables
  * Fixed vs random effects
  * Partial pooling and shrinkage
  * Using `lmer()` and `stan_lmer()`
* Data visualization
  * Exploratory data analysis of hierarchical data
  * Using `dplyr` and `ggplot`
* Art of modeling and workflow algorithm
  * Sketch the data design
  * Write the equations
  * Linear model syntax
* Radon multilevel case study
  * Likelihood and Bayesian algorithms
  * Predictor variables at different scales
  * Alternative parameterizations
  * Credible and prediction intervals
* Homework
  * Skills: R markdown
  * Reading: Study design
  * Reading: Multilevel models
  * Individual project: Project proposal



## Week 13

* Multilevel models
  * Math and R formulae for multiple nested scales
  * How multilevel models account for autocorrelation
  * Generalized linear mixed models (GLMM)
  * Accounting for overdispersion using multilevel models

* Case study: revisiting the ants data with multilevel structure
  * Math and R formulae
  * Using `glmer()` and `stan_glmer()`

* Homework
  * Skills: Using LaTeX to write equations
  * Individual project: Modeling predictors at different scales
    * Begin EDA using dplyr and ggplot
    * Scales of grouping & predictor variables
    * Sketch data structure, write math, write R model formulae



## Week 14

* Binomial multilevel model, GLMM

* Study design: experimental design and sampling design
  * Replication, randomization, control
  * Multiscale experimental and sampling design (randomized blocks, split plots etc)
  * Grouping models for multilevel designs

* Homework
  * Individual project: Fit multilevel model
  * Reading & exercises: Experimental design



## Week 15

* Model selection from various perspectives (frequentist, Bayesian, IC)
  * CV, AIC, BIC, WAIC, LOOIC

* Introduction to machine learning
  * Cross validation algorithm

* Either individual meetings about project or maybe these topics:
  * Priors in multilevel models
  * Zero inflated models

* Fake data simulation of multilevel designs

* Posterior predictive check in Bayesian (and potentially frequentist) models

* Homework
  * Individual project: Advanced model checking
    * Fake data simulation
    * Posterior predictive check
    * LOO influence check
  * Individual project: Draft report
  * Reading: Cross validation
  * Reading: Model selection



## Where next?

I am currently designing a full four-semester sequence of this course and am writing a textbook *Data Science for Ecology*. These topics will be covered in the book and a selection in future semesters and seminars:

* Machine learning (see my course website from [Spring 2024](https://github.com/EBIO5460Spring2024/class-materials))
  * bagging, random forests, boosting, stochastic gradient descent, neural networks & deep learning
* Functional & object-oriented programming
* Process modeling with data (course scheduled Spring 2026, last taught as [QEE 2017](https://www.colorado.edu/lab/melbourne/courses))
* Stan: beyond linear hierarchical models
* Approximate Bayesian computation (ABC)
* Spatio-temporal models
* Unsupervised learning (aka "multivariate statistics")
* Ecological forecasting and time series (see my course website from [Spring 2020](https://github.com/EBIO6100Spring2020/Class-materials))
