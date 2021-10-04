# GLOBE R working group
# Basic descriptive statistics
# October 2021, Julia Heinen

### 1. Import data
data <- read.delim("filename.txt", header = T) # loads file from working directory. getwd() to find or set setwd() working directory.


### 2. Load packages
sapply(c("ggplot2", "ggmap", "maps", "grDevices", "ggridges"), require, character.only=T) # alternatively use install.packages() and library()


### Try out the following summary statistics

## 3. Check data structure and change if needed
str() 
data$columnname <- as.factor(data$columnname) # as.numeric() as.character() as.integer
str() # check again


## 4. Explore the data
summary() # try whole data set and only one variable
head() 
tail()
mean()
median()
min()
max()
sd()
var()
cor() # use subset of numeric columns. for example cor(data[,c(18:23)]) >0.6 is correlated
length()

### Try out the following ways to visualize the data

## 5. Scatter plot

plot() # plot two variables against each other
plot(data[,c(18:23)]) # plot several variables against each other

ggplot(data, aes(x=xvariable, y=yvariable, color=category)) + geom_point(shape=1)


## 6. Histogram

hist()

ggplot(data, aes(x=variable, fill=category)) +
  geom_histogram(binwidth=.5, alpha=.5, position="identity") # histogram to compare groups

ggplot(data, aes(x = variable, y = category)) +
  geom_density_ridges( jittered_points = TRUE, 
                       position = position_points_jitter(width = 0.05, height = 0),
                       point_shape = '|', point_size = 3, point_alpha = 1, alpha = 0.7 ) # Compare many histograms in ridge plot

## 7. Box plot

boxplot()

ggplot(data, aes(x=category, y=variable, fill=category)) + geom_boxplot()


### 8. Map

mapWorld <- borders("world", colour="gray50", fill="gray50", xlim = c(-200, 200), ylim = c(-60, 75)) # Basic world map

mp <- ggplot() + mapWorld
mp <- mp + geom_point(aes(x=Longitude, y=Latitude, colour = variable1, size = variable2), 
             shape= 1, stroke=1.2, data = data)
mp # show the map in the viewer


### 9. Compare several plots in the same viewer

par(mfrow = c(2,2)) # change the number of plots to visualize
plot()
hist()
boxplot()
hist()
par(mfrow = c(1,1)) # change settings back to one plot


### 10. Save figure directly as PDF in working directory

pdf("figure.pdf", width=12.7, height=7.53) 
plot()
dev.off() # end plotting and clear the viewer


### 11. Is the data normally distributed?

hist(data$variable) # Check if the distribution of a variable is bell-shaped and symmetrical
hist(log10(data$variable)) # Check if a log10 transformation has improved the distribution


####################

### Basic statistical tests

### 12. LINEAR REGRESSION to model the relationship between two variables
fit <- lm(y ~ x, data=data) # perform regression on normally distributed data
summary(fit) # check p-value and R-squared
plot(fit) # check assumptions
plot(data$x, data$y) # plot data
abline(lm(y ~ x, data=data)) # plot line that should be similar to model fit


### 13. T-TEST to determine whether the means of two groups are equal to each other
t.test(x,y) # Perform t-test on normally distributed data


### 14. ANOVA to determine whether the means of more than two groups are equal to each other
one.way <- aov(variable ~ threecategories, data = data) # variable needs to be normally distributed
summary(one.way)
plot(one.way) # check assumptions

### REMEMBER: Tests are only valid if all assumptions are met !

### Explanation video's: 
## Linear regression: https://youtu.be/nk2CQITm_eo  and  https://youtu.be/eTZ4VUZHzxw
## T-test and ANOVA: https://youtu.be/NF5_btOaCig   and  https://youtu.be/VNJbX6mr6Uw

################# 