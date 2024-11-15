Multilevel model of radon levels M1
================
Brett Melbourne
14 Oct 2018 (updated 12 Nov 2024)

Reading: Chapter 12 of Gelman & Hill

This is part 2: M1 variance components model (G&H 12.2). Here we fit a
simple variance components model of the average that accounts for
grouping structures (in other language, it is purely a random effects
model and does not have any fixed effects). As well as this random
effects model (or partial pooling model) we’ll look at the contrasting
models for no pooling and complete pooling. In part 3 we’ll add a
house-level (G&H 12.3-4) predictor of radon. In part 4, we’ll add a
county-level predictor.

``` r
library(lme4)      #max lik multilevel: lmer(), glmer() etc
library(arm)       #for se.ranef()
library(ggplot2)
library(gridExtra) #arranging multiple plots
library(dplyr)
library(rstanarm)  #Bayesian multilevel: stan_lmer(), stan_glmer() etc
options(mc.cores=parallel::detectCores())
theme_set(theme_bw())
```

Read in data, calculate log radon and convert county to a factor. See
`data/radon_MN_about.txt` for data source.

``` r
radon_dat <- read.csv("data/radon_MN.csv")
radon_dat$log_radon <- log(ifelse(radon_dat$radon==0, 0.1, radon_dat$radon))
radon_dat <- mutate(radon_dat, county=factor(county))
```

### G&H 12.2. Multilevel analysis with no predictors

Our aim here is to look at some models for the mean. We’ll look at three
models:

1.  Complete pooling - the simplest model for the overall mean
2.  No pooling - county means, considering counties as fixed effects
3.  Partial pooling - county means, considering counties as random
    effects

G&H prefer to not use the terms fixed and random but I use them here
because many of you will have learned it this way already. See G&H for
more discussion of this. We will broadly follow Gelman & Hill’s analysis
in Chapter 12 with some elaborations here and there, and we’ll use
`rstanarm` instead of BUGS.

#### Complete pooling model

In this case, complete pooling is just the overall mean. That is, we
omit any data structure or grouping variables.

``` r
poolmean <- mean(radon_dat$log_radon)
poolmean
```

    ## [1] 1.224623

``` r
cp_pred_df <- data.frame(poolmean) #df for use with ggplot
```

#### No pooling model

You can think of **no pooling** as separately calculating an estimate of
the mean for each county. For example, tabulate the means (and sd and
se) for each county:

``` r
lnrad_mean_var <- 
    radon_dat |>
    group_by(county) |>
    summarize(sample_size=n(), cty_mn=mean(log_radon), cty_sd=sd(log_radon)) |>
    mutate(cty_se=cty_sd / sqrt(sample_size)) |>
    mutate(sample_size_jit = jitter(sample_size)) #jitter added for plotting
```

Whenever I do a calculation or summary operation I like to look at the
whole result to check that everything makes sense and scan for problems.
So I would do this to print every row:

``` r
print(lnrad_mean_var, n=Inf) #n=Inf to print all rows
```

But here are the first 10 rows

``` r
print(lnrad_mean_var, n=10) #n=Inf to print all rows
```

    ## # A tibble: 85 × 6
    ##    county     sample_size cty_mn cty_sd cty_se sample_size_jit
    ##    <fct>            <int>  <dbl>  <dbl>  <dbl>           <dbl>
    ##  1 AITKIN               4  0.660  0.459  0.230            4.00
    ##  2 ANOKA               52  0.833  0.770  0.107           52.1 
    ##  3 BECKER               3  1.05   0.750  0.433            3.14
    ##  4 BELTRAMI             7  1.14   0.968  0.366            7.11
    ##  5 BENTON               4  1.25   0.424  0.212            3.84
    ##  6 BIG STONE            3  1.51   0.516  0.298            3.05
    ##  7 BLUE EARTH          14  1.91   0.553  0.148           13.9 
    ##  8 BROWN                4  1.63   0.608  0.304            3.99
    ##  9 CARLTON             10  0.931  0.615  0.194           10.1 
    ## 10 CARVER               6  1.20   1.90   0.777            6.07
    ## # ℹ 75 more rows

