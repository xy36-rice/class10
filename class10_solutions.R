# EBIO 338/538 Analysis & Visualization of Biological Data
# Class 11 Practice

# Remove all objects in the environment
rm(list=ls())

# Load the iris data from R's datasets
data("iris")

# Examine the structure of the iris data and read about it in the help menu
str(iris)
?iris

# Visually examine the iris data
# Start by plotting boxplots of the different measurements by species
# a) Petal length per species
boxplot(iris$Petal.Length~iris$Species)
# b) Petal width per species
boxplot(iris$Petal.Width~iris$Species)

# Extract only the observations of the versicolor species in an object named p
p <- iris[iris$Species=="versicolor",]

# Now use scatterplots to examine relationships among the sepal and petal measurements for versicolor
# Plot the relationship between petal length and sepal length
plot(p$Petal.Length~p$Sepal.Length)

# Examine the distribution of petal lengths using multiple break points
hist(p$Petal.Length, breaks=5)
hist(p$Petal.Length, breaks=10)
hist(p$Petal.Length, breaks=15)

# Model petal lengths as a constant
summary(lm(p$Petal.Length ~ 1))

# How else can the value of the intercept be estimated?
mean(p$Petal.Length)

# Now model petal lengths as a function of sepal length in a model called m
m <- lm(p$Petal.Length~p$Sepal.Length)

# Examine a summary of the model
summary(m)
abline(m)

# The intercept can be interpreted as the petal length of a flower with a sepal length of zero
# Use the following code to visualize it:
plot(p$Petal.Length~p$Sepal.Length, ylim=c(0,5), xlim=c(0,7))
abline(m)
abline(v=0, col="red", lty="dashed")

# What proportion of the variance is explained by the model?
summary(m)[9]

# TRUE or FALSE? Does this model outperform a model without any covariates?
TRUE

# Generate another sample of 25 petal lengths from a normal distribution with a mean of 7 and a sd of 3. Call it more_petals
more_petals <- rnorm(25, mean=7, sd=3)

# Use more_petals to predict sepal lengths

a.estimate <- 0.18512
b.estimate <- 0.68647
s.estimate <- 0.3118446

simulated.lengths <- rnorm(length(more_petals),
                             mean = a.estimate + b.estimate * 
                               more_petals,
                             sd = s.estimate)

# Plot simulated data with original data overlaid
plot(simulated.lengths ~ more_petals)
  
# CHECK ASSUMPTIONS of a simple linear regression
# Check for normally distributed outcome (dependent variable)

shapiro.test(p$Petal.Length)

hist(p$Petal.Length, breaks=5)
hist(p$Petal.Length, breaks=10)
hist(p$Petal.Length, breaks=20)

qqnorm(p$Petal.Length)

# Check for normally distributed errors
shapiro.test(resid(m))
hist(resid(m), breaks = 5)
hist(resid(m), breaks = 10)
hist(resid(m), breaks = 20)


# Check for homoscedasticity of errors
plot(resid(m) ~ predict(m))
abline(m)

# Check for independence of errors (e.g., temporal autocorrelation)
NA

# Check assumptions of additivity and linearity
plot(p$Petal.Length ~ predict(m))
abline(0,1)

plot(resid(m) ~ predict(m))
abline(h=0)
