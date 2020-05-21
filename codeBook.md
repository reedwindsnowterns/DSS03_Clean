# Code Book
This code book describes the data and transformations used to create the tidy data for the Getting and Cleaning Data Course Project. 

## Background
The experiment performed at the University of California Irvine lab followed 30 subjects as they performed six acitivities while wearing or otherwise carrying a smartphone (Samsung Galaxy S II), the internal sensors (accelerometer and gyroscope) of which was utilized in the measurement of 3-axial kinematic data (linear acceleration and angular velocity, respectively) at 50 Hz associated with these movements. The activities were tracked and video-recorded to label the data manually, and the dataset obtained was subsequently partitioned with either training (70% of subjects) or test (the remaining 30%) data. 

Through the use of Butterworth pass filters the measurements were decomposed into body and gravitation components and a Fast Fourier Transforms were then applied to them, processing them from time (denoted with prefix 't') to frequency domain ('f'). 

## File Guide
Once extracted, the final set of files available from the 'UCI HAR Dataset', as shown 

