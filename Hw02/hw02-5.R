# Hayley Laubinger

# Part 5: Data frames

### Section 5.1: Data Frames

### section 5.2: Viewing data frames
#Use data() to load the iris data frame
data("iris")
# Enter iris to display the full data frame
iris

#display the first 10 rows of the data frame
head(iris, n=10)
#display the last rows of the data frame
tails(iris)
#display the dimensions using the least amount of code
dim(iris)
#display the structure of the data frame
str(iris)

### Section 5.3: Extracting elements from data frame
# display the 101st row of the petal length column using column numbers
iris[101,3]
# Display the first 6 rows of all columns
iris[1:6,]
# display rows 48-52 of second column using the column header none
iris[48:52, 'Sepal.Width']
# display the entire contents of the sepal.width column using $
iris$Sepal.Width
### 5.4 Extracting elements with boolean vectors
# extract rows where sepal length is less than or equal to 5.5. Save
short_sepals <- iris$Sepal.Length<=5.5
# Display sepal length less than or equal to 5.5
iris[short_sepals,]
# apply the min function from the results
min(iris[short_sepals ,1])
# apply the max function from the results
max(iris[short_sepals ,1])
# display rows where sepal width is less than 3.2 and species is setosa
iris$Sepal.Width<3.2 & iris$Species=='setosa'
# display rows where sepal width is less than 2.5 or petal width is greater than 2.0
iris$Sepal.Width<2.5 | iris$Petal.Width>2.0
### Section 5.5: use subset to extract data from a data frame
# display rows for petal length between and including 4.0 and 5.0
subset(iris, Petal.length >=4.0 & Petal.length <=5.0)
# display rows for sepal length < 5.2 and species is versicolor
subset(iris, Sepal.length <5.2 & Species == 'versicolor')

### Section 5.6: Sort
# Order the data frame from shortest to longest sepal length
sort_order <- order(iris$Sepal.Length)
# Display the data from the sort_order
iris[sort_order, "Sepal.length"]

# sort petal width columns in decreasing order of petal width
sort_order_2 <- order(iris$Petal.Width, decreasing = TRUE)
# display the species and petal width columns in decreasing order of petal width
iris[sort_order_2, c('species', 'Petal.width')]



