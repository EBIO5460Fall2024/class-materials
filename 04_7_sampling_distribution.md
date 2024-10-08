Frequentist inference algorithm
================
Brett Melbourne
2024-09-17

Note: The `.md` version of this document is best for viewing on GitHub.
See the `.Rmd` version for the latex equation markup. The `.Rmd` version
does not display the plots in GitHub and is best for viewing within
RStudio.

## The sampling distribution: how frequentists count the ways data could have happened

The sampling distribution is a frequentist conceptualization of our
**big idea in data science** of **counting all the ways the data could
have happened**. It is the key to understanding frequentist inference.
The sampling distribution is the distribution of a sample statistic from
repeatedly sampling the population. There are two critical features of
this frequentist conceptualization:

1.  There is a **real entity**, which is called the **population**.
    Precisely because the population is reality, the characteristics of
    the population are **not random variables**. They are said to be
    “fixed”. An example of a non-random characteristic of a population
    might be its mean or its variance or, more completely, its
    distribution as represented by a histogram that includes every
    single individual. A summary characteristic of a population is
    called a **population statistic**, or **parameter**. Examples
    include the population mean or variance, the slope, $\beta_1$, of
    $y$ on $x$, or the *t*-statistic, or *F*-statistic. Be careful here
    to realize we are talking about the true value of these statistics
    for the **population** not a sample.

2.  We **imagine** all the ways we could have sampled from the
    population, each time calculating a **sample statistic** (e.g. mean,
    variance, slope, *t*-statistic). The sample statistic is a **random
    variable** and it will be different from the population statistic
    (which is not random because there is only one true value). The idea
    is that if we were to repeat the sampling in all the possible ways
    that a sample could be drawn from the population, there would be a
    frequency distribution for the sample statistic, called the
    **sampling distribution**. This distribution is real in the sense
    that since the population is real there exists an exact sampling
    distribution that corresponds to the real population. However, we
    don’t usually do the sampling more than once, so this repeated
    sampling **process** is imaginary. In hand (i.e. our dataset), we
    have only the one sample and the one sample statistic.

### The sampling distribution algorithm

Thus, much of frequentist inference is based on the following underlying
algorithm of an imaginary sampling process:

    for each possible combination of n sample units
        sample n units from the population
        calculate the sample statistic
    plot sampling distribution (histogram) of the sample statistic

