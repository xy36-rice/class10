# EBIO 338/538 Analysis & Visualization of Biological Data
# Class 10: Simple linear regression

# Remove all objects from your environment
rm(list=ls())

# Load the height and weight data and examine it's structure

d <- read.csv(file="class_10_height_weight_data.csv")
str(d)
head(d)

# Examine the distribution of heights
hist(d$height, col="orange")

# Examine the distribution of weights
hist(d$weight)

# We will use the function lm() to conduct simple linear regression
?lm

# Model average population height as a constant
model <- lm(d$height ~ 1)
summary(model)

# Examine model estimate and residual standard error  
mean(d$height)
sd(d$height)

# Use a scatterplot to examine the relationship between height and weight
plot(d$height ~ d$weight, ylab="Height (in)", xlab="Weight (lbs)")

# Run a simple linear regression of weight as a function of height
model <- lm(d$height ~ d$weight)

# Examine a summary of the model
summary(model)

# Extract the estimates, which provide the intercept and slope for the regression line
coef(model)
# Add the line of best fit to the plot
abline(coef(model)[1], coef(model)[2], col="orange")

# Calculate the coefficient of determination (R-squared) or proportion of variance explained by model
# R-squared = 1 - Sum of squares of residuals / total sum of squares
1 - (sum(resid(model)^2)/sum((d$height - mean(d$height))^2))


# Predicting out of sample
# Create a new sample of weights
range.of.weights <- rnorm(50, mean = 300, sd = 150)

# Compare the range of the new sample to the range of the original sample
range(range.of.weights)
range(d$weight)

# Use the estimates from the regression model to create simulated height data for the range of weights
alpha.estimate <- 51.32838
beta.estimate <- 0.10514
sigma.estimate <- 2.317

simulated.heights <- rnorm(length(range.of.weights),
                           mean = alpha.estimate + beta.estimate * range.of.weights,
                           sd = sigma.estimate)


# Plot the simulated data
plot(simulated.heights ~ range.of.weights, las=1)
# Overlay the original data on top of the simulated data
points(d$height ~ d$weight, col="orange", pch=19)

# Add a custom legend
text(500,60, "simulated", adj=0)
text(500,55, "raw data", col="orange", adj=0)
points(475, 60)
points(475, 55, col="orange", pch=19)


# Tests of normality for outcome (i.e. dependent) variable
?shapiro.test
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min = 2, max = 4))

shapiro.test(d$height)

# Plot histogram again and play with breaks
hist(d$height, col="orange")
hist(d$height, col="orange", breaks=15)
hist(d$height, col="orange", breaks=5)

# Use a qqplot to examine outcome (i.e. dependent) variable for normality
qqnorm(d$height)

# Tests of normality for error terms
shapiro.test(resid(model))

# Examine residuals of model for normality
?resid
resid(model)
hist(resid(model), col="orange")
hist(resid(model), col="orange", breaks=10)
hist(resid(model), col="orange", breaks=3)
hist(resid(model), col="orange", breaks=20)

# Use a qqplot to examine outcome errors for normality
qqnorm(resid(model))
qqline(resid(model))

# Plot residuals versus predicted values
plot(resid(model) ~ predict(model), col="orange", pch=19)

model2 <- lm(resid(model) ~ predict(model))
summary(model2)
abline(model2)
