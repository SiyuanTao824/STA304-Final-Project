# Overview
This repo contains codes and data from "What would happen if all voters voted? An Analysis of the 2019 Canadian Federal Election Using Multilevel Regression with Post-stratification". It was created by Siyuan Tao. The purpose is to create a report that summarizes the statistical model we built. Some data is unable to be shared in public, we will mention them below. The report contains three parts: inputs, outputs, scripts.

Inputs contain the original data. We used two datasets:

-Survey data - Stephenson, Laura B., Harell, A., Rubenson, D., & Loewen, Peter J. (2020). 2019 Canadian Election Study - Online Survey. https://doi.org/10.7910/DVN/DUS88V, Harvard Dataverse, V1

-Census data - Statistics Canada. (2019). 2016 Census of Population [Canada] Public Use Microdata File (PUMF): Individuals File [public use microdata file]. Ottawa, Ontario: Statistics Canada [producer and distributor].

Outputs contain data that are modified from the input data.

Scripts contain R scripts that take inputs and outputs to produce outputs. Scripts also contain the R scripts that we built our model.

- [01-final-data_cleaning-survey.R](https://github.com/SiyuanTao824/STA304-Final-Project/blob/main/scripts/01-final-data_cleaning-survey.R)
- [02-final-data_cleaning-post-strat.R](https://github.com/SiyuanTao824/STA304-Final-Project/blob/main/scripts/02-final-data_cleaning-post-strat.R)
- [03-final-output.Rmd](https://github.com/SiyuanTao824/STA304-Final-Project/blob/main/scripts/03-final-output.Rmd)

