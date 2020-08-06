# 15: Analysis of COVID-19 data
# Hayley Laubinger


# Load libraries 
library(tidyverse)
library(here)
library(lubridate)
library(sf)
library(patchwork)
library(gghighlight)
library(ggthemes)

# Define constants 

## first case in the US: 19 Jan 2020
first_us_case <- dmy("19 Jan 2020")

## first MO case
first_mo_case <- dmy("08 Mar 2020")

## lower 48
lower_48 <- c("Alabama", "Arizona",
              "Arkansas", "California",
              "Colorado", "Connecticut",
              "Delaware", "Florida",
              "Georgia", "Idaho",
              "Illinois", "Indiana",
              "Iowa", "Kansas",
              "Kentucky", "Louisiana",
              "Maine", "Maryland",
              "Massachusetts", "Michigan",
              "Minnesota", "Mississippi",
              "Missouri", "Montana",
              "Nebraska", "Nevada",
              "New Hampshire", "New Jersey",
              "New Mexico", "New York",
              "North Carolina", "North Dakota",
              "Ohio", "Oklahoma",
              "Oregon", "Pennsylvania",
              "Rhode Island", "South Carolina",
              "South Dakota", "Tennessee",
              "Texas", "Utah", "Vermont",
              "Virginia", "Washington",
              "West Virginia",
              "Wisconsin", "Wyoming")

## CDC region
ortheast_fips <-  c(9, 23, 25, 33, 44, 50,
                    34, 36, 42)
midwest_fips <- c(18, 17, 26, 39, 55,
                  19, 20, 27, 29,
                  31, 38, 46)
south_fips <-  c(10, 11, 12, 13, 24,
                 37, 45, 51, 54,
                 1, 21, 28, 47,
                 5, 22, 40, 48)
west_fips <-  c(4, 8, 16, 35,
                30, 49, 32, 56,
                2, 6, 15, 41, 53)

# Functions 