In printing the whole data frame I saw that there are three counties
with only one sample, so we were not able to calculate a standard error
for those. We could fix this (by estimating from sample size and sd of
the other counties) but let’s not worry at this stage. Plot what we’ve
got (there is a warning for the missing standard error segment geoms):

``` r
lnrad_mean_var |> 
    ggplot() +
    geom_hline(data=cp_pred_df, mapping=aes(yintercept=poolmean), col="blue") +
    geom_point(mapping=aes(x=sample_size_jit, y=cty_mn)) +
    geom_linerange(mapping=aes(x=sample_size_jit, 
                               ymin=cty_mn - cty_se, 
                               ymax=cty_mn + cty_se)) +
    scale_x_continuous(trans="log", breaks=c(1,3,10,30,100)) +
    labs(x="Sample size in county j",
         y="mean ln(radon) in county j",
         title="No pooling: separate means and standard errors by county")
```

    ## Warning: Removed 3 rows containing missing values or values outside the scale range
    ## (`geom_segment()`).

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

This plot is very similar to G&H Fig. 12.1a but not the same. The blue
line is the completely pooled estimate (the overall mean). Some of the
standard errors are larger than G&H 12.1a because we have calculated
them independently for each county. The three points to the left without
an interval are the ones we couldn’t calculate a standard error for.

Now we’ll do as G&H did in Ch 12. This is also a **no pooling** analysis
for the county means. This analysis does not pool information about the
**means** but it does pool information about the uncertainty (the error
of each observation contributes to an estimate of the mean residual
error). This is sometimes called the **fixed effects model**, where here
`county` is the fixed effect. To fit this model in a frequentist
paradigm we can use `lm()`, which is implicitly a GLM with Normal
distribution and identity link. We fit `county` as a categorical
variable, which gives us estimated means for each county (the maximum
likelihood estimates are the means of the within-county samples). We use
the means parameterization (i.e without the intercept, thus “-1”):

``` r
npfit <- lm( log_radon ~ -1 + county, data=radon_dat )
```

Check the fitted model (diagnostic plots)

``` r
plot(npfit,1:4,ask=FALSE)
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-9-2.png)<!-- -->![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-9-3.png)<!-- -->![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-9-4.png)<!-- -->

The extended left tail, which has the 0 + 0.1 hack, is evident in the QQ
plot but otherwise the diagnostics look good. Let’s also look at a
residuals histogram compared to the Normal distribution:

``` r
r <- residuals(npfit)
x <- seq(min(r), max(r), length.out=100)
y <- dnorm(x, mean(r), sd(r))
res_df <- data.frame(residuals=r)
norm_df <- data.frame(x=x, y=y)
rm(r,x,y)
ggplot() +
    geom_histogram(data=res_df, mapping=aes(x=residuals, y=after_stat(density)), bins=60) +
    geom_line(data=norm_df, mapping=aes(x=x, y=y), col="red")
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

So, Normal looks like an adequate approximation for the errors.

Plot the fitted model

