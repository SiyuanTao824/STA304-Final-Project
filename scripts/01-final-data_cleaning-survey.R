#### Preamble ####
# Purpose: Prepare and clean the survey data.
# Author: Rohan Alexander, Sam Caetano, and Siyuan Tao
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca, and s.tao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("~/Desktop/sta304 final")
# Read in the raw data 
raw_data <- read_dta("inputs/survey/survey.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(#interest,
    #registration,
    #vote_2016,
    #vote_intention,
    pes19_votechoice2019,
    #ideo5,
    cps19_bornin_canada,
    cps19_gender,
    #census_region,
    #hispanic,
    #race_ethnicity,
    cps19_income_number,
    cps19_education,
    cps19_province,
    #congress_district,
    cps19_age)


#### What else? ####
# First, to make the further analysis easier, we want to remove all NAs in our dataset.
reduced_data <- na.omit(reduced_data)

# Then, there are nine levels under the variable "pes19_votechoice2019". We first want to group those
# choices which does not mention specific voting choices, such as "I spoiled my vote" and "Don't know /
# Prefer not to answer." Then, we want to drop this group to make further analysis easier.
levels(reduced_data$pes19_votechoice2019)[levels(reduced_data$pes19_votechoice2019)%in%
                                            c("I spoiled my vote", "Don't know / Prefer not to answer")] <- "Others"


reduced_data$pes19_votechoice2019 <- droplevels(reduced_data$pes19_votechoice2019, "Others")

# Then, we want to change names of levels of some variables to make the survey data match the 
# census data.

levels(reduced_data$cps19_bornin_canada)[levels(reduced_data$cps19_bornin_canada)%in%
                                           c("Yes")] <- "Born in Canada"

levels(reduced_data$cps19_bornin_canada)[levels(reduced_data$cps19_bornin_canada)%in%
                                           c("No")] <- "Born outside Canada"


reduced_data$cps19_bornin_canada <- droplevels(reduced_data$cps19_bornin_canada, "Don't know/ Prefer not to say")

levels(reduced_data$cps19_gender)[levels(reduced_data$cps19_gender)%in%
                                    c("A man")] <- "Male"

levels(reduced_data$cps19_gender)[levels(reduced_data$cps19_gender)%in%
                                    c("A woman")] <- "Female"

reduced_data$cps19_gender <- droplevels(reduced_data$cps19_gender, "Other (e.g. Trans, non-binary, two-spirit, gender-queer)")


# We want to categorize the household incomes so that the levels of the variable will match the census data.

reduced_data$cps19_income_number <- as.integer(reduced_data$cps19_income_number)

reduced_data <- na.omit(reduced_data)
reduced_data <- reduced_data %>%
  mutate(income_family = cut(cps19_income_number, breaks=c(-Inf, 24999, 49999, 74999, 99999, 149999, Inf), 
                             labels=c("Less than $25,000","$25,000 to $49,999","$50,000 to $74,999",
                                      "$75,000 to $99,999", "$10,000 to $149,999", "$150,000 and more")))

reduced_data <- subset(reduced_data, select = -cps19_income_number)

# Then, we want to group ages to make the levels match the census data.
reduced_data$cps19_age <- as.integer(reduced_data$cps19_age)

reduced_data <- reduced_data %>%
  mutate(age = cut(cps19_age, breaks=c(-Inf, 29, 44, 64, Inf), 
                   labels=c("0 to 29 years", "30 to 44 years",
                            "45 to 64 years", "65 years and over")))

reduced_data <- subset(reduced_data, select = -cps19_age)

# Then, we want to clean the levels of "Education"  to make these levels match the census data.

levels(reduced_data$cps19_education)[levels(reduced_data$cps19_education)%in%
                                       c("No schooling", "Some elementary school",
                                         "Completed elementary school", "Some secondary/ high school")] <- "Less than high school diploma or its equivalent"

levels(reduced_data$cps19_education)[levels(reduced_data$cps19_education)%in%
                                       c("Completed secondary/ high school", "Some technical, community college, CEGEP, College Classique")] <- "High school diploma or a high school equivalency certificate"


levels(reduced_data$cps19_education)[levels(reduced_data$cps19_education)%in%
                                       c("Completed technical, community college, CEGEP, College Classique")] <- "College, CEGEP or other non-university certificate or diploma"

levels(reduced_data$cps19_education)[levels(reduced_data$cps19_education)%in%
                                       c("Some university")] <- "University certificate or diploma below the bachelor's level"

levels(reduced_data$cps19_education)[levels(reduced_data$cps19_education)%in%
                                       c("Master's degree", "Professional degree or doctorate")] <- "University certificate, diploma or degree above the bachelor's level"


reduced_data$cps19_education <- droplevels(reduced_data$cps19_education, "Don't know/ Prefer not to answer")

# Besides, we want to group the northern three territories into Northern Canada.

levels(reduced_data$cps19_province)[levels(reduced_data$cps19_province)%in%
                                      c("Yukon", "Nunavut", "Northwest Territories")] <- "Northern Canada"


# Make a new column to show the binary result of the vote.

reduced_data<-
  reduced_data %>%
  mutate(vote_liberal = 
           ifelse(pes19_votechoice2019=="Liberal Party", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(vote_conservative = 
           ifelse(pes19_votechoice2019=="Conservative Party", 1, 0))

# Finally, we want to change the names of the variables.
reduced_data <-
  reduced_data %>% 
  rename(
    vote_choice = pes19_votechoice2019,
    place_birth_canada = cps19_bornin_canada ,
    sex = cps19_gender,
    education = cps19_education,
    province = cps19_province,
  )
reduced_data <- na.omit(reduced_data)
# Saving the survey/sample data as a csv file in my
# working directory

write_csv(reduced_data, "outputs/survey_data.csv")
