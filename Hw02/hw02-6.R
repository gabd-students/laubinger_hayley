# Hayley Laubinger
#HW2 Part 6: lists

### 6.1 Intro to List

### 6.2: Create a list
#Numeric vector with numbers from 1 to 6 
numeric_vector <- 1:6

# create logical vector with true and false
logical_vector <- rep(c(TRUE, FALSE), 4)

# Letter_matrix with the first nine letters of the English alphabet
letter_matrix <- matrix(LETTERS[1:9], ncol = 3)

# first 10 elements of chickwts data frame
chicks_df <- chickwts[1:10,]

# Use the `list()` function to create `the_list` with the above objects. Use the names of the objects to name the objects. 
the_list <- list(numbers = numeric_vector, boolean = logical_vector, letters = letter_matrix, chicks = chicks_df)

# display 'the_list'
the_list

# display the structure of the list
str(the_list)

### 6.3: Extract the elements from a list
# add weights of 10 chicks raised on horsebean
hb_chicks <- chickwts$weight[1:10]

#add weights of 10 chicks raised on lineseed
ls_chicks <-chickwts$weight[11:20]

# t test results
chicks_t <- t.test(hb_chicks, ls_chicks, var.equal = TRUE)

#Run structure function on chicks_t
str(chicks_t)

# display the numeric value of the statstic object from chicks_t
chicks_t$statistic

#display the numeric value of the p.value object from chicks_t
chicks_t$p.value

#disaply the lower confidence limit
chicks_t$conf.int[1]

# display the upper confidence limit
chicks_t$conf.int[2]

# create a text string called whew with the value I did it!
whew <- 'i did it!'

# display whew
whew