``` r
np_pred_df <- data.frame(coef(summary(npfit))[,1:2], 
                         lnrad_mean_var$sample_size_jit)
names(np_pred_df) <- c("cty_mn","cty_se","sample_size_jit")

gh12.1a <- 
    np_pred_df |> 
    ggplot() +
    geom_hline(data=cp_pred_df, mapping=aes(yintercept=poolmean), col="blue") +
    geom_point(mapping=aes(x=sample_size_jit, y=cty_mn)) +
    geom_linerange(mapping=aes(x=sample_size_jit, 
                               ymin=cty_mn-cty_se, 
                               ymax=cty_mn+cty_se)) +
    scale_x_continuous(trans="log", breaks=c(1,3,10,30,100)) +
    ylim(-0.1, 3.3) +
    labs(x="Sample size in county j",y="mean ln(radon) in county j",
         title="No pooling: estimates from linear fixed-effects model")
gh12.1a
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

Apart from some unimportant details, this is the same as G&H Fig. 12.1a.
The blue line is the complete pooling model (i.e. the overall mean).

#### Partial pooling & shrinkage in multilevel model

In the **complete pooling** model (i.e. the overall mean) we did not
include variation among counties, while in the **no pooling** model, we
estimated the county means separately, whether literally by separate
analyses or in the fixed effects model. In the **partial pooling** model
the estimates for the mean in each county are a balance between the
information in a county sample and information from other counties. To
achieve this, we formulate a **multilevel model**. In the multilevel
model we consider two levels for means: an overall mean and means for
counties. Each of the two levels of these means has an associated
stochastic process so that there are two **variance components**, a
between-county variance associated with the overall mean and a
within-county variance associated with the county means. To fit this
model in a frequentist paradigm we can use `lmer()` from the package
`lme4`. This model is implicitly a generalized linear mixed model (GLMM)
with Normal distribution, identity link, and two levels of
stochasticity:

``` r
ppfit <- lmer( log_radon ~ 1 + (1|county), REML=FALSE, data=radon_dat )
```

The `1` part of the above model specifies the overall mean (the
intercept term) while the `+ (1|county)` part specifies that the
intercepts for each county should be random variables (more specifically
the deviations, or “random effects”, of county means from the overall
mean will be modeled as a Normally distributed random variable).
`REML=FALSE` says to fit by ordinary maximum likelihood rather than the
default residual maximum likelihood.

By default, we get limited diagnostics for `lmer()`. Just residuals vs
fitted. The residual plot looks good though. We will later explore some
other diagnostic options for multilevel likelihood models.

``` r
plot(ppfit)
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

In the summary we now see estimates for two components (or levels, or
strata) of variance: county (among counties) and residual (among houses
within counties):

``` r
summary(ppfit)
```

    ## Linear mixed model fit by maximum likelihood  ['lmerMod']
    ## Formula: log_radon ~ 1 + (1 | county)
    ##    Data: radon_dat
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   2261.2   2275.7  -1127.6   2255.2      916 
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -4.4668 -0.5757  0.0432  0.6460  3.3508 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  county   (Intercept) 0.0934   0.3056  
    ##  Residual             0.6366   0.7979  
    ## Number of obs: 919, groups:  county, 85
    ## 
    ## Fixed effects:
    ##             Estimate Std. Error t value
    ## (Intercept)  1.31226    0.04857   27.02

The random effects table shows that the variance at the houses-within
county level, the residual variance (0.6), is about 6 times greater than
the variance at the between-county level (0.09). In other words, most of
the variance in radon is at a small spatial scale, i.e. between houses.
Keep in mind that the house-level variance includes radon measurement
error in addition to natural variability among houses.

Save a plot of the fitted model

``` r
pp_pred_df <- data.frame(coef(ppfit)$county,
                         se.ranef(ppfit)$county[,1],
                         lnrad_mean_var$sample_size_jit)
names(pp_pred_df) <- c("cty_mn","cty_se","sample_size_jit")
pp_mean_df <- data.frame(ovrl_mn=summary(ppfit)$coefficients[1],
                         ovrl_se=summary(ppfit)$coefficients[2])

gh12.1b <- 
    pp_pred_df |> 
    ggplot() +
    geom_hline(data=cp_pred_df, mapping=aes(yintercept=poolmean), col="blue") +
    geom_hline(data=pp_mean_df, mapping=aes(yintercept=ovrl_mn), 
               col="blue", lty=2) +
    geom_point(mapping=aes(x=sample_size_jit, y=cty_mn)) +
    geom_linerange(mapping=aes(x=sample_size_jit,
                               ymin=cty_mn-cty_se,
                               ymax=cty_mn+cty_se)) +
    scale_x_continuous(trans="log", breaks=c(1,3,10,30,100)) +
    ylim(-0.1, 3.3) +
    labs(x="Sample size in county j",y="mean ln(radon) in county j",
         title="Partial pooling: multilevel model, max likelihood")
```

Add a reference point to the saved no pooling and partial pooling plots
to illustrate shrinkage and plot them side by side:

