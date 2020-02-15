## Load packages ##

# Package list
pkg_list <- c("plyr","tidyverse", "data.table", "ggplot2", "kableExtra")

# Load packages
pacman::p_load(pkg_list, character.only = TRUE)

## Load data ##

# Read csv file
# header = TRUE tells R that the columns have headers
# stringsAsFactors = FALSE tells R not to interpret strings (words) as factors, 
  # because that would make analysis very annoying later
# check.names = FALSE tells R not to make sure the names of the columns are 
  # valid variable names; we can change the column names later
# na.strings = "" tells R that blank cells should be treated as NA values;
  # there are special functions/arguments that deal with NAs, so it helps to convert
  # blank cells that don't get special treatment
dat <- read.csv("data/rmarkdown_responses.csv",
                header = TRUE,
                stringsAsFactors = FALSE,
                check.names = FALSE,
                na.strings = "")

# Rename columns
# colnames() requires that you provide a new name for all columns
  # I wanted to do this anyway, but it's good to keep in mind
  # You would need a different approach to change just some of the column names
colnames(dat) <- c("timestamp", "familiarity_r", "familiarity_rmd",
                   "comfort_r", "comfort_rmd", "use_r", "use_rmd",
                   "experience_latex", "experience_html", "topics", "additional")

# Remove unnecessary columns
# We'll talk about the pipe operator %>%, but it essentially allows you to iterate on
  # a dataset without saving intermediate variables
dat <- dat %>%
  select(-c(timestamp, additional))

# Remove package list variable
# We've already loaded in the packages, so we don't need to keep the list
rm(pkg_list)