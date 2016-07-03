# this R script will take the data from the Coursera Week 4 project and perform the following:
# 1. Merge the training and test sets to create one data set
# 2. Extract only the measurements on the mean and standard deviation for each measurement
# 3. Set descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject

library(plyr)
library(dplyr)
library(lubridate)
library(reshape2)
library(tidyr)
setwd("F:/Dropbox/Coursera_Data_Sci/R_Working_Dir/Getting-Cleaning-Data/Week4Proj")
rm(list=ls())
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")


#4 - set the features as the column headings
names(x_test) <- features$V2
names(x_train) <- features$V2

#3 - set the activity labels
# http://stackoverflow.com/questions/12370327/how-do-i-replace-values-within-a-data-frame-with-a-string-in-r
y_test <- join(y_test,activity_labels,by="V1",type="left")
y_train <- join(y_train,activity_labels,by="V1",type="left")

x_test$activity <- y_test$V2
x_train$activity <- y_train$V2

#1. Merge
# First need to create a new variable / column to denote which table the data originally came from
x_test$source <- "TEST"
x_train$source <- "TRAIN"
# Row bind the 2 datasets together
df <- rbind(x_test,x_train)


#2. Extract
# use grep function to find any column names containing 'mean' or 'std'
extracted_cols <- grep("mean\\()|std\\()",names(df))
# add the activity and source columns back onto the extracted columns
extracted_cols <- append(extracted_cols,c(562,563))
df <- df[,extracted_cols]

#5. average of each variable for each variable and each subject
# need to get subjects into df
subject <- rbind(subject_test,subject_train)
df$subject <- subject$V1


# melt then recast / summarize http://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/
# http://seananderson.ca/2013/10/19/reshape.html
melted <- melt(df,id.vars=c("subject","activity","source"))
analysis <- dcast(melted,subject+activity+source ~ variable,mean)

#name the rows to have an average
names(analysis) <- paste("average",names(analysis))
names(analysis) <- sub("average subject","subject",names(analysis))
names(analysis) <- sub("average activity","activity",names(analysis))
names(analysis) <- sub("average source","source",names(analysis))

View(analysis)