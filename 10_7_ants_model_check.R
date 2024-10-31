library(ggplot2)

# Read in data
ant <- read.csv("../class-materials/data/ants.csv")
ant$habitat_f <- factor(ant$habitat)

# Plot
ggplot(ant, aes(x=latitude, y=richness, col=habitat)) +
    geom_point() +
    ylim(0, 18)

# Model
lmod <- function(b0_b, b1_b, b0_f, b1_f, habitat, latitude) {
    richness <- ifelse(habitat == "bog",
                       b0_b + b1_b * latitude,
                       b0_f + b1_f * latitude)
    return(richness)
}

# Negative log likelihood
# sigma (sd) enters this function on the log scale
lm_nll <- function(p, richness, habitat, latitude) {
    mu <- lmod(b0_b=p[1], b1_b=p[2], b0_f=p[3], b1_f=p[4], habitat, latitude)
    nll <- -sum(dnorm(richness, mean=mu, sd=exp(p[5]), log=TRUE))
    return(nll)
}

# Optimize with BFGS seems to do best
# sigma will be searched on the log scale
p_start <- c(50, -1, 100, -2, log(3))
fit <- optim(p_start, lm_nll, richness=ant$richness, habitat=ant$habitat,
               latitude=ant$latitude, method="BFGS")
fit

# Estimated linear parameters
beta_0_b <- fit$par[1]
beta_1_b <- fit$par[2]
beta_0_f <- fit$par[3]
beta_1_f <- fit$par[4]
sigma <- exp(fit$par[5]) #backtransform

# Model predictions for a grid of latitudes
predictions <- expand.grid(
    habitat=c("bog", "forest"),
    latitude=seq(min(ant$latitude), max(ant$latitude), length.out=50)
    )
predictions$richness <- lmod(beta_0_b, beta_1_b, beta_0_f, beta_1_f,
                             predictions$habitat, predictions$latitude)

# ---Model check 1. Plot model with the data.
# Does it look sensible? Any obvious issues?

ggplot(ant, aes(x=latitude, y=richness, col=habitat)) +
    geom_point() +
    geom_line(data=predictions) +
    ylim(0, 18)


# ---Model check 2. Residuals vs fitted values
# Fitted values are the predictions of the model for each data point

fv <- lmod(beta_0_b, beta_1_b, beta_0_f, beta_1_f, ant$habitat, ant$latitude)
r <- ant$richness - fv
sr <- r / sigma #standardized residuals

plot(fv, sr, col=ant$habitat_f, ylab="Standardized residuals",
     xlab="Fitted values", main="Residuals vs fitted")
abline(h=0, col="gray")
legend("top", levels(ant$habitat_f), pch=1, col=1:2,
       bty="n", horiz=TRUE, inset=-0.1, xpd=NA)


# ---Model check 3. Scale-location plot
plot(fv, abs(sr), col=ant$habitat_f, ylab="abs(standardized residuals)", 
     xlab="Fitted values", main="Scale-location")



# ---Model check 4. Residuals vs latitude
plot(ant$latitude, sr, col=ant$habitat_f, ylab="Residuals", xlab="Latitude",
     main="Residuals vs latitude")
abline(h=0, col="gray")


# ---Model check 5. Histogram of residuals assessed against theoretical distribution
hist(r, xlab="Residuals", main="Histogram of residuals", freq=FALSE)
rseq <- seq(min(r), max(r), length.out=100)
lines(rseq, dnorm(rseq, mean=0, sd=sigma), col="blue")

# ---Model check 6. Quantile-quantile plot
qqnorm(r)
qqline(r)


# ---Model check 7. Influence of individual points

# Leave one out (LOO) influence algorithm (case deletion diagnostic)
n <- nrow(ant)
case <- 1:n
casedel <- matrix(nrow=n, ncol=6)
pnames <- c("beta_0_b", "beta_1_b", "beta_0_f", "beta_1_f", "sigma", "nll")
colnames(casedel) <- pnames
p_start <- fit$par[1:5]
for ( i in case ) {
    ant_loo <- ant[-i,]
    fitloo <- optim(p_start, lm_nll, richness=ant_loo$richness, 
                    habitat=ant_loo$habitat, latitude=ant_loo$latitude, 
                    method="BFGS")
    casedel[i,1:5] <- fitloo$par
    casedel[i,6] <- fitloo$value
    print(paste("Deleted", i, "of", n, sep=" ")) #Monitoring
}

