
### Function 1: Standard error function
## First argument will accept vector of numeric values
## Second argument should default to na.rm = FALSE.
## When finished, make R aware of your function.Use your cursor to highlight (select) your entire function, then press the Run button or press cmd/ctrl + enter.

std_err <- function(vector, na.rm = FALSE) {
  ifelse (na.rm,
          vector <- na.omit(vector),
          vector)
  (stdev(vector)/ sqrt(length(vector)))
}

# data can be entered in Y, sqrt(length(Y)) to test the range of cells that contain the data

### Function 2: Scaled Mass index function
## Make index scale of mass of bird to length of tarsus
## Use 'mass' for mass, 'tarsus' for tarsus length, and 'slope' for slope
## default each argument to zero
scaled_mass <- function(values, na.rm = FALSE) 
  ifelse (mass>= 0, 
          mass <- mass,
          mass <- 0)
  ifelse( tarsus >= 0,
          tarsus <- tarsus,
          tarsus <-0)
  ifelse (slope >=0,
          slope <- slope, 
          slope <-0)
## Make R aware of scaled_mass
  scaled_mass <- function(mass = 0, tarsus = 0, slope = 0) {mass*((mean(tarus))/tarus)^slope}

  
# No errors have occurred in the console. Mass, tarsus, and slope set to 0.
  