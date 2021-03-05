# EBIO 338/538 Analysis & Visualization of Biological Data
# Class 10 Practice

# Remove all objects in the environment

# Load the iris data from R's datasets
data("iris")

# Examine the structure of the iris data and read about it in the help menu
?iris


# VISUALIZE AND MODEL DATA

# Visually examine the iris data
# Start by plotting boxplots of the different measurements by species
# a) Petal length per species
boxplot(iris$Petal.Length ~ iris$Species, ylab = "Petal Length", xlab = "Species")
# b) Petal width per species
boxplot(iris$Petal.Width ~ iris$Species, ylab = "Petal Width", xlab = "Species")

# Extract only the observations of the versicolor species in an object named p
p <- iris[iris$Species == "versicolor",]
# Now use scatterplots to examine relationships among the sepal and petal measurements for versicolor
# Plot the relationship between petal length and sepal length
plot(p$Petal.Length ~ p$Sepal.Length)
# Examine the distribution of petal lengths using multiple break points
hist(p$Petal.Length, breaks = 5)
hist(p$Petal.Length, breaks = 10)
hist(p$Petal.Length, breaks = 15)
# Model petal lengths as a constant
model <- lm(p$Petal.Length ~ 1)
# How else can the value of the intercept be estimated?
coef(model)[1]
mean(p$Petal.Length)
# Now model petal lengths as a function of sepal length in a model called m
m <- lm(p$Petal.Length ~ p$Sepal.Length)
# Examine a summary of the model
summary(m)

# The intercept can be interpreted as the petal length of a flower with a sepal length of zero
# Use the following code to visualize it:
plot(p$Petal.Length~p$Sepal.Length, ylim=c(0,5), xlim=c(0,7))
abline(m)
abline(v=0, col="red", lty="dashed")

# What proportion of the variance is explained by the model?
summary(m)[9]
# TRUE or FALSE? Does this model outperform a model without any covariates?
TRUE

# OUT OF SAMPLE PREDICTION

# Generate another sample of 25 petal lengths from a normal distribution with a mean of 7 and a sd of 3. Call it more_petals
more_petals <- rnorm(25, mean = 7, sd = 3)
# Use more_petals to predict sepal lengths
alpha <- coef(m)[1]
beta <- coef(m)[2]
sigma <- summary(m)$sigma
predicted.sepal.lengths <- rnorm(length(more_petals),
                                 mean = alpha + beta * more_petals,
                                 sd = sigma)
# Plot simulated data with original data overlaid
points(predicted.sepal.lengths ~ more_petals, pch = 16, col = "orange")



# CHECK ASSUMPTIONS of a simple linear regression

# Check for normally distributed outcome (dependent variable) with 3 approaches
shapiro.test(p$Petal.Length)

hist(p$Petal.Length, breaks = 5)
hist(p$Petal.Length, breaks = 10)
hist(p$Petal.Length, breaks = 15)

qqnorm(p$Petal.Length)

# Check for normally distributed errors with 2 approaches
shapiro.test(resid(m))

hist(resid(m), breaks = 5)
hist(resid(m), breaks = 10)
hist(resid(m), breaks = 15)

# Check for homoscedasticity of errors
plot(resid(m) ~ predict(m))
m2 <- lm(resid(m) ~ predict(m))
abline(m2)

# Check for independence of errors (e.g., temporal autocorrelation)

# Check assumptions of additivity and linearity with 2 different visualizations
plot(p$Petal.Length ~ predict(m))
abline(0, 1)

plot(resid(m) ~ predict(m))
abline(h = 0)
