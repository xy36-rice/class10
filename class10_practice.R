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
# b) Petal width per species

# Extract only the observations of the versicolor species in an object named p

# Now use scatterplots to examine relationships among the sepal and petal measurements for versicolor
# Plot the relationship between petal length and sepal length

# Examine the distribution of petal lengths using multiple break points

# Model petal lengths as a constant

# How else can the value of the intercept be estimated?

# Now model petal lengths as a function of sepal length in a model called m

# Examine a summary of the model


# The intercept can be interpreted as the petal length of a flower with a sepal length of zero
# Use the following code to visualize it:
plot(p$Petal.Length~p$Sepal.Length, ylim=c(0,5), xlim=c(0,7))
abline(m)
abline(v=0, col="red", lty="dashed")

# What proportion of the variance is explained by the model?

# TRUE or FALSE? Does this model outperform a model without any covariates?


# OUT OF SAMPLE PREDICTION

# Generate another sample of 25 petal lengths from a normal distribution with a mean of 7 and a sd of 3. Call it more_petals

# Use more_petals to predict sepal lengths

# Plot simulated data with original data overlaid




# CHECK ASSUMPTIONS of a simple linear regression

# Check for normally distributed outcome (dependent variable) with 3 approaches

# Check for normally distributed errors with 2 approaches

# Check for homoscedasticity of errors
 
# Check for independence of errors (e.g., temporal autocorrelation)

# Check assumptions of additivity and linearity with 2 different visualizations



 