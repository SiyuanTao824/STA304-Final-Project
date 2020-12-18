#### Preamble ####
# Purpose: Prepare and clean the census data.
# Author: Rohan Alexander, Sam Caetano, and Siyuan Tao
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca and s.tao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("~/Desktop/sta304 final")
reduced_data_census <- read_spss("inputs/canada census.sav")
# Add the labels.
reduced_data_census <- labelled::to_factor(reduced_data_census)

#### What's next? ####

# We want to modify some levels of the variables to make the variables in the census data match the 
# variables in the survey data.

# First, we want to remove NAs.
reduced_data_census <- na.omit(reduced_data_census)

# Then, we want to change the levels of the variable POB into two levels.

levels(reduced_data_census$POB)[levels(reduced_data_census$POB)%in%
                                  c("Canada")] <- "Born in Canada"

levels(reduced_data_census$POB)[levels(reduced_data_census$POB)%in%
                                  c("United States", "Central America", "Jamaica", "Other Caribbean and Bermuda","South America",                              
                                    "United Kingdom", "Germany", "France","Poland" ,"Italy", "Other Southern Europe",
                                    "Eastern Africa", "Northern Africa", "Other Africa", "Iran", "China", "South Korea", "Other Eastern Asia" ,
                                    "Philippines", "Viet Nam", "Other Southeast Asia", "India", "Pakistan", "Sri Lanka",
                                    "Other Southern Asia", "Oceania and others", "Not available", "Other Northern and Western Europe", "Other Eastern Europe",                       
                                    "Portugal", "Other West Central Asia and the Middle East", "Hong Kong")] <- "Born outside Canada"

# Then, we want to group the levels of household incomes.

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("Under $2,000", "$2,000 to $4,999", "$5,000 to $6,999", "$7,000 to $9,999",    
                                      "$10,000 to $11,999", "$12,000 to $14,999", "$15,000 to $16,999", "$17,000 to $19,999",  
                                      "$20,000 to $24,999")] <- "Less than $25,000"

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("$25,000 to $29,999", "$30,000 to $34,999", "$35,000 to $39,999",  
                                      "$40,000 to $44,999","$45,000 to $49,999")] <- "$25,000 to $49,999"

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("$50,000 to $54,999", "$55,000 to $59,999", "$60,000 to $64,999",
                                      "$65,000 to $69,999", "$70,000 to $74,999")] <- "$50,000 to $74,999"

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("$75,000 to $79,999", "$80,000 to $84,999",
                                      "$85,000 to $89,999", "$90,000 to $94,999", "$95,000 to $99,999")] <- "$75,000 to $99,999"

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("$100,000 to $109,999", "$110,000 to $119,999", "$120,000 to $129,999", "$130,000 to $139,999",
                                      "$140,000 to $149,999")] <- "$10,000 to $149,999"

levels(reduced_data_census$CFInc)[levels(reduced_data_census$CFInc)%in%
                                    c("$150,000 to $174,999", "$175,000 to $199,999" ,"$200,000 to $249,999",
                                      "$250,000 and over")] <- "$150,000 and more"


reduced_data_census$CFInc <- droplevels(reduced_data_census$CFInc, "Not available)")


# Then, we want to change the levels of "education" the make the survey and the census data match.

levels(reduced_data_census$HDGREE)[levels(reduced_data_census$HDGREE)%in%
                                     c("No certificate, diploma or degree")] <- "Less than high school diploma or its equivalent"   

levels(reduced_data_census$HDGREE)[levels(reduced_data_census$HDGREE)%in%
                                     c("Secondary (high) school diploma or equivalency certificate")] <- "High school diploma or a high school equivalency certificate"

levels(reduced_data_census$HDGREE)[levels(reduced_data_census$HDGREE)%in%
                                     c("Trades certificate or diploma other than Certificate of Appr",
                                       "Certificate of Apprenticeship or Certificate of Qualificatio")] <- "College, CEGEP or other non-university certificate or diploma"

levels(reduced_data_census$HDGREE)[levels(reduced_data_census$HDGREE)%in%
                                     c("Program of 3 months to less than 1 year (College, CEGEP and", 
                                       "Program of 1 to 2 years (College, CEGEP and other non-univer",
                                       "Program of more than 2 years (College, CEGEP and other non-u",
                                       "University certificate or diploma below bachelor level")] <- "University certificate or diploma below the bachelor's level"


levels(reduced_data_census$HDGREE)[levels(reduced_data_census$HDGREE)%in%
                                     c("University certificate or diploma above bachelor level",      
                                       "Degree in medicine, dentistry, veterinary medicine or optome",
                                       "Master's degree",                                             
                                       "Earned doctorate")] <- "University certificate, diploma or degree above the bachelor's level"


reduced_data_census$HDGREE <- droplevels(reduced_data_census$HDGREE, "Not available",                                               
                                         "Not applicable")

# Also, we want to group the AGEGRP variable.
levels(reduced_data_census$AGEGRP)[levels(reduced_data_census$AGEGRP)%in%
                                     c("0 to 4 years", "5 to 6 years", "7 to 9 years", "10 to 11 years", "12 to 14 years",   
                                       "15 to 17 years", "18 to 19 years", "20 to 24 years", "25 to 29 years")] <- "0 to 29 years"

levels(reduced_data_census$AGEGRP)[levels(reduced_data_census$AGEGRP)%in%
                                     c("30 to 34 years", "35 to 39 years", "40 to 44 years")] <- "30 to 44 years"

levels(reduced_data_census$AGEGRP)[levels(reduced_data_census$AGEGRP)%in%
                                     c("45 to 49 years", "50 to 54 years", "55 to 59 years", "60 to 64 years")] <- "45 to 64 years"

levels(reduced_data_census$AGEGRP)[levels(reduced_data_census$AGEGRP)%in%
                                     c("65 to 69 years", "70 to 74 years", "75 to 79 years", "80 to 84 years",   
                                       "85 years and over")] <- "65 years and over"


reduced_data_census$AGEGRP <- droplevels(reduced_data_census$AGEGRP,"Not available")

# Then, we want to rename some variables.

reduced_data_census <-
  reduced_data_census %>% 
  rename(
    place_birth_canada = POB ,
    sex = Sex,
    education = HDGREE,
    province = PR,
    age = AGEGRP,
    income_family = CFInc
  )

## Here we want to split cells by age, sex, province, education, household income, and whether born in Canada.

reduced_data_census <- 
  reduced_data_census %>%
  count(age, sex, province, education, income_family, place_birth_canada) %>%
  group_by(age, sex, province, education, income_family, place_birth_canada) 

total = sum(reduced_data_census$n)

reduced_data_census <- 
  reduced_data_census %>%
  mutate(cell_prop_of_division_total = n/total)
reduced_data_census <- na.omit(reduced_data_census)
# Saving the census data as a csv file in my working directory
write_csv(reduced_data_census, "outputs/census_data.csv")



