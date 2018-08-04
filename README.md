# CleaningDataWeek4
Final submition for Coursera Getting and Cleaning Data

This repository contains a run_analysis.R file that will do the following:

1. Read in a Human Activity Recognition Using Smartphones Dataset produced by Samsung.
2. Combine the test and training data
3. Replace the Activity variable with meaningful names
4. Replace the variable names of the data set with easy to read names
5. Extract only the mean and standard deviation for each measurement
6. Summarise the data set produced in step 5 by calculating the mean value of the measurements grouped by subject and activity.
7. Export the summarised table in step 6 to a text file named "SummarisedDataSet.txt"

The files used to construct the summarised table are: 

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Prerequisits for this script to work.

dplyr package https://cran.r-project.org/web/packages/dplyr/index.html

The script requires that Samsung data set for Human Activity Recognition Using Smartphones.

Place the "DATASET" folder into the R working directory.
Place the run_analysis.R file into the working directory.
Source the run_analysis.R script.
