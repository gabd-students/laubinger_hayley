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
first_us_case <- ("19 Jan 2020")

## first MO case
first_mo_case <- ("08 Mar 2020")

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
Northeast_fips <-  c(9, 23, 25, 33, 44, 50,
                     34, 36, 42)
Midwest_fips <- c(18, 17, 26, 39, 55,
                  19, 20, 27, 29,
                  31, 38, 46)
South_fips <-  c(10, 11, 12, 13, 24,
                 37, 45, 51, 54,
                 1, 21, 28, 47,
                 5, 22, 40, 48)
West_fips <-  c(4, 8, 16, 35,
                30, 49, 32, 56,
                2, 6, 15, 41, 53)

# Write a Function
new_total_cases <- function(args){
  length_args <- length(args)
  first_day_value <- c(0, args[1:length_args - 1])
  diff <- args - first_day_value
  return(diff)
}

# Hopefully thats right.not throwing any errors 


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
  filter(date>= first_us_case)
covid_confirmed_data

covid_deaths_raw <- read_csv(here("data",
                                  "covid_deaths_usafacts.csv"))
covid_deaths_data <- covid_deaths_raw %>%
  filter(countyFIPS != 0 & stateFIPS != 0) %>%
  pivot_longer(c(`1/22/20`:`7/31/20`),
               names_to = "date",
               values_to = "deaths") %>%
  mutate(date = mdy(date)) %>%
  filter(date >= (first_us_case))


county_population_raw <- read_csv(here("data",
                                       "covid_county_population_usafacts.csv"))
state_pop_data <- county_population_raw %>%
  filter(countyFIPS != 0)

semo_county_raw <- read_csv(here("data",
                                 "semo_county_enrollment.csv"),
                            skip = 1)
semo_county_data <- semo_county_raw %>%
  rename("County" = X1)


