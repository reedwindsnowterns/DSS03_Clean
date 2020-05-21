# Final Project for the _Getting and Cleaning Data_ Course

## Overview of Data Origins and Analysis
The purpose of the assigment is to demonstrate the candidate's ability to collect, work with, and clean a dataset, with the ultimate goal for that dataset to be both tidy and useful for later analysis. Kinematic data was collected using the accelerometer and gyroscope hardware from native to Samsung Galaxy S smartphones in a [Smartphone-recorded Human Activity Recognition Study] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by the University of California at Irvine. 

The pertinent data was gathered into [a vast and comprehensive dataset] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), which in turn serves as the project's starting point for the analysis in R. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Placement and Execution
1. The script `run_analysis` expects a working directory to be one able to accomodate a `/project/data` folder, to which the zip archive referenced above will be downloaded. 
2. Accordingly, `run_analysis.R` should be placed in the parent directory to `/project`
3. Run `run_analysis.R`, which will read in all the relevant data files, qualify and bind the requisite fields for output, aggregate, and output the result. 
4. Its output, `tidy_data.txt` will be written to /project/data. 

## Dependencies
The script `run_analysis.R` lists the relevant dependencies at the outset, which are ```tidyverse```, `tools`, and `reshape2`. 