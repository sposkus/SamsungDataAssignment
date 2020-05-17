## The purpose of this script is to extract the data from the UCI HAR Dataset,
## place it in a tidy dataset and calculate the average values into a second 
## dataset.
##
## NOTE: this presumes that the datafiles are unzipped in the file location:
##       ./UCI HAR Dataset

## Open the necessary libraries
library(dplyr)
library(tidyr)

## Get the datasets from the files into R

# get the training data
train_x_file <- "./UCI HAR Dataset/train/X_train.txt"
train_y_file <- "./UCI HAR Dataset/train/y_train.txt"
train_subject_file <- "./UCI HAR Dataset/train/subject_train.txt"

train_x <- read.table(train_x_file, nrows=7352, comment.char="")
train_y <- read.table(train_y_file, col.names=c("activity"))
train_subject <- read.table(train_subject_file, col.names=c("subject"))

# combine the training data
train_data <- cbind(train_x, train_subject, train_y)

# get the testing data
test_x_file <- "./UCI HAR Dataset/test/X_test.txt"
test_y_file <- "./UCI HAR Dataset/test/y_test.txt"
test_subject_file <- "./UCI HAR Dataset/test/subject_test.txt"

test_x <- read.table(test_x_file, nrows=2947, comment.char="")
test_y <- read.table(test_y_file, col.names=c("activity"))
test_subject <- read.table(test_subject_file, col.names=c("subject"))

# combine the testing data
test_data <- cbind(test_x, test_subject, test_y)

# get the list of features
features_file <- "./UCI HAR Dataset/features.txt"
features_list <- read.table(features_file, col.names = c("id", "name"))

# get the list of activities
activities_file <- "./UCI HAR Dataset/activity_labels.txt"
activities_list <- read.table(activities_file, col.names=c("id", "name"))

## Merge the training and testing data together
all_data <- rbind(train_data, test_data)

## Extract Mean and Standard Deviation Data

# get only values that have mean or std in the name (that aren't meanFreq)
features <- c(as.vector(features_list[, "name"]), "subject", "activity")
filter_features <- (grepl("mean|std|subject|activity", features) 
                        & !grepl("meanFreq", features))

# get the matching columns from the data 
subset_data = all_data[, filter_features]

## Change the Activities column from numbers to descriptive text
for (i in 1:nrow(activities_list)) {
    subset_data$activity[subset_data$activity == activities_list[i, "id"]] <- 
        as.character(activities_list[i, "name"])
}

## label the data clearly

# get the current feature labels
feature_labels <- features[filter_features]

# change the first letter into something more legible at the end
feature_labels <- gsub("^t(.*)$", "\\1+time", feature_labels)
feature_labels <- gsub("^f(.*)$", "\\1+freq", feature_labels)

# change 'Acc' to acceleration and 'Mag' to magnitude
feature_labels <- gsub("Acc", "+acceleration", feature_labels)
feature_labels <- gsub("Mag", "+magnitude", feature_labels)

# add a '+' before gyro or jerk
feature_labels <- gsub("Gyro", "+gyro", feature_labels)
feature_labels <- gsub("Jerk", "+jerk", feature_labels)

# get rid of duplication and parenthesis and change '-' to '+'
feature_labels <- gsub("BodyBody", "body", feature_labels)
feature_labels <- gsub("\\(\\)", "", feature_labels)
feature_labels <- gsub("-", "+", feature_labels)

# make sure everything is lower case
feature_labels <- tolower(feature_labels)

# assigned the labels to the data
names(subset_data) <- feature_labels

## create a dataset with the averages for each activity and subject
averages <- subset_data %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean(., na.rm = TRUE)))

# Save the data to a file
write.table(averages, file="summarized_data.txt", row.name=FALSE)