# Calculate likelihood displacement
LD <- 2 * ( casedel[,"nll"] - fit$val )

# Calculate percent change in parameters
par_pc <- (casedel * NA)[,-6] 
for ( p in 1:5 ) {
    par_pc[,p] <- 100 * ( casedel[,p] - fit$par[p] ) / abs(fit$par[p])
}

# LOO overall influence plot
plot(case, abs(LD), xlab="Case", ylab="Likelihood displacement",
     main="Influence plot")
text(25, abs(LD)[25], "25", cex=0.8, pos=4)

# LOO parameter sensitivities
op <- par(no.readonly = TRUE)
par(mfrow=c(2,3))
ylim <- c(0, max(abs(par_pc)))
for ( i in 1:5 ) {
    plot(case, abs(par_pc[,i]), col=ant$habitat_f, xlab="Case", 
         ylab=paste("abs(% change)", pnames[i]))
    abline(h=0, col="gray")
    legend("top", levels(ant$habitat_f), pch=1, col=1:2,
           bty="n", horiz=TRUE, inset=-0.15, xpd=NA)
    text(25, abs(par_pc[25,i]), "25", cex=0.8, pos=4)
}
mtext("Percent change in parameter without case i", 3, -2.5, outer=TRUE)
par(op)


# Identify case 25
ggplot(ant, aes(x=latitude, y=richness, col=habitat)) +
    geom_point() +
    geom_text(data=ant[25,], label="25", hjust=0) +
    ylim(0, 18)


# Of course many of these plots are very easy for standard lm models
fit_lm <- lm(richness ~ latitude + habitat_f + latitude:habitat_f, data=ant)
plot(fit_lm, 1)
plot(fit_lm, 2)
plot(fit_lm, 3)
plot(fit_lm, 4)


# Let's consider the alternative model with a log(richness) transformation, this
# time with lm tools for brevity
fit_lm_log <- lm(log(richness) ~ latitude + habitat_f + latitude:habitat_f, data=ant)
predictions$habitat_f <- factor(predictions$habitat)
predictions$log_richness <- predict(fit_lm_log, newdata=predictions)
predictions$richness_bt <- exp(predictions$log_richness)

# Plot model with the data, both on log and natural scales
ggplot(NULL, aes(col=habitat)) +
    geom_point(data=ant,         aes(x=latitude, y=log(richness))) +
    geom_line( data=predictions, aes(x=latitude, y=log_richness)) 

ggplot(NULL, aes(col=habitat)) +
    geom_point(data=ant,         aes(x=latitude, y=richness)) +
    geom_line( data=predictions, aes(x=latitude, y=richness_bt)) +
    ylim(0, 18)

# Other model checks. We see that residuals are better behaved and the problem
# with case 25 is reduced.

# Residuals vs fitted
plot(fit_lm_log, 1)

# Scale-location plot
plot(fit_lm_log, 3)

# Residuals vs latitude
r <- fit_lm_log$residuals
plot(ant$latitude, r, col=ant$habitat_f, ylab="Residuals", xlab="Latitude",
     main="Residuals vs latitude")
abline(h=0, col="gray")

# QQ plot
plot(fit_lm_log, 2)

# Histogram of residuals
hist(r, xlab="Residuals", main="Histogram of residuals", freq=FALSE)
rseq <- seq(min(r), max(r), length.out=100)
lines(rseq, dnorm(rseq, mean=0, sd=sd(r)), col="blue")

# LOO influence
plot(fit_lm_log, 4)

# How do we know what to expect? We can simulate a bunch of datasets
# from the model, fit new models and check their diagnostics.
op <- par(no.readonly = TRUE)
par(mfrow=c(4,5))
for ( i in 1:20 ) {
    simdat <- cbind(ant, simulate(fit_lm_log))
    simfit <- lm(sim_1 ~ latitude + habitat_f + latitude:habitat_f, data=simdat)
  #  plot(simfit, 3)
    r <- simfit$residuals
    hist(r, xlab="Residuals", main="Histogram of residuals", freq=FALSE)
    rseq <- seq(min(r), max(r), length.out=100)
    lines(rseq, dnorm(rseq, mean=0, sd=sd(r)), col="blue")
}
par(op)


