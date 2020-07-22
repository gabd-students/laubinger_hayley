## Hayley Laubinger
##hw08: functions

### Function 1: Standard error function
## First argument will accept vector of numeric values
## Second argument should default to na.rm = FALSE.
## When finished, make R aware of your function.Use your cursor to highlight (select) your entire function, then press the Run button or press cmd/ctrl + enter.

std_err <- function(vector, na.rm = FALSE) {
  ifelse (na.rm,
          vector <- na.omit(vector),
          vector)
  sd(vector)/ sqrt(length(vector))
}

### Function 2: Scaled Mass index function
## Make index scale of mass of bird to length of tarsus
## Use 'mass' for mass, 'tarsus' for tarsus length, and 'slope' for slope
## default each argument to zero
  scaled_mass <- function(mass = 0, tarsus = 0, slope = 0) {mass*((mean(tarsus))/tarsus)^slope}
mass*(((mean(tarsus))/tarsus)^slope)
## Scale data for mass and tarsus
scaled_mass (mass <- c(26.7, 22.8, 25.7, 26.1, 23.9))

scaled_mass (tarsus <- c(18.4, 17.5, 18.4, 18.0, 18.2))

## Use Slope = 1.5
scaled_mass (slope=1.5)
## No errors have occurred in the console.Mass, tarsus, and slope set to 0.


  