# Plot 1
plot_1 <- covid_confirmed_data %>%
  left_join(covid_deaths_data) %>%
  filter(date >= (first_mo_case)) %>% 
  mutate(Region= case_when(   
    stateFIPS %in% Northeast_fips ~ "Northeast",
    stateFIPS %in% South_fips ~ "South",
    stateFIPS %in% Midwest_fips ~ "Midwest",
    stateFIPS %in% West_fips ~ "West")) %>% 
  group_by(Region, date) %>% 
  summarise(total_cases = sum(cases,
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

# Thank you! It finally works :D


#Plot 2
plot_2 <- covid_confirmed %>%
  filter(State == "MO",
         date >=(first_mo_case)) %>%
  mutate(`County Name` = str_replace(`County Name`, " County$", ""),
         `County Name` = str_replace(`County Name`, "^Jackson.*", "Jackson"))


semo_data <- semo_county %>%
  select(-c(`2015`:`2018`)) %>%
  mutate(`County Name` =
           str_replace_all(`County Name`,
                           c("De Kalb" = "DeKalb",
                             "Sainte" = "Ste\\.",
                             "Saint" = "St\\.",
                             "St\\. Louis City" = "City of St\\. Louis")))


plot_2_final <- plot_2 %>%
  group_by(`County Name`, date) %>%
  summarise(total_confirmed = sum(cases,
                                  na.rm = TRUE)) %>%
  left_join(semo_data)



ggplot() +
  geom_line(aes(x = date,
                y = total_confirmed,
                color = `County Name`),
            size = 0.55) +
  labs(x = NULL,
       y = "Total Confirmed Cases",
       color = "County") +
  gghighlight(`2019` >= 200,
              use_direct_label = FALSE) +
  scale_x_date(date_labels = "%d %b")+
  theme_test() 
 

# Plot 3 
plot_3 <- covid_confirmed_data %>%
  filter(date %in% c(ymd("2020-04-01"):ymd("2020-04-30"),
                     ymd("2020-07-01"):ymd("2020-07-30"))) %>%
  mutate(month = month(date)) %>%
  group_by(State,`County Name`, month) %>%
  summarise(total_cases_county = sum(cases,
                                     na.rm = TRUE)) %>%
  left_join(state_pop_data) %>%
  mutate(rate_county = (total_cases_county / population)
         * 100000)


plot_3_last <- plot_3 %>%
  group_by(State, month) %>%
  summarise(avg_rate = sum(total_cases_county) / sum(population) * 100000)

ggplot(plot_3_last,
  aes(x = reorder(State, avg_rate),
           y = avg_rate),
       group = State) +
  geom_line(color = "gray60") +
  geom_point(aes(color = month),
             size = 2) +
  coord_flip()
group_by(State,`County Name`, month) %>%
  summarise(pop_state = sum(population,
                            na.rm = TRUE),
            cases_per_state = sum(cases,
                                  na.rm = TRUE),
            rate = (cases_per_state / pop_state)
            * 100000)


ggplot(plot_3_last,
       aes(x = reorder(State, rate),
           y = rate),
       group = State) +
  geom_line(color = "gray60") +
  geom_point(aes(color = month),
             size = 2) +
  coord_flip()
group_by(`State`, `County Name`, month) %>%
  summarise(case_total = sum(cases,na.rm = TRUE),
            case_rate_county = (case_total / population) * 100000)
group_by(`State`, month) %>%
  summarise(total_confirmed = sum(cases,
                                  na.rm = TRUE),
            case_rate = (total_confirmed / population) * 100000)



# Plot 4
plot_4 <- covid_confirmed_data %>%
  filter(State == "MO",
         date >= dmy(first_mo_case)) %>%
  group_by(date) %>%
  summarise(total_cases = sum(cases)) %>%
  mutate(daily = new_from_total(total_cases))
plot_4$roll_mean <- 
  data.table::frollmean(plot_4$daily,
                        7, align = "right") %>%
  replace_na(0)            

plot_4%>% 
  ggplot(aes(x=date,y=daily))+
  geom_col(color="grey30",fill="grey45")+
  geom_line(aes(x=date,y=roll_mean),
            color="#9D2235",
            size=0.60, alpha=1)+
  geom_col(data=filter(plot_4,date == dmy ("16 June 2020")),
           mapping = aes(x = date, y = daily),
           color = "gray85",
           fill = "#C8102E")+
  scale_x_date(date_labels = "%b%d",
               date_breaks = "2 weeks")+
  theme_test()+
  annotate(geom="text",x=mdy("Jun 16 2020"),y=228,label="Missouri reopened\n16 June 2020",color="#C8102E",fill="C8102E")+
  labs(x=NULL,y="Daily New Cases")

# The spike in cases is dramatic going into summer months, near 2000 new cases a day.


# Plot 5 
plot_5 <- covid_confirmed_data %>%
  left_join(covid_deaths_data) %>%
  group_by(State) %>%
  summarise("Total Cases" = sum(cases, na.rm = TRUE),
            "Total Deaths" = sum(deaths, na.rm = TRUE)) %>%
  mutate("Death Rate (%)" = (`Total Deaths` / `Total Cases`)
         * 100)
ggplot(states_df) +
  geom_sf(aes(fill = `Death Rate (%)`)) +
  scale_fill_viridis_c(name = "COVID-19 Death rate\n% of confirmed cases",
                       option = "inferno",
                       labels = c(2.5, 5.0, 7.5, 10.0)) +
  coord_sf(crs = st_crs(5070)) +
  theme_bw() +
  theme(legend.position = "bottom")


table_5 <- plot_5 %>%
  filter(`Death Rate (%)` >= 5) %>%
  arrange(desc(`Death Rate (%)`))

states_data <- st_read(here("data",
                             "cb_2017_us_state_500k.shp"),
                  stringsAsFactors = TRUE)
states_df <- states_data %>%
  dplyr::filter(NAME %in% lower_48) %>%
  rename(State =  STUSPS)
states_df <- left_join(states_df, plot_5)  

ggplot(states_df) +
  geom_sf(aes(fill = `Death Rate (%)`)) +
  scale_fill_viridis_c(name = "COVID-19 Death rate\n% of confirmed cases",
                       option = "inferno") +
  coord_sf(crs = st_crs(5070)) +
  theme_bw() +
  theme(legend.position = "bottom")

# Yay! It worked. Its seems as you go into more populated states, the death rate increases. Such as New York, which New York City was hit hard with cases, so that would make sense. 







#