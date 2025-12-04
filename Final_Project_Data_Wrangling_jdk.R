# Step 1: Load Packages
library(tidyverse)
library(rvest)
library(ggplot2)
library(dplyr)
library(readr)

# Step 2: Import Raw Data
Raw_Statistics <- read.csv("C:/College/GitHub Repos/Sec-1-FP-JacobKoewler-LiamBengston-YeheCui/stats (1).csv")

# Step 3: Split Name into First and Last Name
Raw_Statistics_Separated <- Raw_Statistics %>%
  separate_wider_delim(
    cols = `last_name..first_name`,
    delim = ",",
    names = c("Last_Name", "First_Name"),
  )

# Step 4: Combine Names
Raw_Statistics_Names <- Raw_Statistics_Separated %>%
  unite(
    col = "Name",
    First_Name,
    Last_Name,
    sep = " ")

# Step 4: Rename Columns
Raw_Statistics_Renamed <- Raw_Statistics_Names %>%
  rename("Games_Pitched" = p_game,
         "Innings_Pitched" = p_formatted_ip,
         "Strikeout_Percentage" = k_percent,
         "Walk_Percentage" = bb_percent,
         "ERA" = p_era,
         "On_Base_Percentage" = on_base_percent)


# Step 5: Calcuate WHIP
Raw_Statistics_WHIP <- Raw_Statistics_Renamed %>%
  mutate("WHIP" = (walk + hit)/(Innings_Pitched))

# Step 6: Remove Extra Columns
Cleaned_ERA_Statistics <- Raw_Statistics_WHIP %>%
  select(Name, Strikeout_Percentage, Walk_Percentage, On_Base_Percentage, WHIP, ERA)


