# Step (0) Load libraries, find folders, download and extract raw data, 
#          and read into local tables

library(tidyverse); 
# getwd()
# if(!file.exists("./project/data")){dir.create("./project/data")}
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./project/data/getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")


train_subj <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
train_y <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
train_x <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

test_subj <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
test_y <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
test_x <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

        # read feature names and activity assignments into local tables

feat_labels <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
acty_labels <- read.table("./project/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Step (1) Merge data from local tables
train_subj <- mutate(train_subj, origSet = "train")
test_subj <- mutate(test_subj, origSet = "test")
comb_subj <- rbind(train_subj, test_subj)
comb_y <- rbind(train_y, test_y)
comb_x <- rbind(train_x, test_x)

# check dimensions
dim(comb_subj)
dim(comb_y)
dim(comb_x)
head(comb_subj)
head(comb_y)
head(comb_x)
names(comb_x)

names(comb_subj)[1] <- "subject"
names(comb_y) <- "activity"
# Note: Feature name assigment not working because of duplicate names?? make.names maybe? 
# so delay till after merge I guess... 
names(comb_x) <- make.names(feat_labels$V2)

qualMeanCols <- grep("[M|m]ean", feat_labels[, 2])
length(qualMeanCols)
qualStdCols <- grep("[S|s]td", feat_labels[, 2])
length(qualStdCols)


feat_labels[qualMeanCols, 2]
feat_labels[qualStdCols, 2]
tryNames <- make.names(feat_labels[, 2])
unique(tryNames)

?gsub
?read.table
class(testXData)
dim(testXData)
head(testXData, 2)
names(testXData)

class(testYData)
dim(testYData)
head(testYData)

names(testXData) %in% names(trainXData)

dim(trainXData)
dim(testXData)
unique(testYData$X5)
unique(trainYData$X5)

trainData <- cbind(trainSubjData, trainYData, trainXData) %>%
        mutate(set = "train")
testData <- cbind(testSubjData, testYData, testXData) %>%
        mutate(set = "test")
combData <- rbind(trainData, testData)
dim(testData)


names(testData)[1:8]
names(trainData)[1:8]
sum(names(testData)[100:559] %in% names(trainData))
testData[1:3, 1:8]
trainData[1:3, 1:8]
testData[2944:2946, 557:564]
trainData[7349:7351, 557:564]

