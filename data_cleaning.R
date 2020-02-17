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

# Create custom function for recoding data
# This function takes a column, looks for a particular string, and then assigns
  # it a name; when I use this within a mutate function, it will create a new
  # column with the new names
# str_detect is a string-detecting function
# The vertical bar | means "or"
survey_recode <- function(column_ref) {
  case_when(
    str_detect(column_ref, "occasionally|get stuck") ~ "Low",
    str_detect(column_ref, "all the time|most tasks") ~ "High",
    str_detect(column_ref, "often|trouble-shoot") ~ "Moderate",
    str_detect(column_ref, "never|at all") ~ "None"
  )
}

# Recode survey responses
dat <- dat %>%
  mutate(familiarity_r = survey_recode(familiarity_r),
         familiarity_rmd = survey_recode(familiarity_rmd),
         comfort_r = survey_recode(comfort_r),
         comfort_rmd = survey_recode(comfort_rmd))