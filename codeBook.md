# Code Book
This code book describes the data and transformations used to create the tidy data for the *Getting and Cleaning Data* Course Project. 

## Background
The experiment performed at the University of California Irvine lab followed 30 subjects as they performed six acitivities while wearing or otherwise carrying a smartphone (Samsung Galaxy S II), the internal sensors (accelerometer and gyroscope) of which was utilized in the measurement of 3-axial kinematic data (linear acceleration and angular velocity, respectively) at 50 Hz associated with these movements. The activities were tracked and video-recorded to label the data manually, and the dataset obtained was subsequently partitioned with either training (70% of subjects) or test (the remaining 30%) data. 
Through the use of Butterworth pass filters the measurements were decomposed into body and gravitational components and Fast Fourier Transforms were subsequently applied to them, processing them from time (denoted with prefix 't') to frequency domain ('f'). 

## Data File Guide
Once extracted, the final set of files available from the 'UCI HAR Dataset' were considered: 
* `subject_train.txt`: 7352 records comprising a vector indicating the ID of the volunteer subject at hand.
* `y_train.txt`: 7352 records comprising a vector indicating the code of the activity performed. 
* `X_train.txt`:  7352 records comprising observations across 561 fields ("features") detailing kinematic measurements noted above. 

* `subject_test.txt`: 2947 records comprising a vector indicating the ID of the volunteer subject at hand.
* `y_test.txt`: 2947 records comprising a vector indicating the code of the activity performed. 
* `X_test.txt`: 2947 records comprising observations across 561 fields ("features") detailing kinematic measurements noted above.

* `features.txt`: 561 records comprising an ordered two-column matrix, the second column of which details field names corresponding to kinematic measurements and calculated associated with subject movements. 
* `activity_labels.txt`: 6 records comprising the codes assigned to each activity. 

Two folders of 'Inertial Signals' corresponding respectively to the train and test triads were examined but ultimately not considered as part of this cleaning exercise, since it is heavily implied that these signals were already factored into the Butterworth decomposition separating body and gravitational signals. Additional information regarding the field names contained withing `features.txt` can be found in `features_info.txt`. 

## Processing Synopsis
0. Load libraries, find/create folders, download and extract raw data, and read into local tables. 
1. Merge data with similar columns from local tables, tagging subject with "train" or "test" just in case these details are needed later. 
2. Extract the feature names, using their indices to qualify the relevant columns by ascertaining either `mean` or `std` exists within fields in comb_x, reformat them, apply the feature names to them, and combine them with the activity and subject data. Fields with meanFreq were retained, since there was emphasis on understanding the effects within the frequency domain. 
3. Label the dataset with descriptive variable names by examining and cleaning up invalid and distracting punctuation marks in raw feature names within  qualified columns. 
4. Assign descriptive activity names based on coding from the activity labels table, re-factorize subject and activity data to make the fields more useful within the ultimate tidy dataset, and replace codes with labels. 
5. Create a second, independent tidy dataset with the average of each variable for each activity and each subject by assigning `subject`, `activity`, and `origSet` as IDs through `melt()`, then `dcast()` to derive the mean of each of the 79 feature name fields by the 180 combinations (30 subjects x 6 activities) of these three variables (`origset` is subject-specific, so it should not interfere).