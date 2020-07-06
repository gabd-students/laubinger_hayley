# Hayley Laubinger
# Part 4: Factors

### What is a factor?

# Make a character ve ctor called " bee_visitors_vector"
bee_visitors_vector <- c("kiribiellus","kiribellus","flavifrons","kiribiellus","bifarius","flavifrons","kiribirllus")
# create the vector with the seven above individuals 
# make a "bee_visitors_factor" factor from "bee_visitors_vector"

bee_vistors_factor <- factor(bee_visitors_vector)
# create the factor from the vector
#print out bee_visitors_factor
bee_vistors_factor
# display results of factor

### 4.2 Factor types
#create "proboscic_vector" with seven elements
proboscis_vector <- c("Long","Long","Intermediate", "Long","Short", "Intermediate","Long")
# create the vector with randomly arranged data
# create an ordered "proboscis_factor" ordered from long to short
proboscis_factor <- factor(proboscis_vector, order=TRUE, levels= c("Short","Intermediate","Long"))
# create the ordering for the vector data above, with short < intermediate < long
#display the dcontents of proboscis_factor
proboscis_factor
# display the data of the completed factor 

### 4.3 Summarizing a factor
# Apply the "summary()" function to bee_visitors_factor and proboscis_factor

summary(bee_visitors_factor)
summary(proboscis_factor)

#shows the summary for amount in each catagory

### 4.4 Extracting from and comparing factors
# Extract from "bee_visitors_factor" the elements that are "not" kirbiellus
bee_vistors_factor[c(3,5,6)]
# should show the three non-kiribiellus data points
# Extract from "bee_visitors_factor" the second, and fourth through sixth elements. Use the colon for the range
bee_vistors_factor[c(2, 4:6)]
# should show 2, 4, 5, and 6 from data
# test whether the first element of "Proboscis_factor" is longer than the last element of "proboscis_factor"
pf1 <- proboscis_factor[1]
pf7 <- proboscis_factor[7]

pf1 > pf7
# optional challange: redo the test, but with length() to obtain the 7th element 

#
  

