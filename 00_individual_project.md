### Guidelines for individual projects
This is meant to be a fairly contained and tractable project, not too complex. There should be only one or two analyses (e.g. don't do 20 separate but essentially the same analyses for each species in your dataset, pick one species!). You might need to pick a smaller part of your question or eventual intended analysis.



#### Goal
Option 1) The most likely goal for most of you will be to conduct a complete Bayesian multilevel analysis, from EDA through inference, including all analysis steps (including diagnostics). The final inference(s) should be displayed graphically with whatever visualizations are most appropriate depending on your scientific questions (e.g. curves with credible intervals; differences between treatment means with credible intervals), preferably with the data shown if that makes sense.

Multilevel analysis means that **at least** one variable will determine partial pooling. This should be a grouping variable (i.e. a random effect grouping variable, e.g. as in "county" or "house" in the radon data, not a fixed-effect grouping variable as in "size" or "treatment").

Option 2) Some other kind of likelihood or Bayesian analysis that extends beyond a standard generalized linear model but is not necessarily multilevel. For example, a process model, nonlinear model, generalized additive model, an unusual type of GLM, or something like that. This would be a sophisticated, self learning type of project compared to option 1.

Option 3) A project based on *data simulation* is an excellent option. You could use this as an opportunity to plan a study or experiment. The goal of a data simulation study would be to come up with a good model for the data generating process. This model could range from a model based on ecological or evolutionary processes to a phenomenological regression type of model. Then you would design a data collection and analysis scheme to best estimate the parameters of the model, or even use a different statistical model to probe the system or predict its behavior.

Option 4) A *reanalysis* is another excellent option. It could be a Bayesian reanalysis of a dataset previously done as frequentist. Is there a paper that inspires you or is connected to your work that you would love to look deeply into to learn more? Do you think you could improve upon a previously published analysis? Or perhaps there's a previous analysis from your lab that might be interesting to see through a Bayesian lens. Of course, the data would need to be available or easily reproducible.



#### Guidelines and ideals
The analysis will be a **Bayesian** analysis

You should use:
* `ggplot` for most plotting
* `dplyr` for data manipulation (unless this doesn't make sense)
* `rstanarm` (e.g. `stan_glmer()` , `stan_lmer()`) 
* if option 2 above, then you might be adventuring into the land beyond `rstanarm`, and might consider `rethinking` or `brms` or `rstan` for analysis

Deviations
* fine to occasionally use `base` graphics as appropriate
* it can be helpful and faster to troubleshoot using `glmer()`
* if Bayesian is too expensive for model selection, use `glmer()` with AICc
* if you use the above two options, the final model should be fit as Bayesian



#### Submit (at least) the following three components:
1. `.R` or `.Rmd` or `.qmd` document (equally acceptable; you should use whatever you prefer in your workflow).
2. Any files required to run your code (data files etc). I should be able to run your code to reproduce the analysis.
3. Report(s) in GitHub markdown format (`.md`) that is rendered from your choice of `.R`, `.Rmd`, `qmd` (this report will include an accompanying folder of figures). Check that this `.md` file displays nicely on the GitHub website.



#### Report
"Report" merely means your analysis with comments but including the five components below. It doesn't mean intro, methods, results etc. Neither is it a formal "results" write up. This would be the code/report that you might make available on GitHub or Figshare or Dryad to accompany your paper. Or it might be for your future self. If you have extensive EDA, it's probably neater if you split the script/report into two: one for EDA and one for the rest.

What should the report include?
1. Exploratory Data Analysis (EDA)
2. Sketch/diagram of the data structure
3. The mathematical model. Should be written in latex and displayed as equations in GitHub markdown. 
4. Research the default priors for your model in the `rstanarm` documentation. Give the exact parameter values for the priors (e.g. $\sigma$ = 2.5). **Justify these choices** or any deviations you made from the defaults.
5. Analysis: see below.




#### Analysis
What should the analysis include?

1. Model fits
2. Model checks (do **and comment on** each of the following)
  * Has the algorithm converged? (e.g. check MCMC chains, R_hat, n_eff)
  * Visualize the model with the data. Does the fitted model represent the data?
  * Conduct posterior predictive checks (Bayesian) or diagnostic checks (Frequentist)
  * Are assumptions met? (e.g. Normality, symmetry, constant variance)
  * Are there any exceptional cases? (e.g. outliers, influence, leverage)
  * Does everything make sense? (e.g. parameter estimates)
3. Model inferences for parameters or predictions **that answer the scientific question**, preferably presented graphically. Don't just include a bunch of random output. Present the inferences that are relevant to the question. **Depending on the question**, these might include:
  * Posterior distributions
  * Point estimates (points, curves, or surfaces) with uncertainty intervals
  * Hypothesis tests
  * Predictive performance
4. Combine statistical inference with scientific reasoning to form conclusions about the scientific questions.



#### Data
Include the data so I can run your code. Our GitHub space is completely private and there is no way that your data can be seen by anyone but you and me, so feel free to include it in your repository. This class space will **never** be made public. If you would rather not post your data, please email it to me.



#### File organization
How you name and organize files is up to you but whatever scheme you use should be easy for me (or anyone else) to understand your organization. I suggest a naming scheme that will group your independent project files together (e.g. precede all files with `ip_` for "independent project"), or a separate folder so I can easily recognize them in your repo. Use numbering to indicate sequences of files.
