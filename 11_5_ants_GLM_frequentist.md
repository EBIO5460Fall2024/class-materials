Ant data Generalized Linear Model - frequentist
================
Brett Melbourne
11 Oct 2018 (updated 24 Oct 2022)

Fourth in a series of scripts to analyze the ant data described in
Ellison (2004). This script demonstrates frequentist inference from the
Poisson-log link GLM (model training is by maximum likelihood). Previous
scripts have considered visualization, fitting linear-Normal models with
likelihood and SSQ, model checking, and Bayesian inference. Here we fit
the model using the function `glm()` in the `stats` package of base R,
which uses model syntax like `lm()`. The next script will again fit the
model using a Bayesian approach but with the analogous `stan_glm()`
function from the `rstanarm` package. Future scripts will consider
multilevel models to fully account for the design structure and data
variance.

``` r
library(ggplot2)
theme_set(theme_bw())
```

Read in and plot the data

``` r
ant <- read.csv("data/ants.csv")
ant$habitat <- factor(ant$habitat)
ant |> 
    ggplot(mapping=aes(x=latitude, y=richness, col=habitat)) +
    geom_point()
```

![](11_5_ants_GLM_frequentist_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

## Model

The model is the same as in the previous Bayesian script, except now we
don’t have priors for the parameters.

$$
\begin{align}
  y_i &\sim \mathrm{Poisson}(\mu_i) && \\
  log(\mu) &= \beta_0 \mathrm{intercept}_i + 
              \beta_1 \mathrm{forest}_i + 
              \beta_2 \mathrm{latitude}_i + 
              \beta_3 \mathrm{forest}_i \mathrm{latitude}_i &&
\end{align}
$$

## Training

Train the model using `glm()`. The training algorithm is a specialized
algorithm for maximum likelihood estimation of exponential
distribution-family models called iterative weighted least squares
(Nelder & Wedderburn 1972), a variant of the Newton-Raphson method.

``` r
fitHxL <- glm(richness ~ habitat + latitude + habitat:latitude, family=poisson, data=ant)
coef(fitHxL) #Maximum likelihood estimates of parameters
```

    ##            (Intercept)          habitatforest               latitude 
    ##            12.77869292             1.75682959            -0.26109963 
    ## habitatforest:latitude 
    ##            -0.02623362

Model checking

``` r
par(mfrow=c(2,2))
plot(fitHxL,1:4, ask=FALSE)
```

![](11_5_ants_GLM_frequentist_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Overall, the diagnostics seem not too bad. It is certainly an
improvement over the Normal linear model we tried before. There is
perhaps still a slight tendency for the standardized residuals to
increase with the mean (we’ll investigate that further later) and there
is a still the same influential point (case 25). We should investigate
the influential point using our case deletion algorithm to examine
parameter sensitivity to this point. We’ll return to that later as we
continue to improve the model.

## Inference

Out of the box inferences about parameter uncertainty come from the
assumption of a Normal sampling distribution for the parameter z-values
(estimate divided by standard error), giving us a p-value for each
parameter.

``` r
summary(fitHxL)
```

    ## 
    ## Call:
    ## glm(formula = richness ~ habitat + latitude + habitat:latitude, 
    ##     family = poisson, data = ant)
    ## 
    ## Coefficients:
    ##                        Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept)            12.77869    4.40625   2.900  0.00373 **
    ## habitatforest           1.75683    5.47728   0.321  0.74840   
    ## latitude               -0.26110    0.10303  -2.534  0.01127 * 
    ## habitatforest:latitude -0.02623    0.12809  -0.205  0.83773   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 102.763  on 43  degrees of freedom
    ## Residual deviance:  50.242  on 40  degrees of freedom
    ## AIC: 218.6
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
coef(summary(fitHxL))[,1:2]   #or use this for just the coefficients
```

However, most of the parameter hypotheses being considered here are not
meaningful, either because we don’t care about them biologically
(e.g. we don’t care about the `intercept` hypothesis that species
richness is different from zero at the equator), or because the
parameters are all interdependent (e.g. the fact that the
`habitatforest` parameter is not significantly different from zero means
nothing because it is balanced against the estimate for
`habitatforest:latitude`). The one slightly meaningful inference is for
the `habitatforest:latitude` parameter, which is telling us that there
is little evidence for an interaction on the scale of the linear
predictor. But even this doesn’t necessarily translate to the biological
hypothesis of no interaction between habitat and latitude since the
relationship with latitude is nonlinear, as we saw in previous scripts.
Take away: most of the hypothesis tests in these summary tables are
usually irrelevant to hypotheses that we are scientifically interested
in, except in infrequent special cases. If we want to test specific
scientific hypotheses, we’ll need to be deliberate about expressing them
as alternative models.

95% confidence intervals for parameters are obtained by profiling the
likelihood surface. This is just as we did earlier by varying one
parameter while optimizing over the others. Here, the intervals are
frequentist and are formed by assuming that the likelihood ratio has a
$\chi ^{2}$ sampling distribution. Note this is not the same as the pure
likelihood intervals we constructed earlier since here the likelihood
ratio is merely a statistic and the inferential basis is the sampling
distribution of the likelihood ratio.

``` r
confint(fitHxL)
```

    ## Waiting for profiling to be done...

    ##                             2.5 %      97.5 %
    ## (Intercept)             4.4193660 21.75722597
    ## habitatforest          -9.1480324 12.38251387
    ## latitude               -0.4714597 -0.06606674
    ## habitatforest:latitude -0.2745658  0.22901128

The correlation matrix for the parameters shows how the `habitatforest`
and `habitatforest:latitude` parameters are highly interdependent.

``` r
cov2cor(vcov(fitHxL))
```

    ##                        (Intercept) habitatforest   latitude
    ## (Intercept)              1.0000000    -0.8044583 -0.9997593
    ## habitatforest           -0.8044583     1.0000000  0.8042646
    ## latitude                -0.9997593     0.8042646  1.0000000
    ## habitatforest:latitude   0.8041116    -0.9997617 -0.8043052
    ##                        habitatforest:latitude
    ## (Intercept)                         0.8041116
    ## habitatforest                      -0.9997617
    ## latitude                           -0.8043052
    ## habitatforest:latitude              1.0000000

Although meaningless for a single model, the log likelihood is useful
for comparison with alternative models. Here’s how we can extract the
log likelihood.

``` r
logLik(fitHxL)
```

    ## 'log Lik.' -105.2982 (df=4)

To construct intervals for the curves, we can use the `predict()`
function. For GLMs, there is no `interval="confidence"` option, so we
have to construct intervals from the standard errors. This is
approximate. More accurate intervals are obtained by parametric
bootstrap.

``` r
newd <- data.frame(latitude = rep(seq(41.92, 45, length.out=100), 2),
                   habitat = factor(rep(c("bog","forest"), each=100)))
preds <- predict(fitHxL, newdata=newd, se.fit=TRUE)
mnlp <- preds$fit        #mean of the linear predictor
selp <- preds$se.fit     #se of the linear predictor
cillp <- mnlp - 2 * selp #lower of 95% CI for linear predictor
ciulp <- mnlp + 2 * selp #upper
cil <- exp(cillp)        #lower of 95% CI for response scale
ciu <- exp(ciulp)        #upper
mu <- exp(mnlp)          #mean of response scale
preds <- cbind(newd,preds,cil,ciu,mu)
```

Plotting model with the data is as for the Bayesian GLM in the previous
script.

``` r
bfc <- c("#d95f02", "#1b9e77") #bog & forest colors
preds |>
    ggplot() +
    geom_ribbon(aes(x=latitude, ymin=cil, ymax=ciu, fill=habitat), alpha=0.2) +
    geom_line(aes(x=latitude, y=mu, col=habitat)) +
    geom_point(data=ant, aes(x=latitude, y=richness, col=habitat)) +
    annotate("text", x=42.7, y=3.3, label="Bog", col=bfc[1]) +
    annotate("text", x=43.85, y=9.5, label="Forest", col=bfc[2]) +
    scale_fill_manual(values=bfc) +
    scale_color_manual(values=bfc) +
    scale_y_continuous(breaks=seq(0, 20, 4), minor_breaks=seq(0, 20, 2)) +
    coord_cartesian(ylim=c(0, 18)) +
    xlab("Latitude (degrees north)") +
    ylab("Ant species richness") +
    theme(legend.position="none")
```

![](11_5_ants_GLM_frequentist_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->
