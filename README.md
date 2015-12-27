Getting and Cleaning Data Course Project
=========================================
# Step 1: download data file in R
# Use 'http' instead of 'https' for downloading.  'https' doesn't work for me, i.e. Windows 7.

fileUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"

download.file(fileUrl, destfile = "uci.zip")

dateDownloaded=date()

dateDownloaded

[1] "Sat Dec 26 18:30:32 2015"

# Step 2: read data
library(utils)

unzip("uci.zip", list = TRUE)  #take a look what is inside the zip file

unzip("uci.zip")

# Step 3: Run scripts in run_analysis.R

# Step 4: Get the data file.  A tidy data set will be generated at C:\Users\y.alvarado\Documents\Me\JHDSS\CleaningData\RWorkingDir\data\data.txt
