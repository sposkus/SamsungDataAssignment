# SamsungDataAssignment
Assignment for Cleaning a dataset from Samsung Accelerometers forthe "Getting and Cleaning Data" course from the "Data Science" specialization track in Coursera.

This code is used to produce a tidy data set of the means and standard deviations data from the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), specifically the Samsung Galaxy S smartphone dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and then to summarize that data based on the subject and activity.

## Assignment

Create a R script that does the following

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R code

The R code is in the [run_analysis.R](run_analysis.R) file and requires that the UCI HAR dataset to be unzipped into the source folder.

Run the Source command on run_analysis and it will create a summarization of the tidy data and save it in the file `summarized_data.txt`.

```R
source("run_analysis.R")
```

The tidy data set can be loaded back into R using the following command

```R
final_data <- read.table("summarized_data.txt")
```

## Data CodeBook

The [codebook](Codebook.md) describes the variables, and the steps that were done to clean the data.
