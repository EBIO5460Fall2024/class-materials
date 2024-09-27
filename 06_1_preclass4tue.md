### Week 6: Preclass preparation for Tue
In this homework we first have a couple of pieces to finish frequentist inference. Then, this upcoming week is all about **likelihood**, which is a second way of **counting the ways data could have happened**. 



#### 1. Apply bootstrap prediction intervals to your linear dataset

Use the **parametric** bootstrap algorithm to calculate 95% prediction intervals for new predicted values of y. Use the percentile method. This is more or less minor modifications to the code we went through in class. Explore the code throughly, line by line, to be sure what it's doing. You'll know you're doing it right if the bootstrap intervals are very similar to the intervals given by `predict(... interval="prediction")`. **Push your code to GitHub.**

Although we're using the linear model here as an example, the bootstrap algorithm for prediction intervals can be applied to any kind of model. This is a powerful, general algorithm for computational frequentist inference.



#### 2. Bootstrapped *p*-values

We didn't get to this in class on Thursday. For better or worse, *p*-values and hypothesis testing are staples in frequentist inference. My philosophy is that if you must go this route, any paper or study should only have one to maybe three *p*-values, only for the key general hypotheses. Most estimated quantities are instead better reported with their confidence intervals. Sometimes the only way to get a *p*-value is by bootstrapping and you can pretty much always do it using a variation of the bootstrap algorithm.

Peruse the example here:
* [05_8_bootstrap_p-value.md](05_8_bootstrap_p-value.md)

Also see the further reading on *p*-values in the reading for this week.




#### 3. Watch my lecture on likelihood inference (intro)
   * [06_2_slides_likelihood_inference.pdf](06_2_slides_likelihood_inference.pdf)
   * [06_2_video_likelihood_inference.md](06_2_video_likelihood_inference.md) - 18 mins



#### 4. Problem set on counting the ways
To get a good intuition for how likelihood works, it's essential to work through a few examples by hand. These are not due Tue but generally are for this week, e.g. you could try one or two each day. You'll spend a little time comparing notes with each other about these on Thursday.
   * Do the following problems from McElreath Chapter 2:
     * 2E1, 2E2, 2E3
     * 2M4, 2M5, 2M7, 2H1
     * use the counting method, i.e. draw forking paths, for the latter 4 problems
   * Challenge problems
     * Extending from 2H1, on the next birth the panda has twins. What are the likelihoods for the two models: M1 Panda is species A; M2: Panda is species B? Recall that the likelihood is the probability of the data given the model.
     * Now calculate the likelihoods if, instead, the next birth was a singleton
   * To learn effectively, I strongly encourage you to do your own work or ask on Piazza before searching for the solutions online. I won't be scoring for correct answers.
   * **Push your answers to GitHub.** Can be a scan or photo of hand-written solutions.
