### Week 9: Preclass preparation for Tue-Thu

This week we'll cover checking model assumptions, visualization theory, and start on generalized linear models (GLMs). Again this is all the homework for the week up front and you can work at your own pace. We will talk about visualization theory and `ggplot`on Thursday, so be sure to have read the paper by then. There is additional reading in [09_1_reading.md](09_1_reading.md).



#### 1. Complete coding the Rosenbluth-Metropolis algorithm

You made great progress on coding this in class. Group leaders please be sure to share the draft code with your group. You'll use this to fit the linear model to the dataset you've been working with so far. From talking to groups on Thursday, here are some of the things we covered:

* It's neat of you set up the model as a collection of functions

  * linear model
  * log likelihood
  * priors

* There are three parameters and each needs a prior (consult McElreath Ch8 for appropriate ones). You can set up functions for priors like this e.g.:

* ```R
  logprior_b1 <- function(b1) {
      return(dnorm(b1, mean=0, sd=10))
  }
  ```

* When multiplying small probabilities (such as likelihoods), it's a good idea to do calculations on the log scale, by adding and then taking the exponent, e.g.

* ```R
  Posterior_probability <- exp(logprior_b0 + logprior_b1 + logprior_sigma + log_likelihood)
  ```

* For three priors, the total prior probability is simply the product of the three.

* You'll need starting values for parameters. You could start from the same guesses you used in optimizing the likelihood. Or you could randomly draw one from the prior distribution.

* The parameter $\sigma$ might go negative if a proposal takes it there. This is not mathematically a concern as the probability of a negative sigma will be zero (assuming you have set it up with an appropriate positive-only prior). If $\sigma$ happens to be very close to zero, it might mean that negative proposals are common, which could lead to inefficient sampling since many of the proposals will be rejected. One strategy could be to make the proposal step on the log scale. You won't necessarily need to do this.

* You'll need to tune the three `max_d` parameters (one for each parameter). What makes for a good tune? It's good if a plot of the posterior sample chain looks like a hairy caterpillar. If the chain wanders about, the step size (hence `max_d`) is probably too small. An acceptance ratio of about 0.3-0.4 is regarded as a good thing to aim for.

* You can calculate the acceptance ratio by keeping track of the total number of iterations and accepted samples.

* Plot the chain for each parameter to check for hairy caterpillars! e.g.

* ```
  plot(1:n_samples, samples$b0, type="l")
  ```

* To plot the posterior with good detail, make a histogram with lots of bins, e.g.

* ```
  hist(samples$b0, breaks=100)
  ```

* Calculate posterior means and credible intervals for the parameters (see McElreath Ch8).

* Compare your parameter estimates and their credible intervals to your previous analyses with this dataset. You should get similar values.

**Push `.R`  file to GitHub.**



#### 2. Skill of the week: Visualization

* Theory and concepts behind `ggplot`. Read Wickham's paper:
* http://vita.had.co.nz/papers/layered-grammar.pdf
* Work through Chapter 1 of R for Data science, including the exercises:
* https://r4ds.hadley.nz/data-visualize.html
* We'll be using `ggplot` a lot from now on.