``` r
gh12.1a_ref <- 
    gh12.1a + 
    geom_point(data=np_pred_df[36,],
               mapping=aes(x=sample_size_jit, y=cty_mn), 
               pch=1, cex=10, col="red")

gh12.1b_ref <- 
    gh12.1b + 
    geom_point(data=pp_pred_df[36,],
               mapping=aes(x=sample_size_jit, y=cty_mn),
               pch=1, cex=10, col="red")

grid.arrange(gh12.1a_ref, gh12.1b_ref, nrow = 1)
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

The right panel is the fitted multilevel model compared to our previous
fit of the no pooling model in the left panel. In the multilevel model
the estimates for the mean in each county are a balance between the
sample mean and the overall mean, depending on the within-county sample
size. That is, the information in a particular county is pooled with the
information from other counties. You can see how this works by comparing
the multilevel (partial pooling) model in the right panel to the no
pooling model in the left panel. If there are more observations for a
given county, there is more information at the county level, so the
estimate of the county mean in the multilevel model remains close to the
sample mean for the county. If there are fewer observations, information
from the other counties will pull an estimate for a particular county
toward the overall mean, like county 36, which is circled in red. This
is called **shrinkage**. The estimate shrinks toward the overall mean.
The other thing to note is the dashed blue line. This is the estimated
overall mean from the multilevel model, which is also a balance of the
information at different levels. You can see that it is higher than the
simpler (but naive) overall mean of the data (solid blue line).

#### Partial pooling, Bayesian fit of multilevel model

Figure 12.1b in G&H was actually from a Bayesian version of the
multilevel model fitted using BUGS. Compared to the maximum likelihood
model we just fitted, G&H’s model had flat priors for the three model
parameters (overall mean and the two variances). The Bayesian version of
our model is accomplished easily with the `stan_lmer()` function of
`rstanarm`. We will use the weakly informative priors of `stan_lmer()`
by default rather than the flat priors in the BUGS fit of G&H. The
difference in analyses is negligible as the data overwhelm the priors.

``` r
ppfit_bayes <- stan_lmer(log_radon ~ 1 + (1|county), data=radon_dat)
print(summary(ppfit_bayes)[,c("mean","sd","n_eff","Rhat")], digits=3)
```

    ##                                              mean     sd n_eff  Rhat
    ## (Intercept)                              1.31e+00 0.0497  1177 1.002
    ## b[(Intercept) county:AITKIN]            -2.51e-01 0.2536  5129 1.000
    ## b[(Intercept) county:ANOKA]             -4.21e-01 0.1135  3002 1.000
    ## b[(Intercept) county:BECKER]            -7.91e-02 0.2579  5205 1.000
    ## b[(Intercept) county:BELTRAMI]          -8.16e-02 0.2203  4247 0.999
    ## b[(Intercept) county:BENTON]            -2.46e-02 0.2522  5920 1.000
    ## b[(Intercept) county:BIG_STONE]          7.17e-02 0.2566  5311 1.000
    ## b[(Intercept) county:BLUE_EARTH]         4.04e-01 0.1797  4531 1.000
    ## b[(Intercept) county:BROWN]              1.28e-01 0.2467  5271 1.000
    ## b[(Intercept) county:CARLTON]           -2.29e-01 0.1996  5219 0.999
    ## b[(Intercept) county:CARVER]            -5.29e-02 0.2333  4893 1.001
    ## b[(Intercept) county:CASS]               3.71e-02 0.2367  4869 1.000
    ## b[(Intercept) county:CHIPPEWA]           1.57e-01 0.2457  5764 1.000
    ## b[(Intercept) county:CHISAGO]           -1.29e-01 0.2227  5315 1.000
    ## b[(Intercept) county:CLAY]               3.19e-01 0.1809  4281 1.001
    ## b[(Intercept) county:CLEARWATER]        -1.30e-01 0.2502  4835 0.999
    ## b[(Intercept) county:COOK]              -1.50e-01 0.2866  5400 1.000
    ## b[(Intercept) county:COTTONWOOD]        -2.21e-01 0.2565  4351 0.999
    ## b[(Intercept) county:CROW_WING]         -2.39e-01 0.1918  3803 1.001
    ## b[(Intercept) county:DAKOTA]            -1.60e-02 0.1036  3064 1.000
    ## b[(Intercept) county:DODGE]              1.56e-01 0.2617  5573 1.000
    ## b[(Intercept) county:DOUGLAS]            1.94e-01 0.2038  5618 1.000
    ## b[(Intercept) county:FARIBAULT]         -3.81e-01 0.2391  4883 1.000
    ## b[(Intercept) county:FILLMORE]          -5.84e-02 0.2744  5312 0.999
    ## b[(Intercept) county:FREEBORN]           3.60e-01 0.2122  4480 1.000
    ## b[(Intercept) county:GOODHUE]            3.61e-01 0.1864  4461 1.001
    ## b[(Intercept) county:HENNEPIN]          -2.32e-02 0.0912  2419 1.001
    ## b[(Intercept) county:HOUSTON]            1.06e-01 0.2198  5498 1.000
    ## b[(Intercept) county:HUBBARD]           -2.14e-01 0.2393  4623 1.000
    ## b[(Intercept) county:ISANTI]            -8.40e-02 0.2562  5179 0.999
    ## b[(Intercept) county:ITASCA]            -2.39e-01 0.2007  5006 0.999
    ## b[(Intercept) county:JACKSON]            3.09e-01 0.2421  5095 1.000
    ## b[(Intercept) county:KANABEC]           -2.37e-02 0.2390  5576 1.000
    ## b[(Intercept) county:KANDIYOHI]          2.85e-01 0.2491  4149 1.000
    ## b[(Intercept) county:KITTSON]           -5.78e-02 0.2611  6160 0.999
    ## b[(Intercept) county:KOOCHICHING]       -4.65e-01 0.2281  4284 1.000
    ## b[(Intercept) county:LAC_QUI_PARLE]      3.07e-01 0.2764  4142 1.000
    ## b[(Intercept) county:LAKE]              -5.74e-01 0.2210  4562 1.000
    ## b[(Intercept) county:LAKE_OF_THE_WOODS]  7.93e-02 0.2445  5745 1.000
    ## b[(Intercept) county:LE_SUEUR]           1.25e-01 0.2416  6190 1.000
    ## b[(Intercept) county:LINCOLN]            3.10e-01 0.2470  4715 1.000
    ## b[(Intercept) county:LYON]               3.12e-01 0.2131  4752 1.000
    ## b[(Intercept) county:MAHNOMEN]           1.28e-02 0.2974  5127 1.000
    ## b[(Intercept) county:MARSHALL]          -6.47e-02 0.2066  5694 1.000
    ## b[(Intercept) county:MARTIN]            -1.94e-01 0.2208  5167 1.000
    ## b[(Intercept) county:MCLEOD]            -1.55e-01 0.1818  4565 1.000
    ## b[(Intercept) county:MEEKER]            -3.94e-02 0.2301  5462 1.000
    ## b[(Intercept) county:MILLE_LACS]        -1.88e-01 0.2808  4872 1.000
    ## b[(Intercept) county:MORRISON]          -1.39e-01 0.2046  5084 1.000
    ## b[(Intercept) county:MOWER]              1.82e-01 0.1834  4198 1.000
    ## b[(Intercept) county:MURRAY]             1.63e-01 0.2968  4663 1.000
    ## b[(Intercept) county:NICOLLET]           3.29e-01 0.2599  5210 1.000
    ## b[(Intercept) county:NOBLES]             1.95e-01 0.2663  4526 0.999
    ## b[(Intercept) county:NORMAN]            -8.88e-02 0.2671  5972 1.000
    ## b[(Intercept) county:OLMSTED]           -7.42e-02 0.1534  4503 1.001
    ## b[(Intercept) county:OTTER_TAIL]         2.15e-02 0.2096  5100 0.999
    ## b[(Intercept) county:PENNINGTON]        -2.22e-01 0.2663  5472 0.999
    ## b[(Intercept) county:PINE]              -3.14e-01 0.2354  4573 0.999
    ## b[(Intercept) county:PIPESTONE]          1.45e-01 0.2477  5492 0.999
    ## b[(Intercept) county:POLK]               2.22e-02 0.2554  5285 1.000
    ## b[(Intercept) county:POPE]              -8.00e-03 0.2705  5591 1.000
    ## b[(Intercept) county:RAMSEY]            -1.81e-01 0.1348  3974 1.000
    ## b[(Intercept) county:REDWOOD]            2.29e-01 0.2358  5012 0.999
    ## b[(Intercept) county:RENVILLE]           3.11e-02 0.2633  4831 1.000
    ## b[(Intercept) county:RICE]               2.90e-01 0.1932  4070 1.000
    ## b[(Intercept) county:ROCK]              -1.10e-02 0.2791  5114 1.000
    ## b[(Intercept) county:ROSEAU]            -3.79e-02 0.1764  5279 1.000
    ## b[(Intercept) county:SCOTT]              1.80e-01 0.1825  5298 1.000
    ## b[(Intercept) county:SHERBURNE]         -1.25e-01 0.2073  5187 1.001
    ## b[(Intercept) county:SIBLEY]            -2.29e-02 0.2525  5158 1.000
    ## b[(Intercept) county:ST_LOUIS]          -5.13e-01 0.0874  2677 1.001
    ## b[(Intercept) county:STEARNS]            5.28e-02 0.1476  4212 1.000
    ## b[(Intercept) county:STEELE]             1.61e-01 0.2010  3954 1.000
    ## b[(Intercept) county:STEVENS]            1.11e-01 0.2786  4968 0.999
    ## b[(Intercept) county:SWIFT]             -1.21e-01 0.2549  5055 1.000
    ## b[(Intercept) county:TODD]               5.54e-02 0.2522  6308 1.000
    ## b[(Intercept) county:TRAVERSE]           1.93e-01 0.2588  5663 0.999
    ## b[(Intercept) county:WABASHA]            2.08e-01 0.2190  5092 1.000
    ## b[(Intercept) county:WADENA]            -1.40e-01 0.2355  4983 1.000
    ## b[(Intercept) county:WASECA]            -3.33e-01 0.2527  4417 1.000
    ## b[(Intercept) county:WASHINGTON]        -4.97e-02 0.1145  2747 1.000
    ## b[(Intercept) county:WATONWAN]           2.84e-01 0.2730  4947 1.000
    ## b[(Intercept) county:WILKIN]             1.28e-01 0.2905  5467 1.000
    ## b[(Intercept) county:WINONA]             9.73e-02 0.1787  4804 1.000
    ## b[(Intercept) county:WRIGHT]             1.87e-01 0.1786  5571 1.000
    ## b[(Intercept) county:YELLOW_MEDICINE]   -3.62e-02 0.2781  5325 1.000
    ## sigma                                    7.98e-01 0.0195  4994 1.000
    ## Sigma[county:(Intercept),(Intercept)]    1.01e-01 0.0308  1478 1.001
    ## mean_PPD                                 1.22e+00 0.0364  4146 1.000
    ## log-posterior                           -1.22e+03 9.1059   979 1.004

Diagnostics: We have previously made trace plots and histograms manually
from samples. A handy tool is the shiny app included with `rstanarm`.
Focus on inspecting convergence in the trace plots and histograms for
the posteriors.

``` r
launch_shinystan(ppfit_bayes)
```

Extract posterior samples

``` r
samples <- as.data.frame(ppfit_bayes$stanfit)
names(samples)
```

    ##  [1] "(Intercept)"                            
    ##  [2] "b[(Intercept) county:AITKIN]"           
    ##  [3] "b[(Intercept) county:ANOKA]"            
    ##  [4] "b[(Intercept) county:BECKER]"           
    ##  [5] "b[(Intercept) county:BELTRAMI]"         
    ##  [6] "b[(Intercept) county:BENTON]"           
    ##  [7] "b[(Intercept) county:BIG_STONE]"        
    ##  [8] "b[(Intercept) county:BLUE_EARTH]"       
    ##  [9] "b[(Intercept) county:BROWN]"            
    ## [10] "b[(Intercept) county:CARLTON]"          
    ## [11] "b[(Intercept) county:CARVER]"           
    ## [12] "b[(Intercept) county:CASS]"             
    ## [13] "b[(Intercept) county:CHIPPEWA]"         
    ## [14] "b[(Intercept) county:CHISAGO]"          
    ## [15] "b[(Intercept) county:CLAY]"             
    ## [16] "b[(Intercept) county:CLEARWATER]"       
    ## [17] "b[(Intercept) county:COOK]"             
    ## [18] "b[(Intercept) county:COTTONWOOD]"       
    ## [19] "b[(Intercept) county:CROW_WING]"        
    ## [20] "b[(Intercept) county:DAKOTA]"           
    ## [21] "b[(Intercept) county:DODGE]"            
    ## [22] "b[(Intercept) county:DOUGLAS]"          
    ## [23] "b[(Intercept) county:FARIBAULT]"        
    ## [24] "b[(Intercept) county:FILLMORE]"         
    ## [25] "b[(Intercept) county:FREEBORN]"         
    ## [26] "b[(Intercept) county:GOODHUE]"          
    ## [27] "b[(Intercept) county:HENNEPIN]"         
    ## [28] "b[(Intercept) county:HOUSTON]"          
    ## [29] "b[(Intercept) county:HUBBARD]"          
    ## [30] "b[(Intercept) county:ISANTI]"           
    ## [31] "b[(Intercept) county:ITASCA]"           
    ## [32] "b[(Intercept) county:JACKSON]"          
    ## [33] "b[(Intercept) county:KANABEC]"          
    ## [34] "b[(Intercept) county:KANDIYOHI]"        
    ## [35] "b[(Intercept) county:KITTSON]"          
    ## [36] "b[(Intercept) county:KOOCHICHING]"      
    ## [37] "b[(Intercept) county:LAC_QUI_PARLE]"    
    ## [38] "b[(Intercept) county:LAKE]"             
    ## [39] "b[(Intercept) county:LAKE_OF_THE_WOODS]"
    ## [40] "b[(Intercept) county:LE_SUEUR]"         
    ## [41] "b[(Intercept) county:LINCOLN]"          
    ## [42] "b[(Intercept) county:LYON]"             
    ## [43] "b[(Intercept) county:MAHNOMEN]"         
    ## [44] "b[(Intercept) county:MARSHALL]"         
    ## [45] "b[(Intercept) county:MARTIN]"           
    ## [46] "b[(Intercept) county:MCLEOD]"           
    ## [47] "b[(Intercept) county:MEEKER]"           
    ## [48] "b[(Intercept) county:MILLE_LACS]"       
    ## [49] "b[(Intercept) county:MORRISON]"         
    ## [50] "b[(Intercept) county:MOWER]"            
    ## [51] "b[(Intercept) county:MURRAY]"           
    ## [52] "b[(Intercept) county:NICOLLET]"         
    ## [53] "b[(Intercept) county:NOBLES]"           
    ## [54] "b[(Intercept) county:NORMAN]"           
    ## [55] "b[(Intercept) county:OLMSTED]"          
    ## [56] "b[(Intercept) county:OTTER_TAIL]"       
    ## [57] "b[(Intercept) county:PENNINGTON]"       
    ## [58] "b[(Intercept) county:PINE]"             
    ## [59] "b[(Intercept) county:PIPESTONE]"        
    ## [60] "b[(Intercept) county:POLK]"             
    ## [61] "b[(Intercept) county:POPE]"             
    ## [62] "b[(Intercept) county:RAMSEY]"           
    ## [63] "b[(Intercept) county:REDWOOD]"          
    ## [64] "b[(Intercept) county:RENVILLE]"         
    ## [65] "b[(Intercept) county:RICE]"             
    ## [66] "b[(Intercept) county:ROCK]"             
    ## [67] "b[(Intercept) county:ROSEAU]"           
    ## [68] "b[(Intercept) county:SCOTT]"            
    ## [69] "b[(Intercept) county:SHERBURNE]"        
    ## [70] "b[(Intercept) county:SIBLEY]"           
    ## [71] "b[(Intercept) county:ST_LOUIS]"         
    ## [72] "b[(Intercept) county:STEARNS]"          
    ## [73] "b[(Intercept) county:STEELE]"           
    ## [74] "b[(Intercept) county:STEVENS]"          
    ## [75] "b[(Intercept) county:SWIFT]"            
    ## [76] "b[(Intercept) county:TODD]"             
    ## [77] "b[(Intercept) county:TRAVERSE]"         
    ## [78] "b[(Intercept) county:WABASHA]"          
    ## [79] "b[(Intercept) county:WADENA]"           
    ## [80] "b[(Intercept) county:WASECA]"           
    ## [81] "b[(Intercept) county:WASHINGTON]"       
    ## [82] "b[(Intercept) county:WATONWAN]"         
    ## [83] "b[(Intercept) county:WILKIN]"           
    ## [84] "b[(Intercept) county:WINONA]"           
    ## [85] "b[(Intercept) county:WRIGHT]"           
    ## [86] "b[(Intercept) county:YELLOW_MEDICINE]"  
    ## [87] "b[(Intercept) county:_NEW_county]"      
    ## [88] "sigma"                                  
    ## [89] "Sigma[county:(Intercept),(Intercept)]"  
    ## [90] "mean_PPD"                               
    ## [91] "log-posterior"

``` r
samples_mu_bar <- samples$"(Intercept)" #Samples of overall mean
samples_b <- samples[,2:86] #Samples of county deviations. Samples by row, 85 cols
```

Algorithm for posterior samples of the county means. This is an example
where we want to get the posterior distribution for a **derived
quantity**: the county means. We merely need to add the samples for the
overall mean (`intercept`) to the samples for the county deviations
(`b`).

``` r
countysamples <- samples_b * NA
for ( i in 1:85 ) {
    countysamples[,i] <- samples_b[,i] + samples_mu_bar
}
# Now calculate mean and standard deviation of the posterior distributions for
# the county means.
countypostmns <- rep(NA, 85)
countypostses <- rep(NA, 85)
for ( i in 1:85 ) {
    countypostmns[i] <- mean(countysamples[,i])
    countypostses[i] <- sd(countysamples[,i])
}
```

Plot of posterior means and standard deviations

``` r
ppbayes_pred_df <- data.frame(countypostmns, countypostses, 
                              lnrad_mean_var$sample_size_jit)
