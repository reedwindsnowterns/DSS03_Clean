# (0) Load libraries, find folders, download and extract raw data, 
#     and read into local tables
library(tidyverse); library(tools); library(reshape2)

# pre-name input/output directories
dir_proj <- "./project"
dir_data <- paste(dir_proj, "/data", sep = "")
dir_out <- paste(dir_proj, "/out", sep = "")

# create variable and path names for UCI HAR zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
loc_zip <- "UCIHAR.zip"
loc_zip_pathname <- paste(dir_data, "/", loc_zip, sep = "")

# form & create input/output directories
if(!file.exists(dir_proj)) { 
        dir.create(dir_proj)
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
}

# form directory paths based on new extracted file structure
dir_UCIHAR <- paste(dir_data, "/UCI HAR Dataset", sep ="")
dir_train <- paste(dir_UCIHAR, "/train", sep ="")
dir_test <- paste(dir_UCIHAR, "/test", sep ="")

# load training data triad: subject, activity, kinematic data
train_subj <- read.table(paste(dir_train, "/", "subject_train.txt", sep = ""))
train_y <- read.table(paste(dir_train, "/", "y_train.txt", sep = ""))
train_x <- read.table(paste(dir_train, "/", "X_train.txt", sep = ""))

# load testing data triad: subject, activity, kinematic data
test_subj <- read.table(paste(dir_test, "/", "subject_test.txt", sep = ""))
test_y <- read.table(paste(dir_test, "/", "y_test.txt", sep = ""))
test_x <- read.table(paste(dir_test, "/", "X_test.txt", sep = ""))

# load feature names and activity assignments into local tables
feat_labels <- read.table(paste(dir_UCIHAR, "/", "features.txt", sep = ""))
acty_labels <- read.table(paste(dir_UCIHAR, "/", "activity_labels.txt", sep = ""))

# (1) Merge data from local tables
train_subj <- mutate(train_subj, origSet = "train")
test_subj <- mutate(test_subj, origSet = "test")
comb_subj <- rbind(train_subj, test_subj)
comb_y <- rbind(train_y, test_y)
comb_x <- rbind(train_x, test_x)

# check dimensions
dim(comb_subj); dim(comb_y); dim(comb_x)
head(comb_subj); head(comb_y); head(comb_x)
names(comb_x)

names(comb_subj)[1] <- "subject"
names(comb_y) <- "activity"

# apply column names to comb_x use grep, maybe gsub to change relevant column names?

# Note: Feature name assigment not working because of duplicate names?? make.names maybe? 
# so delay till after merge I guess... 
# names(comb_x) <- make.names(feat_labels$V2)
# assume for now the angle columns which have "Mean" should be excluded
qualMeanCols <- grep("mean", feat_labels[, 2]); length(qualMeanCols)
qualStdCols <- grep("[S|s]td", feat_labels[, 2]); length(qualStdCols)
# combine into one vector and re-order ascending
qualCols <- sort(c(qualMeanCols, qualStdCols)) 
# examining qualCols, "-" and "()" are the invalid characters for vector names
# and "-" appears in front of Std, Mean, and XYZ coordinates
qualFeatLabels <- gsub("[-\\(\\)]", "", toTitleCase(as.character(feat_labels[qualCols, 2])))
qualFeatLabels <- gsub("mean", "Mean", qualFeatLabels)


# Select qualCols from comb_x, then bind with comb_subj, comb_y
# cbind comb_subj, comb_y, comb_x
sel_x <- comb_x[qualCols]; dim(sel_x)
comb_sel <- cbind(comb_subj, comb_y, sel_x) 
# Attach corresponding feature labels
colnames(comb_sel) <- c("subject", "origSet", "activity", qualFeatLabels)
names(comb_sel)

# Re-factorize subject and activity data
comb_sel$subject <- as.factor(comb_sel$subject)
comb_sel$activity <- factor(comb_sel$activity, levels = acty_labels[, 1], labels = acty_labels[, 2])

comb_melt <- melt(comb_sel, id = c("subject", "activity", "origSet"))
comb_tidy <- dcast(comb_melt, subject + activity ~ variable, mean)

# Create Tidy Data set
write.table(comb_tidy, file = "./project/data/tidy_data.txt")

# can backreferences be evaluated before passing into string function for gsub
# length(grep("-[mean|std|X|Y|Z]", qualFeatLabels))
# gsub("-mean", "Mean", qualFeatLabels[1:3])
# grep("-([mean|std])", qualFeatLabels[1:3])
# gsub("-([X|Y|Z])", tolower((" \\1")), qualFeatLabels[1:3])


feat_labels[qualCols, 2]
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


