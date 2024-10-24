# Class demo
library(ggplot2)
library(scales) #for ggplot color palette in function hue_pal

# Read in the data:
ant <- read.csv("../class-materials/data/ants.csv")
ant$habitat <- factor(ant$habitat)


# About factors
class(ant$habitat)
levels(ant$habitat)
ant$habitat
as.numeric(ant$habitat)


# plot.default style
plot(ant$latitude, ant$richness, col=ant$habitat)
legend("topright", levels(ant$habitat), pch=1, col=1:2)


# plot.formula style
plot(richness ~ latitude, col=habitat, data=ant)
legend("topright", levels(ant$habitat), pch=1, col=1:2)


# Using with() to specify the dataframe
with(ant, plot(latitude, richness, col=habitat))
with(ant, legend("topright", levels(habitat), pch=1, col=1:2))

# Or

with(ant,
{
    plot(latitude, richness, col=habitat)
    legend("topright", levels(habitat), pch=1, col=1:2)
}
)

# ggplot default color palette
ggc <- hue_pal(h=c(0,360)+15, c=100, l=65, h.start=0, direction=1)
show_col(ggc(2))
show_col(ggc(6))


# Base plot with the same colors as ggplot
plot(ant$latitude, ant$richness, col=ggc(2)[ant$habitat])
legend("topright", levels(ant$habitat), pch=1, col=ggc(2))


# Nicer position for the legend (outside data panel)
plot(ant$latitude, ant$richness, col=ggc(2)[ant$habitat])
legend("top", levels(ant$habitat), pch=1, col=ggc(2),
       bty="n", horiz=TRUE, inset=-0.1, xpd=NA)

# Add a grid
plot(ant$latitude, ant$richness, col=ggc(2)[ant$habitat],
     panel.first=grid(col="gray90", lty=1, lwd=0.5))
legend("top", levels(ant$habitat), pch=1, col=ggc(2),
       bty="n", horiz=TRUE, inset=-0.1, xpd=NA)


# Base plot with grammar of graphics logic

with(ant,
{
    # Set up coordinate system with default x and y scales for the data
    plot(latitude, richness, type="n",
         panel.first=grid(col="gray90", lty=1, lwd=0.5))
    
    # Add geom point layer with channel (aesthetic) mappings
    points(x=latitude, y=richness, col=ggc(2)[habitat])
    
    # Add legend
    legend("top", levels(habitat), pch=1, col=ggc(2), bty="n", 
           horiz=TRUE, inset=-0.1, xpd=NA)
}
)


# Base plot with grammar of graphics logic

with(ant,
{
    # Set up coordinate system with explicit x and y scales for the data
    plot(latitude, richness, type="n", axes=FALSE, ann=FALSE)
    grid(col="gray90", lty=1, lwd=0.5)
    axis(1)
    axis(2)
    box()
    
    # Add geom point layer with channel (aesthetic) mappings
    points(x=latitude, y=richness, col=ggc(2)[habitat])
    
    # Add legend
    legend("top", levels(habitat), pch=1, col=ggc(2), bty="n", 
           horiz=TRUE, inset=-0.1, xpd=NA)
    
    # Add annotations
    mtext("Latitude (degrees north)", 1, line=2.5)
    mtext("Ant species richness", 2, line=2.5)
}
)



# Using ggplot with explicit mapping
ggplot(data=ant) + 
    geom_point(mapping=aes(x=latitude, y=richness, col=habitat))

# Adding black and white theme
ggplot(data=ant) + 
    geom_point(mapping=aes(x=latitude, y=richness, col=habitat)) +
    theme_bw()

# Abbreviated ggplot with layer inheritance
ggplot(ant, aes(latitude, richness, col=habitat)) + 
    geom_point()