names(ppbayes_pred_df) <- c("cty_mn","cty_se","sample_size_jit")
ppbayes_mean_df <- data.frame(mn_mu_bar=mean(samples_mu_bar),
                              se_mu_bar=sd(samples_mu_bar))
gh12.1b_bayes <- 
    ppbayes_pred_df |> 
    ggplot() +
    geom_hline(data=cp_pred_df, mapping=aes(yintercept=poolmean), col="blue") +
    geom_hline(data=ppbayes_mean_df, 
               mapping=aes(yintercept=mn_mu_bar), col="blue", lty=2) +
    geom_point(mapping=aes(x=sample_size_jit, y=cty_mn)) +
    geom_linerange(mapping=aes(x=sample_size_jit,
                               ymin=cty_mn-cty_se,
                               ymax=cty_mn+cty_se)) +
    scale_x_continuous(trans="log", breaks=c(1,3,10,30,100)) +
    ylim(-0.1, 3.3) +
    labs(x="Sample size in county j",y="mean ln(radon) in county j",
         title="Partial pooling: multilevel model, Bayesian")
grid.arrange(gh12.1b, gh12.1b_bayes, nrow = 1)
```

![](12_5_radon_multilevel_M1_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

The maximum likelihood (left) and Bayesian model (right) estimates are
practically identical. This is not surprising, since the priors in the
Bayesian model were weak and thus most of the information is in the
likelihood.
