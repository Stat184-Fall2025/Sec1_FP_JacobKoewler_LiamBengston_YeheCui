# Step 1: Load Packages
library(tidyverse)
library(rvest)
library(ggplot2)
library(dplyr)
library(readr)
library(googlesheets4)

# Step 2: Import Raw Data
gs4_deauth()
web_Raw <- read_sheet(
  ss = "https://docs.google.com/spreadsheets/d/1aQGzS0Epzus4ZRMdT7VMvGddumRQdRsXYek41cmyLLU/edit?gid=884425286#gid=884425286",
  n_max = 1113
)

# Step 3: Split Name into First and Last Name
Raw_Statistics_Separated <- web_Raw %>% 
  separate_wider_delim( # Separate one name column into two (First and Last)
    cols = `last_name, first_name`, # original column
    delim = ",", # delimiter
    names = c("Last_Name", "First_Name"), # new column names
  )

# Step 4: Combine Names
Raw_Statistics_Names <- Raw_Statistics_Separated %>% # Turn names from "Colon, Bartolo" into "Bartolo Colon"
  unite( 
    col = "Name", # New Column name
    First_Name, # First name column
    Last_Name, # Last name column
    sep = " ") # Separate names with space

# Step 5: Rename Columns
Raw_Statistics_Renamed <- Raw_Statistics_Names %>% # rename columns for ease of use for those who aren't as familiar with baseball statistics
  rename("Games_Pitched" = p_game,
         "Innings_Pitched" = p_formatted_ip,
         "Strikeout_Percentage" = k_percent,
         "Walk_Percentage" = bb_percent,
         "ERA" = p_era,
         "On_Base_Percentage" = on_base_percent)


# Step 6: Calculate WHIP
Raw_Statistics_WHIP <- Raw_Statistics_Renamed %>%
  mutate( # Calculate WHIP using mutate to create a new column
    "WHIP" = (walk + hit)/(Innings_Pitched) # use PEMDAS to ensure proper calculation
)

# Step 7: Remove Extra Columns
Cleaned_ERA_Statistics <- Raw_Statistics_WHIP %>% # remove extra columns so only useful data remains
  select(Name, Strikeout_Percentage, Walk_Percentage, On_Base_Percentage, WHIP, ERA)

# Step 8: Round WHIP
Cleaned_ERA_Statistics$WHIP <- round(Cleaned_ERA_Statistics$WHIP, digits = 2)

