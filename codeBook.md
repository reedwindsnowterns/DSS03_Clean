# Code Book
This code book describes the data and transformations used to create the tidy data for the Getting and Cleaning Data Course Project. 

## Background
The experiment performed at the University of California Irvine lab followed 30 subjects as they performed six acitivities while wearing or otherwise carrying a smartphone (Samsung Galaxy S II), the internal sensors (accelerometer and gyroscope) of which was utilized in the measurement of 3-axial kinematic data (linear acceleration and angular velocity, respectively) at 50 Hz associated with these movements. The activities were tracked and video-recorded to label the data manually, and the dataset obtained was subsequently partitioned with either training (70% of subjects) or test (the remaining 30%) data. 

Through the use of Butterworth pass filters the measurements were decomposed into body and gravitation components and a Fast Fourier Transforms were then applied to them, processing them from time (denoted with prefix 't') to frequency domain ('f'). 

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

Two folders of 'Inertial Signals' corresponding respectively to the train and test triads were examined but ultimately not considered as part of this cleaning exercise, since it is heavily implied that these signals were already factored into the Butterworth decomposition separating body and gravitational signals. Additional information regarding the

## Processing Synopsis
0. Load libraries, orient folders, download and extract necessary files, read into local tables
1. Merge together corresponding local tables across the test and train triads via rbind() into combined data sets (e.g. comb_x for X_train + X_test)
2. Extract the feature names, use their indices to qualify relevant fields in comb_x and reformat them, apply the feature names to them, and combine them with the 
3. Re-factorize the activity names and subject codes to make the fields more useful within the ultimate tidy dataset, since they are ultimately going to be group_by-summarize / melt-dcast categories as opposed to numeric operands. 
4. `melt()` and `dcast()` the data by subject and activity. 
5. Output data and write to `.txt` file. 