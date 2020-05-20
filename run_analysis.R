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

names(trainSubjData) <- names(testSubjData) <- "Subject"
names(trainXData) <- names(testXData) <- featureNames$V2
names(trainYData) <- names(testYData) <- "Activity"

?grep
qualMeanCols <- grep("[M|m]ean", featureNames[, 2])
length(qualMeanCols)
qualStdCols <- grep("[S|s]td", featureNames[, 2])
length(qualStdCols)
featureNames[qualMeanCols, 2]
featureNames[qualStdCols, 2]
tryNames <- make.names(featureNames[, 2])
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

