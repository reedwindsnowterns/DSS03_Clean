#  (0) Load libraries, find/create folders, download and extract raw data, 
#      and read into local tables
library(tidyverse); library(tools); library(reshape2)

###### pre-name input/output directories
dir_proj <- "./project"
dir_data <- paste(dir_proj, "/data", sep = "")
dir_out <- paste(dir_proj, "/out", sep = "")

###### create variable and path names for UCI HAR zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
loc_zip <- "UCIHAR.zip"
loc_zip_pathname <- paste(dir_data, "/", loc_zip, sep = "")

###### find & create project directories and input/output directories within
if(!file.exists(dir_proj)) { 
        dir.create(dir_proj)
}        
if(!file.exists(dir_data)) { 
        dir.create(dir_data)
        download.file(fileUrl, 
                      destfile = loc_zip_pathname,
                      method = "curl")
        unzip(loc_zip_pathname, exdir = dir_data)
}
if(!file.exists(dir_out)) { 
        dir.create(dir_out)
}

###### form directory paths based on new extracted archive structure
dir_UCIHAR <- paste(dir_data, "/UCI HAR Dataset", sep ="")
dir_train <- paste(dir_UCIHAR, "/train", sep ="")
dir_test <- paste(dir_UCIHAR, "/test", sep ="")

###### load training data triad: subject, activity, kinematic data
train_subj <- read.table(paste(dir_train, "/", "subject_train.txt", sep = ""))
train_y <- read.table(paste(dir_train, "/", "y_train.txt", sep = ""))
train_x <- read.table(paste(dir_train, "/", "X_train.txt", sep = ""))

###### load testing data triad: subject, activity, kinematic data
test_subj <- read.table(paste(dir_test, "/", "subject_test.txt", sep = ""))
test_y <- read.table(paste(dir_test, "/", "y_test.txt", sep = ""))
test_x <- read.table(paste(dir_test, "/", "X_test.txt", sep = ""))

###### load feature names and activity assignments into local tables
feat_labels <- read.table(paste(dir_UCIHAR, "/", "features.txt", sep = ""))
acty_labels <- read.table(paste(dir_UCIHAR, "/", "activity_labels.txt", sep = ""))

#  (1) Merge data with similar columns from local tables, tagging subject with
#      "train" or "test" just in case these details are needed later
train_subj <- mutate(train_subj, origSet = "train")
test_subj <- mutate(test_subj, origSet = "test")
comb_subj <- rbind(train_subj, test_subj)
comb_y <- rbind(train_y, test_y)
comb_x <- rbind(train_x, test_x)

#  (2) Extract only the measurements which include a mean or standard deviation
###### qualify the feature names to be extracted by finding "mean" or "[S|s]td"
###### note that grep on "Mean" returns angular data, not actual means
qualMeanCols <- grep("mean", feat_labels[, 2]); length(qualMeanCols)
qualStdCols <- grep("[S|s]td", feat_labels[, 2]); length(qualStdCols)

###### combine indices of qualified names into one vector and re-order ascending
qualCols <- sort(c(qualMeanCols, qualStdCols)) 

#  (3) Label the dataset with descriptive variable names
###### examine and clean up invalid and distracting punctuation marks in raw 
###### feature names within  qualCols, i.e. "-" and "()" for field names
###### note that "-" appears in front of Std, Mean, and XYZ coordinates
qualFeatLabels <- gsub("[-\\(\\)]", "", 
                       toTitleCase(as.character(feat_labels[qualCols, 2])))
qualFeatLabels <- gsub("mean", "Mean", qualFeatLabels)

###### select qualified columns from comb_x, then bind with comb_subj, comb_y
sel_x <- comb_x[qualCols]; dim(sel_x)
comb_sel <- cbind(comb_subj, comb_y, sel_x) 
###### attach corresponding feature labels to selected columns of kinematic data
colnames(comb_sel) <- c("subject", "origSet", "activity", qualFeatLabels)

#  (4) Assign descriptive activity names based on coding from acty_labels 
###### re-factorize subject and activity data, replacing codes with labels
comb_sel$subject <- as.factor(comb_sel$subject)
comb_sel$activity <- factor(comb_sel$activity, levels = acty_labels[, 1], labels = acty_labels[, 2])

#  (5) create a second, independent tidy dataset with the average of each  
#      variable for each activity and each subject
###### melt data set, identifying by subject & activity; origSet included for 
###### simplicity, which should not change the number of ID combinations
comb_melt <- melt(comb_sel, id = c("subject", "activity", "origSet"))
###### recast dataset along IDs to return means of all other variables, which 
###### are numeric, to find the mean for each subject + activity combination
comb_tidy <- dcast(comb_melt, subject + activity + origSet ~ variable, mean)

###### output data into newly created file; place within output folder
write.table(comb_tidy, file = paste(dir_out, "/", "tidy_data.txt", sep = ""))
