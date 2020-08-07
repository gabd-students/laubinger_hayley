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
library(dplyr)

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
northeast_fips <-  c(9, 23, 25, 33, 44, 50,
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

# Write a Function
new_total_cases <- function(args){
  length_args <- length(args)
}





# Initial import and wrangling --------------------------------------------

### Use ISO8601 YYYY-MM-DD format

covid_confirmed_raw <- read_csv(here("data",
                                     
                                     "covid_confirmed_usafacts.csv"))
covid_confirmed_raw

covid_confirmed_data <- covid_confirmed_raw %>%
  filter(countyFIPS != 0 & stateFIPS != 0) %>%
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = "date",
               values_to = "cases") %>%
  mutate(date = mdy(date)) %>%
  filter(date >= dmy(first_us_case))
covid_confirmed_data

covid_deaths_raw <- read_csv(here("data",
                                  "covid_deaths_usafacts.csv"))
covid_deaths_data <- covid_deaths_raw %>%
  filter(countyFIPS != 0 & stateFIPS != 0) %>%
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = "date",
               values_to = "deaths") %>%
  mutate(date = mdy(date)) %>%
  filter(date >= dmy(first_us_case))


county_population_raw <- read_csv(here("data",
                                       "covid_county_population_usafacts.csv"))
state_pop_data <- county_population_raw %>%
  filter(countyFIPS != 0)

semo_county_raw <- read_csv(here("data",
                                 "semo_county_enrollment.csv"),
                            skip = 1)
semo_county_data <- semo_county_raw %>%
  rename("County Name" = X1)


# Plot 1
plot_1 <- covid_confirmed_data %>%
  left_join(covid_deaths_data) %>%
  filter(date >= mdy(first_mo_case)) %>% 
  mutate(Region= case_when(   
    stateFIPS %in% northeast ~ "Northeast",
    stateFIPS %in% south ~ "South",
    stateFIPS %in% midwest ~ "Midwest",
    stateFIPS %in% west ~ "West")) %>% 
  group_by(Region, date) %>% 
  summarise(total_cases = sum(confirmed,
                              na.rm=TRUE),
            total_deaths = sum(deaths,
                               na.rm=TRUE),
            .groups="drop")

plot_cases <- ggplot(plot_1) +
  geom_line(aes(x = date,
                y = total_cases,
                color = Region), size = 0.85) +
  labs(x = NULL,
       y = "Total Cases") +
  theme_test() +
  theme(legend.position = "bottom")


plot_deaths <- ggplot(plot_1) +
  geom_line(aes(x = date,
                y = total_deaths,
                color = Region), size = 0.85) +
  labs(x = NULL,
       y = "Total Deaths") +
  theme_test() +
  theme(legend.position = "none")

plot_cases + plot_deaths+ plot_layout(nrow = 1)




