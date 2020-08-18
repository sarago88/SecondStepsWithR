################################################################################
###
### Introduction to conducting statistic tests in R
###
### Sara Gottlieb-Cohen, Manager of Statistical Support Services
### Center for Science and Social Science Information
### Yale University
###
################################################################################

## Goals for this session:
##  1. Reinforce basic R skills throughout the tutorial
##  2. Write loops
##  3. Write functions
##  4. Perform more advanced data manipulation

################################################################################
### Part 1: Refresher ###
################################################################################

# Vectors and data frames are the two types of objects you will work with most 
# often in R. Vectors are the more basic; in fact, data frames are just collections
# of vectors.

# We can index, or call up, any specific value(s) of a vector using the c() function,
# which stands for "concatenate" (in other words, changing elemements together).

# In this case we are using c() to concatenate the values 22, 2, 19, 7, 8, and 12. 
# The result of c() will be a numeric vector of length 6. 
# We can assign that vector to the object x with the assignment operator <-.

x <- c(22, 2, 19, 7, 8, 12)

# Running the above line of code saves the vector as x; typing x (the following command)
# prints it in the console.

x

# We can perform basic arithmetic on vectors: 

x/2
x*2

# Exercise: find the mean and standard deviation of x.



# Exercise: index the first and last values of x.



# Exercise: using index notation, find which values of x are greater than 10 but less than 20.



# Exercise: load the iris dataset. Subset the data to only include "setosa" observations.

iris_data <- iris
head(iris)




# For a refresher on working basic R commands, please review the code from Frist Steps with R.

# The rest of this session will focus on more advanced topics in R. 

################################################################################
### Part 2: Loops ###
################################################################################

# A while loop is like an if statement in that it executes some function as long as
# a condition is true. However, unlike an if statement, it repeats the function over 
# and over again, performing it as long as the statement is true.

# The basic sytax is as follow:

# while(condition) {
#   function
# }

# Take the following example. We are going to set a variable named "speed" equal to 20
# miles per hour. As long as our speed is under 40 miles per hour, we want R to print 
# the speed in the console.

speed <- 20

while(speed <= 40) {
  print(paste("Your speed is", speed))
  speed <- speed + 5
}

# You can see that we only iterated through the loop 5 times before hitting 40 miles per hour.

# Initiate the following loop:

speed <- 20

while(speed > 10) {
  print(paste("Your speed is", speed))
  speed <- speed + 5
}

# Uh oh! This keeps going forever because the speed is always over 10. You can press escape in the 
# console or build a break into the loop:

speed <- 20

while(speed > 10) {
  print(paste("Your speed is", speed))
  if (speed > 100) {
    break
  }
  speed <- speed + 5
}

# Next we are going to change the loop so that our speed starts at 60. Each time we iterate through, we want R to 
# print our speed. If the speed is over 40, we want it to also print "slow down!." If it is 40 or under, we want it
# to print "good."

# Each time we go through the loop, we will decrease the speed by 2 miles per hour. 

# In essence, we are saying, "Start speed at 60, and decrease by 2 each time. As long as speed is over 40, print 
# the speed and also 'slow down.' Once speed is 40 or under, print the speed and also 'good.'"

speed <- 60

while (speed > 0) {
  print(paste("Your speed is", speed))
  if (speed > 40) {
    print(paste("slow down!"))
    } else {
    print("Good")
    }
  speed <- speed - 2
}

# A for loop is a bit different. It will iteratate some function over each element of a vector.
# Take the following example: we have a list of speeds that range from 0 to 60 miles per hour.
# We want to create a for loop that does the following: if speed is under 40 or under, print "slow."
# If the speed is over 40, print "fast."

speeds <- c(0, 10, 20, 30, 40, 50, 60, 70)

for (i in speeds) {
  if (i <= 40) {
    print("slow")
  } else {
    print("fast")
  }
}
  
# You might wonder why we need loops, since we can use indexing notation and logical statements
# to accomplish the previous code. Loops can come in handy later in when you want to perform some
# statistical test over many different data sets, and typing each test by hand is cumbersome. 

# Exercise: Use the mtcars data set. Find the pearson correlation coefficient between mpg and disp, hp, drat, wt
# and qsec. Save the coefficients in a new vector. This is a challenge exercise, and the code has been started
# for you.

head(mtcars)
coefficients <- c()

columns <- mtcars[, 3:7]

dv <- 1:5

for (i in dv) {
  coefficients[i] <- cor(mtcars[, 1], columns[, i]) 
}

coefficients

################################################################################
### Part 3: Functions ###
################################################################################

# You may find yourself wanting to perform some function that does not already exist
# in R. For example, there is no function for calculating the standard error of a vector.
# You could calculate it using lengthy code each time, but creating a saving a function is 
# more efficient. We are going to write a function for calculating standard error.

# The general format for a function is as follows:
# function_name <- function(argument1, argument2) {
#   calculations
# }

# The formula for standard error is the standard deviation, divided by the square root
# of the number of values.

standard_err <- function(x) {
  sd(x)/sqrt(length(x))
}

# What is the standard error of speed?

standard_err(speed)

