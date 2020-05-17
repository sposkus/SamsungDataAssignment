# Codebook

This codebook builds on the information found in the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), specifically the Samsung Galaxy S smartphone dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) files: README.txt and features_info.txt.  For further detail on how the original dataset was compiled, please read the UCI HAR files.

The script run_analysis.R creates a tidy dataset by combining the data from the training group and the test group into one large dataset, and then extracting a subset of that data by taking only the columns that contained means, standard deviations, the activity, and the subject identifier.  The activity column is changed from coded numbers to the actual text that describes the activity, and the columns are then renamed to make them easier to read, by changing the following:

- any prefix of 't' for time is changed to a suffix of '+time'
- any prefix of 'f' for frequency is changed to a suffix of '+freq'
- any column that contains 'Acc' has that portion of it's name changed to '+acceleration'
- any column that contains 'Mag' has that portion of it's name changed to '+magnitude'
- any column that contains 'Gyro' or 'Jerk' has a '+' added before the word and the first letter changed to lower case
- any duplication of the word 'Body' is removed (i.e. 'BodyBody' becomes 'body')
- any parenthesis are removed
- any dashes '-' are changed to '+'
- all names are forced to lower case

Finally the data is summarized in a dataset that shows the mean for every column variable by subject and activity and then that data is saved to a txt file.
