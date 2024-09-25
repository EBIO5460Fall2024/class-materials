### Week 4: Preclass preparation for Thu

Make sure you're caught up on any previous work and you've pushed all your work to GitHub! Don't hesitate to reach out to me for tips with any areas of the homework so far. Or for even faster help, ask questions on Piazza!



####  1. Apply bootstrap to your linear dataset

Use the **empirical** bootstrap algorithm to calculate 95% confidence intervals for the parameters and confidence bands for y. Use the percentile method to do this. Note that this is not simply running your data through one section of my code: you'll need to combine aspects of the code that I introduced in different places to make the algorithm. You'll know you're doing it right if the bootstrap intervals are very similar to the intervals given by `predict()`. **Push your code to GitHub.**



**Learning goals**

* Understand how bootstrap algorithms mimic the sampling distribution algorithm
* Gain intuition for the plug in principle by using it directly
* Use simulation to understand how the sampling distribution is the basis for frequentist inference
* Develop algorithms from first principles that can be applied to any model



The bootstrap is a powerful algorithmic inference tool. You can use this whenever there is not a pre-built way to assess uncertainty, which is common with one-off models tailored to your biological system or question.

