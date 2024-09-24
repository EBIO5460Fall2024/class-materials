# Fundamental algorithms in data science

Collected here will be the algorithms that we encounter throughout this semester (I'll add them as we go along). They are classified as model, training, or inference algorithm (described in 03_7_slides_3classes_algorithms4ds.pdf). For models, they are also classified as coming from the natural processes, generic generative, or generic algorithmic cultures.



## Overall data science workflow

Type: workflow

```
Plan for data
Acquire data
Manage data
Analyze data
Infer from data
Report about data
```



## Animal movement: discrete random walk, one dimension

Type: model

Culture: Natural process

```
prob_move = 0.2
t_finish = 10
dt = 0.1
position = 0
t = 0
while t < t_finish
    if uniform random number < prob_move
        if uniform random number < 0.5
            position = position - 1
        else
            position = position + 1
    t = t + dt
    print(position)
```



## Simple linear model

Type: model

Culture: Generic generative

```
# Atomic pseudocode
for i in 1:n
    y[i] = b_0 + b_1 * x[i]

# Vectorized pseudocode
y = b_0 + b_1 * x
```



## Logistic growth model

Type: model

Culture: Natural process

```
Define function logistic_growth with arguments r, K, N_0, t
    N_t = N_0 * K * exp(r*t) / ( K + N_0 * (exp(r*t) - 1) )
    return(N_t)
```



## Grid search algorithm illustrated for linear SSQ

Type: training

```
Read in data
Set up values of b0 and b1 to try
Set up storage for ssq, b0, b1
For each value of b0
    For each value of b1
        Calculate model predictions
        Calculate deviations
        Sum squared deviations
        Store ssq, b0, b1
Plot sum of squares profiles (ssq vs b0, ssq vs b1)
Report best ssq, b0, b1
Plot fitted model with the data
```



## A descent algorithm illustrated with the bisection algorithm

Type: training

```
Set f_opt = Inf
Start with 2 parameter (theta) values
Bisect these theta values to create a third theta value
Calculate f(theta) for all parameter values
Make triangle
While f_opt is no longer declining to desired resolution
    Bisect theta for the two lower sides of the triangle
    Calculate f(theta) for all parameter values
    Make lowest triangle
    f_opt = min(f(theta))
Return theta of f_opt
```



## High level algorithm for training models

Type: training

```
Define a biology process function, biology_f(theta)
Define an error function, error_f(theta, data, biology_f)
Optimize error_f with respect to theta given data
```



## Sampling distribution algorithm (exact version)

Type: inference

```
for each possible combination of n sample units
    sample n units from the population
    calculate the sample statistic
plot sampling distribution (histogram) of the sample statistic
```



## Sampling distribution algorithm (law of large numbers version)

Type: inference

```
repeat very many times
    sample n units from the population
    calculate the sample statistic
plot sampling distribution (histogram) of the sample statistic
```



## Sampling distribution algorithm for model parameters

Type: inference

```
repeat very many times
    sample data from the population
    fit the model
    estimate the parameters
plot sampling distribution (histogram) of parameter estimates
```



## Confidence interval coverage algorithm

Type: inference

```
repeat very many times
    sample n units from the population
    calculate the sample statistic
    calculate the interval for the sample statistic
calculate frequency true value is in the interval
```



## Coming up soon

Prediction interval algorithm

P-value algorithm

Bootstrap algorithm

