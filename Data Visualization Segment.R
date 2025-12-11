# Step 1: Load Packages
library(tidyverse)
library(rvest)
library(ggplot2)
library(dplyr)
library(readr)

# Step 2: Import Raw Data
Raw_Statistics <- read.csv("C:/Users/liamb/OneDrive/Documents/R work/stats (1).csv")

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


# Step 5: Calculate WHIP
Raw_Statistics_WHIP <- Raw_Statistics_Renamed %>%
  mutate("WHIP" = (walk + hit)/(Innings_Pitched))

# Step 6: Remove Extra Columns
Cleaned_ERA_Statistics <- Raw_Statistics_WHIP %>%
  select(Name, Strikeout_Percentage, Walk_Percentage, On_Base_Percentage, WHIP, ERA)

# Step 7:
ggplot(
  data = Cleaned_ERA_Statistics, 
  mapping = aes(
    x = Strikeout_Percentage,
    y = ERA,
  )
) +
  geom_point(alpha = 0.2) + # increased line size a little to improve readability
  labs(
    title = "K% vs ERA Over the Past Decade",
    x = "K%",
    y = "ERA"
  ) + 
  geom_smooth(alpha = 0.1) + # a line of best fit to more clearly see the correlation
  theme_classic() # a visual polish adjustment

# Step 8
ggplot(
  data = Cleaned_ERA_Statistics, 
  mapping = aes(
    x = Walk_Percentage,
    y = ERA,
  )
) +
  geom_point(alpha = 0.2) + # increased line size a little to improve readability
  labs(
    title = "BB% vs ERA Over the Past Decade",
    x = "BB%",
    y = "ERA"
  ) + 
  geom_smooth(alpha = 0.1) + # a line of best fit to more clearly see the correlation
  theme_classic() + # a visual polish adjustment
  scale_x_reverse()

# Step 9
ggplot(
  data = Cleaned_ERA_Statistics, 
  mapping = aes(
    x = On_Base_Percentage,
    y = ERA,
  )
) +
  geom_point(alpha = 0.2) + # increased line size a little to improve readability
  labs(
    title = "OBP vs ERA Over the Past Decade",
    x = "OBP",
    y = "ERA"
  ) + 
  geom_smooth(alpha = 0.1) + # a line of best fit to more clearly see the correlation
  theme_classic() + # a visual polish adjustment
  scale_x_reverse()

# Step 10
ggplot(
  data = Cleaned_ERA_Statistics, 
  mapping = aes(
    x = WHIP,
    y = ERA,
  )
) +
  geom_point(alpha = 0.2) + # increased line size a little to improve readability
  labs(
    title = "WHIP vs ERA Over the Past Decade",
    x = "WHIP",
    y = "ERA"
  ) + 
  geom_smooth(alpha = 0.1) + # a line of best fit to more clearly see the correlation
  theme_classic() + # a visual polish adjustment
  scale_x_reverse()
