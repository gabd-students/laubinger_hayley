#Hayley Laubinger
# Part 2: Vectors
### 2.1 Create a Vector
### 2.2 Vector Types
alphabet <- c("A", "B", "C", "D", "E", "F")
integers <- c(1, 2, 3, 4, 5, 6) 
# Logical vector
logical_vector <- c(FALSE, FALSE, TRUE)
  
### 2.3 Biological Vectors
 
# Cultures without pplo
cultures_without_pplo <- c(4.6, 4.8, 5.1, 5.5, 5.8)
        
# Cultures with pplo contaminant
cultures_with_pplo <- c(4.6, 4.8, 5.1, 5.5, 5.8)
          
#
### 2.4 Name your Vectors
# create 'day_sampled' vector days_sampled<-(Day 0,)

# Name your two data vectors with the `days_sampled` vector.
              
cultures_without_pplo[3] 
{1} 5.1
            
names(cultures_with_pplo)<- days_sampled
names(cultures_without_pplo)<-days_sampled
             
# Check that your two data vectors are properly named
cultures_with_pplo 
'Day 0 Day 2 Day 4 Day 6 Day 8'
'4.6   4.8   5.1   5.5   5.8'
cultures_without_pplo
'Day 0 Day 2 Day 4 Day 6 Day 8' 
'4.6   4.8   5.1   5.5   5.8'
#
### 2.5 Calculations with Vectors
# find the maximum values in cultures_without_pplo and cultures_without_pplo
max(cultures_with_pplo) [1] 5.8
max(cultures_without_pplo) [1] 5.8
# Find minimum values with cultures
min(cultures_with_pplo)
'[1] 4.6'
min(cultures_without_pplo)
'[1] 4.6'
# Store in max_without and max_with
max_with_pplo <- max(cultures_with_pplo)
max_without_pplo <- max(cultures_without_pplo)
             
# Store min_without and min_with
min(cultures_with_pplo)
'[1] 4.6'
min_with_pplo <- min(cultures_with_pplo)
min_without_pplo <- min(cultures_without_pplo)
            
# Use 10^ to calculate the actual number of cells for each culture.
10^(cultures_with_pplo)
'Day 0 Day 2 Day 4'
'39810.72  63095.73 125892.54' 
'Day 6     Day 8'
'316227.77 630957.34' 
10^(cultures_without_pplo)
'Day 0     Day 2     Day 4' 
'39810.72  63095.73 125892.54'
'Day 6     Day 8'
'316227.77 630957.34'
# Store in cells_counts_without_pplo and cells_counts_with_pplo
cell_counts_with_pplo <- 10^(cultures_with_pplo)
cell_counts_without_pplo <- 10^(cultures_without_pplo)
# Calculate the average number cell counts for each vector
#  You do not have to save these values to variables
              
mean(cell_counts_with_pplo)
'[1] 235196.8'
mean(cell_counts_without_pplo)
'[1] 235196.8'
cell_counts_without_pplo
            'Day 0     Day 2     Day 4' 
            '39810.72  63095.73 125892.54' 
            'Day 6     Day 8' 
            '316227.77 630957.34'
### 2.6 Extract individual elements from a vector
# Select the third element from cultures_without_pplo by position number
cultures_without_pplo
            'Day 0 Day 2 Day 4 Day 6 Day 8' 
            '4.6   4.8   5.1   5.5   5.8' 
# select the odd numbered elements of cell_counts_with_pplo using vector of position numbers 
position_vector<-c(1,3,5)
cell_counts_with_pplo[position_vector]
            'Day 0     Day 4     Day 8' 
            '39810.72 125892.54 630957.34'
#select the elements for 'Day 2'and 'Day 4' by name from cultures_with_pplo
cultures_with_pplo[c("Day 2", "Day 4")]
            'Day 2 Day 4'
            '4.8   5.1'
#
### 2.7 Extraction by Logical comparison
# Use 'cell_counts_without_pplo' to create a logical vector for cell counts greater than 100,000
high_cell_count<-cell_counts_without_pplo>100000
# Use that vector to show the days and log values from 'cultures_without_pplo'
cultures_without_pplo[high_cell_count]
            'Day_4 Day_6 Day_8' 
            '5.1   5.5   5.8'
# Use 'cell_counts_with_pplo' and '&' to create a logical vector for cells counts greater than 50,000
medium_cell_counts<- cell_counts_with_pplo>=50000 & cell_counts_with_pplo<=75000
# Use the logical vectore to show the days and log values from ' cultures_with_pplo'
cultures_with_pplo[medium_cell_counts]
Day_2 
4.8 
#

        