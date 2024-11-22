### Week 14: Preclass preparation for Tue-Thu

Skill of the week: LaTex for mathematical equations. Reading: binomial and other distributions. Independent project: writing the mathematical model, simulating data, writing the linear model formula, a first attempt at fitting a model.



#### 1. Skill of the week: LaTeX for mathematical equations

* Tutorial: [repsci06_markdown_equations.md](skills_tutorials/repsci06_markdown_equations.md)



#### 2. Reading: Binomial distribution and others

Last week we used the binomial distribution as part of the Swiss breeding bird survey case study. Further reading on the binomial distribution is the short section from Chapter 4 of Ben Bolker's book. The section called *Bestiary of distributions* is a handy reference. If you haven't already read it from the earlier homework, it is worth reading through the whole of *Bestiary of distributions* to get a sense of what distributions might be relevant to your individual project.



#### 3. Writing the mathematical model

You might find this challenging but it's important to try to do this. It will help you greatly to understand the model(s) that you're attempting to train and use for inference.

1. Write down the statistical model for the data structure of your independent project using mathematical notation. I typically start with pencil and paper.
   * Write down two parameterizations of the model: the multilevel parameterization and the alternative parameterization, as we covered in class.
   * Review Gelman & Hill Ch 12.5 (Five ways to write the same model).
   * Review lecture notes on models for radon and ants
     * [12_4_slides_tue_priors_checks_multilevel.pdf](12_4_slides_tue_priors_checks_multilevel.pdf)
     * [12_6_slides_thu_multilevel_radon.pdf](12_6_slides_thu_multilevel_radon.pdf)
     * [13_2_slides_tue_nested_scales.pdf](13_2_slides_tue_nested_scales.pdf)
     * [13_3_slides_tue_ants_GLMM.pdf](13_3_slides_tue_ants_GLMM.pdf)
2. Translate your equations to LaTeX in a markdown `.md` document (generated from `.R` or `.Rmd`).
3. Include parameter and variable definitions and notes about your model with your equations.
4. **Push your markdown to GitHub**

Don't be concerned if you feel uncertain about this. This is a first draft of the model! I have almost never written down the best model the first time and we have continually iterated models for some designs (e.g. the Wog Wog experiment) over many years. Tips:

* The data scale might not be Normal (e.g. might be Poisson or binomial)
* The grouping scales will always be Normal for GLMMs by definition
* If you have multiple scales of nesting, it's not too hard - just think about how it should work - it is quite logical. Refer to the lecture slides on nested scales (see above)
* If your intended model is complicated, dial back your first attempts. Start with a simpler model, e.g. with a subset of your data, fewer predictors, or fewer scales.



#### 4. Simulate data from your model

Generate simulated data from your model to solidify your understanding of the model (the data generating process). Then fit your model to the simulated data to check that your model, training, and inference algorithms are working as intended. See the ants example in [14_2_ants_simulated_data.Rmd](14_2_ants_simulated_data.Rmd). We'll consider more examples in class this week.

**Push your script to GitHub**

