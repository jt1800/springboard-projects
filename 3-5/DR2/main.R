#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("readr")
library("tidyr")
library("dplyr")
library("readr")

titanic <- read.csv("titanic3.csv")

titanic$embarked[titanic$embarked == ""] <- "S"

avgage <- mean(titanic$age,na.rm = TRUE)

titanic$age[is.na(titanic$age)] <- avgage

levels(titanic$boat)[1] <- "NA"

titanic$has_cabin_number <- as.numeric(titanic$cabin != "")

write.csv(titanic, file = "titanic_clean.csv")