# Exercise: Write a function to "center" or "normalize" a vector. Centering a vector
# means transforming it so that the mean is 0 and the standard deviation is 1. This 
# can be accomplished by subtracting from each value the mean of the vector, and 
# dividing by the standard deviation of the vector.

# Use your function to center mtcars$mpg. Save it as a new vector called mtcars$mpg_c.

center <- function(x) {
  (x - mean(x))/sd(x)
}

mtcars$mpg_c <- center(mtcars$mpg)

################################################################################
### Part 4: Data manipulation ###
################################################################################

# Never understand the power of data manipulation! Most data sets are messy or 
# not formatted correctly for your needs. In this section, we will focus on three 
# goals:

# 1. Cleaning data
# 2. Reshaping data
# 3. Summarizing data

## 1. Cleaning ##

# Read in voting data and look at the first few lines:

voting_data <- read.csv('/Users/sgc/Documents/Workshops/Second Steps with R/social_small.csv')
head(voting_data)

# This dataset contains a subset of 34,408 registered voters and comes from a field experiment that 
# focused on the role of social pressure on an individual’s decision to vote on election day. Specifically, 
# it examines whether there were different turnout rates for registered voters that received a postcard in the mail 
# with various messages. These messages ranged from “Do your civic duty — vote!” to a seemingly-invasive message that 
# whether you turn out to vote or not would be shared with everyone in your neighborhood.

# It looks like the "sex" variable is a bit messy:

summary(voting_data$sex)

# Our first task is to make each value either "Male" or "Female."

voting_data$sex <- ifelse(voting_data$sex %in% c("F", "female", "Female"), "Female", "Male")
voting_data$sex <- factor(voting_data$sex)
summary(voting_data$sex)

# Voted_2000 and Voted_2004 are a bit messy, too. There is some upper case and some lower case.
# Execute the following lines of code to convert everything to lowercase, and 
# use the same "ifelse" code to create new variables called "didvote_2000" and "didvote_2004." 
# Assign a value 1 if they voted, and assign a value 0 if not.

voting_data$voted_2000 <- tolower(voting_data$voted_2000)
voting_data$voted_2004 <- tolower(voting_data$voted_2004)

voting_data$voted_2000 <- ifelse(voting_data$voted_2000 == "yes", 1, 0)
voting_data$voted_2004 <- ifelse(voting_data$voted_2004 == "yes", 1, 0)

voting_data$voted_2000 <- as.integer(voting_data$voted_2000)
voting_data$voted_2004 <- as.integer(voting_data$voted_2004)

# Finally, we are going to assign a unique ID to each subject in the data set.

voting_data$ID <- 1:NROW(voting_data)

## 2. Reshaping ##

install.packages("reshape2")
library(reshape2)

# We want to transform our data from "wide" to "long" format. This is necessary
# to run many types of statistical tests and also to create some types of 
# data visualizations.

# This website explains the difference between the two: https://r4ds.had.co.nz/tidy-data.html

# The "id.vars" are columns that will not be transposed to long format; all other variables will be used.
# variable.name refers to the name of the new factor variable, and value.name refers to the name of the new column
# that will store the values.

voting_long <- melt(voting_data, id.vars = c("ID", "sex", "treatment"),
                    variable.name = "year",
                    value.name = "voted")

# The "year" column is a bit messy. We want it say onyl 2002 or 2004. 

voting_long$year <- parse_number(voting_long$year)

## 3. Summarizing ##

# Now we want to summarize our data. We want to know the number of people that voted across 
# all combinations of sex, treatment, and year. 

summary_table <- voting_long %>%
  group_by(sex, treatment, year) %>%
  summarize(num_voted = sum(voted))

summary_table

# As mentioned above, we can accomplish this all at once:

summary_table <- voting_data %>%
  gather(key = "year", value = "voted", -sex, -treatment) %>%
  mutate(year = parse_number(year)) %>%
  group_by(sex, treatment, year) %>%
  summarize(num_voted = sum(voted))

### USA arrests ###

# Now it is your turn! We will be working with the USArrests data set.

head(USArrests)

# We ultimately want to distill this data set to only 3 rows and 2 columns:
# a summary table with the average number of arrests for each type of arrest (murder, assualt, and rape),
# and the standard error of each.

# Before creating a summary table, we need to transform our data to long format, 
# with one variable called "arrest_type" and another called "arrests."

USArrests$State <- rownames(USArrests)

USArrests_long <- melt(USArrests, id.vars = c("State", "UrbanPop"),
                          variable.name = "arrest_type",
                          value.name = "arrests")

USArrests_summary <- USArrests_long %>%
  group_by(arrest_type) %>%
  summarize(average = mean(arrests),
            se = sd(arrests)/sqrt(n()))

USArrests_summary

# If you continue working with R, you will likely use ggplot2 to create visualizations. We need data to look
# like this to make graphs, such as the following:

ggplot(USArrests_summary, aes(x = arrest_type, y = average)) +
  geom_bar(stat = "identity", position = "dodge", fill = "grey") +
  geom_errorbar(aes(ymin = average - se, ymax = average + se), width = .2)