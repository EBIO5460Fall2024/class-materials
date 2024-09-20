# Sampling distribution algorithm for the average weight of a beetle species

reps <- 100000 #higher gives closer to true sampling distribution
mean <- 0.1    #grams; we're guessing a value here
sd <- 0.02     #weights vary by about 20% of 1 g
n <- 10        #sample size; try varying this

mean_weights <- rep(NA, reps)
for ( i in 1:reps ) {
    # data generating process (our assumed truth)
    sample_weights <- rnorm(n, mean, sd)
    # sample statistic
    sample_mean <- mean(sample_weights)
    mean_weights[i] <- sample_mean
}
hist(mean_weights, breaks=50)


