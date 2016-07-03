
# Data
This set of data comes from Coursera Getting and Cleaning Data course - Week 4.  It originates from this study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The raw dataset is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# Variables
#####df - this is the result of steps 1-4 of the project. It is a tidy version of 'training' and 'test' datasets from the raw UCI data
#####analysis -  is the result of step 5 of the project. It is a tidy data frame that contains the means of each variable for each subject and each activity, as asked for in the project.
#####All columns in these 2 data frames are described in the original codebook of the UCI raw dataset.  The only difference is that 'analysis' is an average over the subjects and activities performed

# Transformations performed in script
#####Lines 9-13 : set up required libraries
#####Lines 14-23 : set working directory, clean workspace, read in necessary files
#####Lines 26-28 : associate the test and train x-data sets with the features files
#####Lines 30-33 : associate the activity labels file with the test and train y-data sets
#####Lines 35-36 : add the activity labels into the x-data sets
#####Lines 38-43 : create a variable in each x data-set to denote the source of the data (test or train), then row bind into 1 dataset
#####Lines 46-51 : extract required columns as specified in project prompt using grep
#####Lines 53-56 : first add a subject column to the dataset since that was not yet associated.  This is the end of transformations for the 'df' data object
#####Lines 59-62 : melt then recast/summarize by mean (average) the df to achieve our desired 'analysis' data object
#####Lines 64-68 : rename 'analysis' data object appropriately