Due to the [law of large
numbers](https://en.wikipedia.org/wiki/Law_of_large_numbers), which
states that the average of a large number of trials will converge on the
expected value, the following algorithm is equivalent:

    repeat very many times
        sample n units from the population
        calculate the sample statistic
    plot sampling distribution (histogram) of the sample statistic

You can alternatively think of this latter variant of the sampling
algorithm as corresponding to the idea that the sampling distribution is
the expected distribution under repeated random sampling.

## Simulation for understanding the sampling distribution concept

In any scientific situation, we can never know reality exactly, we can
only infer it or hope to get closer. However, in a simulation, we can
know reality because we program it in, so simulation is very useful for
gaining better intuition about the concept of the sampling distribution.
So let’s explore the sampling distribution by simulation. We will
consider two cases, estimating the prevalence of a pathogen in a
population (below), and an hypothesis test for the slope in simple
linear regression (see the next installment: `lm_ssq_inference.md`).

### Pathogen prevalence in a population

Let’s say we have a population of 132 orange-spotted warblers (a
fictional endangered species; 132 individuals are all that are left) and
we are interested in the prevalence of a certain pathogen because this
pathogen will put the population at a greater risk of extinction. In
reality (the reality inside our simulation), the population is as
follows (individuals infected with the pathogen are coded as 1, while
pathogen free individuals are coded as 0) listed by individual i = 1 …
132:

``` r
pathogen <- c(1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,1,1,0,1,1,0,0,0,1,1,0,0,1,1,0,1,0,0,0,0,
              1,1,1,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,1,1,
              0,1,0,0,0,1,0,0,0,1,0,0,1,0,0,1,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,1,0,1,1,1,0,
              1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1,0,0,1)
```

This population has several characteristics. One characteristic is the
population size

``` r
n_pop <- length(pathogen)
n_pop
```

    ## [1] 132

This is a population statistic. The prevalence of the pathogen is
another characteristic of this population - it is also a population
statistic. The pathogen prevalence of the population is

``` r
pathogen_p_pop <- sum(pathogen) / n_pop #equivalently mean(pathogen)
pathogen_p_pop
```

    ## [1] 0.4242424

Let’s give this true population statistic the symbol $\theta$. Keep in
mind this is the prevalence of the pathogen in the population and is
what we want to find out (i.e. *infer*). This population also has an
exact distribution of pathogen infection, which we can represent by its
histogram.

``` r
hist(pathogen, breaks=seq(-0.5,1.5,1), xlab="Pathogen status (not infected=0, infected=1)",
     main=NA, col="#56B4E9", xaxt="none", freq=FALSE)
axis(1, at=0:1)
```

![](04_7_sampling_distribution_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Now, let’s assume we are in the typical scientific situation of
incomplete knowledge. For example, we do not have data on the infection
status of each bird and we can’t check the infection status of a bird
unless we catch it and take a blood draw. As a precaution, we only want
to handle a small number of birds to obtain blood in case handling them
will put them at greater risk. We’ve decided that we can risk catching
10 birds to determine their infection status. We go ahead and randomly
sample 10 birds from the population:

``` r
set.seed(470) #so this example is reproducible
data <- sample(pathogen, 10)
data
```

    ##  [1] 0 0 0 0 0 0 1 0 0 1

``` r
pathogen_p_sample <- mean(data)
pathogen_p_sample
```

    ## [1] 0.2

We find we have 2 infected birds among the 10 birds we sampled, so the
pathogen prevalence of the sample is 0.2. This is our sample statistic.
We’ll take this sample statistic to be an estimate of the population
statistic and because it’s an estimate we’ll give it the same symbol as
the population but with a little hat over it, $\hat{\theta}$, said
“theta hat”. Notice that our sample statistic of 0.2 is different from
the true population statistic of 0.424.

Frequentists assess the reliability of this estimate for the pathogen
prevalence by invoking the concept of the sampling distribution. What is
the sampling distribution in this case? The sampling distribution is the
distribution of the pathogen prevalence built from all the possible ways
we could have drawn a sample of 10 birds from the population of 132
birds. Remember that we don’t actually take these samples in our
scientific study, we imagine taking them. For example, if we number the
individuals in the population from 1 … 132, in one imaginary sample we
might have birds 12, 13, 15, 23, 40, 45, 60, 92, 94, 114, whereas in
another imaginary sample we might have birds 2, 24, 41, 51, 59, 63, 93,
94, 111, 127. How many possible ways are there to take a sample of 10
birds from a population of 132 birds?

``` r
choose(132, 10)
```

    ## [1] 3.120587e+14

That’s a very large number and it would take us a very long time to try
all the samples. Using R on a typical laptop it takes about 0.01
milliseconds to try one sample, so it would take about 100 years. If we
had access to a large supercomputer, say one capable of processing
10,000 samples simultaneously, we could do it in about 4 days. Instead,
we will take a very large number of random samples, say 100,000, which
will only take a second. The more random samples we take, the closer we
will come to the distribution of the actual combinations. In practice,
because of the [law of large
numbers](https://en.wikipedia.org/wiki/Law_of_large_numbers), 100,000
random samples of 10 birds will be extremely close to the distribution
for all the possible combinations of birds. Indeed, we don’t really need
to consider all the possible sample combinations. If, in our study, we
take a random sample from our population, then that random sampling
procedure corresponds to the idea that the sampling distribution
consists of the expected distribution under repeated random sampling.
Here is the algorithm for the sampling process for our example of the
bird population experiencing a pathogen:

``` r
reps <- 100000
pathogen_p_imagine_samples <- rep(NA, reps) #to hold prevalence from imagined samples
for ( i in 1:reps ) {
    imagine_sample <- sample(pathogen, 10) #randomly sample 10 birds from true population
    pathogen_p_imagine_samples[i] <- mean(imagine_sample) #keep prevalence from sample
}
```

What does this sampling distribution for the pathogen prevalence look
like?

``` r
hist(pathogen_p_imagine_samples, breaks=seq(-0.05, 1.05, 0.1), col="#56B4E9", freq=FALSE,
     xlab="Pathogen prevalence", main=NA, ylim=c(0,2.7))
abline(v=pathogen_p_pop, col="#E69F00", lwd=2)
abline(v=pathogen_p_sample, lwd=2, lty=2)
text(pathogen_p_pop, 2.68, expression(italic(theta)), pos=4)
text(pathogen_p_sample, 2.68, expression(hat(italic(theta))), pos=2)
```

![](04_7_sampling_distribution_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Remember this histogram is the “true” sampling distribution for the
pathogen prevalence given a sample of 10 individuals from the
population. That’s because we sampled from the true population, which we
know exactly because the truth is coded into our simulation. Because we
are drawing samples of 10, the possible prevalences are from 0 to 1 in
steps of 0.1. The true prevalence, $\theta$ is the orange solid line at
0.424. The mean prevalence of this sampling distribution is the same as
the true prevalence of the population (if we increase the number of
samples toward infinity it will match exactly), telling us that the
sample prevalence $\hat{\theta}$ is an unbiased estimator of the
population prevalence $\theta$.

``` r
mean(pathogen_p_imagine_samples)
```

    ## [1] 0.424042

One thing that sometimes confuses people is that we have encountered two
different distributions: the distribution of infected and uninfected
individuals in the population and the sampling distribution of the
prevalence. Notice that the sampling distribution (the second histogram)
is completely different to the distribution of infected and uninfected
individuals in the population (the first histogram). To obtain the
sampling distribution for the prevalence, we have sampled from the
distribution of infected and uninfected individuals in the population.

## Frequentist uncertainty: confidence intervals

How can we use this concept of the sampling distribution to judge the
reliability of an estimate? Let’s consider our one sample of 10
individual birds that we actually took. The pathogen prevalence for this
sample happens to lie at 0.2 in this sampling distribution (the dashed
black line $\hat{\theta}$ in the figure above). What do we expect about
the reliability of the sample prevalence as an estimate $\hat{\theta}$
of the population prevalence $\theta$? To answer that question,
frequentists turn to the **reliability of a procedure** for calculating
an interval, what they call a **confidence interval**. It is called a
confidence interval because it is about the confidence we have in the
procedure for calculating the interval.

A 95% confidence interval is defined as:

> An interval calculated by some procedure that would **contain** (or
> **cover**) the true population value 95% of the time, **if sampling
> and calculating an interval were repeated a very large number of
> times**.

This is often abbreviated to something like “there is a 0.95 probability
that the interval contains the true value”, which is true only if we
keep in mind the precise definition of probability as an imagined
repeated procedure. It is common to reword it subtly as “there is a 0.95
probability that the true value is in the interval”, which seems the
same as the previous abbreviated definition to most people (including
me) since if “the interval contains the true value” then “the true value
is in the interval”. However, it can be argued that once an interval is
calculated, since the true value is fixed, the true value is either in
the interval or it is not, so the probabilities of being in the interval
are respectively 1 when it is in the interval and 0 when it is outside
the interval (Pratt 1961). A lot of arguments ensue around these
semantics. Nevertheless, the important point is that a confidence
interval is about the probability associated with sampling and
calculating an interval (i.e. **the procedure**) and not directly about
the probability for the value of the statistic or parameter (the
pathogen prevalence in this case).

In our example for the pathogen prevalence, how could we construct an
interval with these properties? One approach would recognize that the
sampling distribution is well-approximated by a Normal distribution.
This is because the pathogen prevalence is the result of summing up the
number of infected individuals, so the sampling distribution of the
prevalence fairly quickly approaches a Normal distribution as the sample
size (10 in this case) increases due to the [central limit
theorem](https://en.wikipedia.org/wiki/Central_limit_theorem) (see Big
Ideas in Data Science). It’s not a perfect match (notably, the possible
values of the pathogen prevalence are discrete) but it’s a very good
approximation. Here they are side by side and overlaid:

``` r
par(mfrow=c(1,3))
hist(pathogen_p_imagine_samples, breaks=seq(-0.45, 1.35, 0.1), col="#56B4E9", freq=FALSE,
     xlab="Pathogen prevalence", ylim=c(0,2.7), main="True sampling distribution")
sd_samp <- sd(pathogen_p_imagine_samples) #standard deviation of the true sampling distribution 
pathogen_p_normal_samples <- rnorm(1e6, pathogen_p_pop, sd_samp)
hist(pathogen_p_normal_samples, breaks=seq(-0.45,1.35,0.05), col="#56B4E9", freq=FALSE,
     xlab="Pathogen prevalence", ylim=c(0,2.7), main="Approximating Normal")
hist(pathogen_p_imagine_samples, breaks=seq(-0.45,1.35,0.1), col="#56B4E9", freq=FALSE,
     xlab="Pathogen prevalence", ylim=c(0,2.7), main="Normal overlaid on true")
lines(seq(-0.45, 1.35, 0.01), dnorm(seq(-0.45, 1.35, 0.01), mean=pathogen_p_pop,
      sd=sd_samp), col="#E69F00")
```

![](04_7_sampling_distribution_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

Here, the parameters of the approximating Normal distribution are the
mean and standard deviation of the true sampling distribution. One issue
is apparent: the Normal distribution allows the pathogen prevalence to
be outside the bounds of 0 and 1, which is not actually possible, but
we’ll live with that.

To form a confidence interval we can ask “How far could the true
pathogen prevalence $\theta$ be from the estimate $\hat{\theta}$ that we
obtained in our one sample? The Normal distribution tells us that 95% of
the possible sample pathogen prevalences lie between $-1.96\sigma$ and
$+1.96\sigma$, or close enough to $\pm2\sigma$ (vertical dashed lines in
the graph below). Let’s magnify the approximating Normal distribution
(same histogram as above, just bigger) to see this better:

``` r
par(mfrow=c(1,1))
hist(pathogen_p_normal_samples, breaks=seq(-0.45, 1.35, 0.05), col="#56B4E9", freq=FALSE,
     xlab="Pathogen prevalence", ylim=c(0,2.9), main=NA)
abline(v=pathogen_p_pop, col="#E69F00", lwd=4)
text(pathogen_p_pop,2.9, "True", pos=4)
text(pathogen_p_pop,2.7, "prevalence", pos=4)
abline(v=pathogen_p_pop+2*sd_samp, col="#E69F00", lty=2)
abline(v=pathogen_p_pop-2*sd_samp, col="#E69F00", lty=2)

#upper unusual value
points(pathogen_p_pop+2*sd_samp, 1.5, col="#D55E00", pch=16)
arrows(pathogen_p_pop, 1.5, pathogen_p_pop+2*sd_samp-0.01, 1.5, code=1, angle=90, 
       length=0.12, lwd=2)
text(pathogen_p_pop+sd_samp, 1.5, expression(2*sigma), pos=3)
text(pathogen_p_pop+2*sd_samp, 1.57, "Unlikely high", pos=4)
text(pathogen_p_pop+2*sd_samp, 1.43, "sample prevalence", pos=4)

#lower unusual  value
points(pathogen_p_pop-2*sd_samp, 1.9, col="#D55E00", pch=16)
arrows(pathogen_p_pop, 1.9, pathogen_p_pop-2*sd_samp+0.01, 1.9, code=1, angle=90,
       length=0.12, lwd=2)
text(pathogen_p_pop-sd_samp, 1.9, expression(2*sigma), pos=3)
text(pathogen_p_pop-2*sd_samp-0.45, 1.97, "Unlikely low", pos=4)
text(pathogen_p_pop-2*sd_samp-0.45, 1.83, "sample prevalence", pos=4)
```

![](04_7_sampling_distribution_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

Now, in our scientific scenario we don’t know the true pathogen
prevalence, so we don’t know where the prevalence of our one sample lies
in relation to the true prevalence. What if we happened to draw a very
unlikely sample with a high prevalence way out in the upper tail of the
sampling distribution? Anything beyond $2\sigma$ would have probability
less than 0.025. Thus, the distance from an unlikely high value to the
true mean will be the left arm of our confidence interval (black bar to
left of red sample prevalence). Similarly, what if we happened to draw a
very unlikely sample with a low prevalence way out in the lower tail of
the sampling distribution? The distance from this unlikely low value of
the prevalence will be the right arm of our confidence interval (black
bar to right of red sample prevalence). A confidence interval formed by
adding and subtracting $2\sigma$ from the sample prevalence
$\hat{\theta}$ should contain the true prevalence $\theta$ in 95% of
repeated samples from this sampling distribution.

This is all logical. But there is a problem. When we know the true
sampling distribution we know its standard deviation $\sigma$. However,
when we have only one sample we don’t know the true sampling
distribution and we don’t know the true $\sigma$ of the sampling
distribution. So what do we do? We instead “plug in” the standard error
of the sample as an estimate of $\sigma$ of the sampling distribution:
$$\hat{\sigma} = \frac{s}{\sqrt{n}}$$ where $s$ is the sample standard
deviation. This approach is called the **plug-in principle**. You can
also appreciate now that there are two places where the procedure just
described can go wrong:

1.  The sampling distribution may be far from Normal
2.  The estimated $\sigma$ might be wrong

The sampling distribution is more likely to be Normal enough and
$\hat{\sigma}$ is more likely to be close to $\sigma$ when the sample
size $n$ (the number of individual units in the sample) is large.

### Coverage

Coverage is an important frequentist concept. How often do confidence
intervals calculated from a procedure cover/contain the true value? So,
let’s measure the coverage for the confidence interval procedure we just
described above for the pathogen prevalence. We’ll randomly sample and
calculate an interval repeatedly. How often does the calculated interval
cover the true value? Here is the general algorithm to examine coverage:

    repeat very many times
        sample n units from the population
        calculate the sample statistic
        calculate the interval for the sample statistic
    calculate the frequency with which the true value is in the interval

You can see this algorithm is similar to the sampling distribution
algorithm but now includes calculating an interval as well. Here is the
coverage algorithm in R for our specific example of pathogen prevalence
in our bird population:

``` r
reps <- 100000
interval <- matrix(NA, nrow=reps, ncol=2)
for ( i in 1:reps ) {
    imagine_sample <- sample(pathogen, 10) #randomly sample 10 birds from true population
    pathogen_p_sample <- mean(imagine_sample)
    se_sample <- sd(imagine_sample) / sqrt(10)
    interval[i,] <- c(pathogen_p_sample - 2*se_sample, pathogen_p_sample + 2*se_sample)
}
in_interval <- pathogen_p_pop > interval[,1] & pathogen_p_pop < interval[,2]
sum(in_interval) / reps
```

    ## [1] 0.95616

which is pretty close to the desired coverage of 0.95 and is indeed a
bit conservative since it is greater than 0.95 (i.e. our procedure
produces a 95.6% confidence interval). Let’s see the first 100 of these
intervals compared to the true pathogen prevalence (in blue):

``` r
nd <- 100 #number of intervals to draw
plot(NA, NA, ylim=c(-0.1,1.1), xlim=c(1,nd), type="n", 
     ylab="Pathogen prevalence", xlab="", axes=FALSE)
abline(h=pathogen_p_pop, col="#56B4E9")
intcol <- ifelse(in_interval, "gray", "#E69F00")
segments(1:nd, interval[1:nd,1], 1:nd, interval[1:nd,2], col=intcol)
axis(2)
box()
```

![](04_7_sampling_distribution_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

Several things are apparent.

1.  The location of the intervals varies a lot. Confidence intervals are
    random variables.
2.  The intervals are of different widths.
3.  As expected, about 5 out of 100 (here 6) of the intervals (orange)
    don’t cover the true value.
4.  The true value is often not near the center of the interval.
5.  Many of the intervals include prevalences that are impossible,
    either negative, or greater than one. This is a consequence of
    substituting the Normal distribution for the true sampling
    distribution.

## Summary

- We have seen how the core concept of frequentist inference is the
  sampling distribution of a statistic arising from an imagined repeated
  sampling from the population. The algorithm for this imagined sampling
  process is:

<!-- -->

    repeat very many times
        sample n units from the population
        calculate the sample statistic
    plot sampling distribution (histogram) of the sample statistic

- A confidence interval is:

> An interval calculated by some procedure that would **contain** (or
> **cover**) the true population value 95% of the time, **if sampling
> and calculating an interval were repeated a very large number of
> times**.

- Confidence intervals quantify the **reliability of the procedure** and
  can be constructed from the sampling distribution.
- Since we cannot know the true sampling distribution, we make an
  assumption for what the true sampling distribution is. Furthermore, we
  don’t know the values of the sampling distribution’s parameters, so we
  **plug in** estimates of those from the sample.
- The coverage of an interval procedure calibrates the degree of
  confidence in the procedure.

## References

Pratt JW (1961) Review of “Testing Statistical Hypotheses. E. L.
Lehmann. New York: John Wiley and Sons, Inc., 1959. Pp. xiii, 369.
\$11.00.” Journal of the American Statistical Association 56, 163-167.
