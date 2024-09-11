# Data generating process model for the organism movement example

# For a single individual, printing all the steps

prob_move <- 0.2
t_finish <- 10
dt <- 0.1
position <- 0
t <- 0
while ( t < t_finish ) {
    if ( runif(1) < prob_move ) {
        if ( runif(1) < 0.5 ) {
            position <- position - 1
        } else {
            position <- position + 1
        }
    }
    t <- t + dt
    print(position)
}



# For multiple individuals
prob_move <- 0.2
t_finish <- 10
dt <- 0.1
num_reps <- 100000 #use less for shorter runs but 100K+ for more accuracy
final_position <- rep(NA, num_reps)
for ( i in 1:num_reps ) {
    position <- 0
    t <- 0
    while ( t < t_finish ) {
        if ( runif(1) < prob_move ) {
            if ( runif(1) < 0.5 ) {
                position <- position - 1
            } else {
                position <- position + 1
            }
        }
        t <- t + dt
    }
    final_position[i] <- position
}
hist(final_position)
mean(final_position)
sd(final_position)
range(final_position)

# Histogram with density scaling and Normal distribution overlaid
hist(final_position, freq=FALSE, breaks=seq(-25.5, 25.5))
final_position_x <- seq(-20, 20, by=0.1)
pd <- dnorm(final_position_x, mean=mean(final_position), sd=sd(final_position))
lines(final_position_x, pd, lwd=2, col="blue")
