# Predicting ERA

This project is about seeing which baseball statistic (K%, BB%, WHIP, OBP) is 
the best predictor for a pitcher's ERA.

## Overview

Our main goal is to see which variable is the best predictor of ERA by creating 
data visualizations for each with the different variables being on the x-axis, 
and the ERA being on the Y-axis. From these visualization, we will be able to 
see the correlation for each, which will tell us which is the best predictor for 
ERA.

## Data Sources and Acknowledgements

We found all of our data on the Website Baseball Savant. The data is collected 
by the MLB and is made public. 

## Current Plan

Overall, we intend to create 4 visualizations, one for each statistic, to see 
which is the best indicator of ERA by looking at the Coefficients of Determination 
for each. To do achieve that goal and have a finished project, we will follow the 
following steps.

1.) Find MLB Pitching Data on Baseball Savant
2.) Export Data as a CSV and upload it into R
3.) Wrangle Data
4.) Create Data Visualizations and Description
5.) Create Quarto File

## Repo Structure

Our repo is organized into 4 branches, with there being a branch for each author, 
as well as a main branch. The important files are:
    - "Baseball Raw Statistics.csv" is the raw data file straight from Baseball Savant
    - "Predicting ERA - Final Project.qmd" is the final Quarto File with all of our data 
      wrangling and visualizations.

## Authors

Jacob Koewler (jdk6024@psu.edu)
Liam Bengston (lzb5645@psu.edu)
Yehe Cui (yfc5461@psu.edu)
