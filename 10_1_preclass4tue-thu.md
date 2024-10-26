### Week 10: Preclass preparation for Tue-Thu

Model checking after training frequentist or likelihood models. R's model-formula syntax. Data manipulation with dplyr from tidyverse. If you didn't do the [reading on GLMs](09_1_reading.md) last week, do that too.



#### 1. Organize your repository

I have put a work checklist in your repository called `00_completed_work`. You'll need to "pull" to fetch it from GitHub. From the command line, navigate to your repo directory, then do

```bash
git pull
```

Please check off the work you've completed and let me know the filenames of each checked item. Each completed piece should have all the files necessary in your repository for me to run it, including data. Check that all code runs.

I can't give you in-depth feedback on everything. That would kill me!

* Choose one piece that you're most proud of.
* Choose two pieces where my feedback could help you grow most as a computational scientist. Rank them 1 and 2. This should be something you want quality feedback on. Don't choose your best work. Remember, the work in this class is for completion.

**Commit changes to the file and push back to GitHub.**



#### 2. Model checking (frequentist and likelihood)

Also known as model diagnostics. This was on the agenda for week 9 but we ran out of time. I have posted a recording from a previous year. View and listen to the lectures on model diagnostics (for Normal linear and generalized linear models). The audio is separate; advance the slides manually. Explore the code.

* Slides: [10_2_slides_model_checking.pdf](10_2_slides_model_checking.pdf)
* [Audio (30 mins)](https://www.dropbox.com/s/xcg22i5vrwcdy53/09_aud1_diagnostics.mp3?dl=0)
* Code: [10_3_diagnostics1.R](10_3_diagnostics1.R), [10_3_diagnostics2.R](10_3_diagnostics2.R)

There is a separate R tutorial for QQ plots (there is no accompanying lecture material). 

* tutorial: [10_3_quantiles-qqplots.md](10_3_quantiles-qqplots.md)

**Additional topic: leverage**

An issue that is not covered in the above lectures is **leverage**. This is a specialist topic for simple linear models and GLMs. The general idea is that a point with high leverage is an influential point in a special way: typically it is at one end of the independent variable and it is far from the fitted line relative to other points. Because of the geometry, the point "pulls" on the line like a lever, thus affecting the estimate of the slope. For Normal linear models and some other GLMs leverage can be visualized like this (where `fit` is the saved fitted-model object from `lm()` or `glm()`):

```r
plot(fit, 5)
```



#### 3. Diagnostics with your linear data

* Construct diagnostic plots for your dataset that you have been using for linear Normal models so far.

* Use the code from your likelihood fit, not from an `lm()` fit. I want you to learn the general ideas that you can code up and apply to any model, not the `lm()` tools that are specialized (but convenient!).

* Construct the following diagnostic plots:

  * Residuals versus fitted values (since your model is normal, you won't need to standardize the residuals)
    * see diagnostics2.R

  * QQ plot
    * see diagnostics1.R


  * Case deletion diagnostics using the leave-one-out (LOO) algorithm
    * see diagnostics2.R

    * Plot likelihood displacement and percent change in parameters

* Describe the patterns in the diagnostic plots. Are any model assumptions violated according to these patterns? Are there any influential points?

* Use a `.R` file  (i.e. not `.Rmd`) .

* **Knit** to a **markdown report** and **push to GitHub.**



#### 4. Video lecture: model formulae

Model formula syntax is a core part of R's regression tools.

* [10_4_slides_model_formulae.pdf](10_4_slides_model_formulae.pdf)
* [10_4_video_model_formulae.md](10_4_video_model_formulae.md) - 8 mins



#### 5. Skill of the week: Data manipulation with dplyr

As we move into data with more complex structure it helps to have a good tool like the `dplyr` package for quickly and consistently manipulating data. Work through chapter 3 of R for Data Science, including the exercises.

* https://r4ds.hadley.nz/data-transform.html



