#Create a tidy data set 
#Read the files: X_train.txt

trainData <- read.table("./train/X_train.txt")
dim(trainData) # dim(7352*561)
head(trainData)

#######################################################
# Read the file: y_train.txt

trainLabel <- read.table("./train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./train/subject_train.txt")
testData <- read.table("./test/X_test.txt")
dim(testData) # dimension obtained (2947*561)
testLabel <- read.table("./test/y_test.txt")
table(testLabel)
##########################################################
#Read the file : subject_test.txt

testSubject <- read.table("./test/subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData) # dimension obtained(10299*561)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # dimension obtained (10299*1)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # dimension obtained (10299*1)
########################################################
# Extract the measurements on the mean and standard deviation for each measurement.
features <- read.table("./features.txt")
dim(features) # dimension obtained (561*2)
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # dimension obtained (66)
joinData <- joinData[, meanStdIndices]
dim(joinData) # dimension obtained (10299*66)
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 
##########################################################
# Uses descriptive activity names to name the activities in the data set
activity <- read.table("./activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"
###########################################################

#Labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) # dimension obtained (10299*68)
write.table(cleanedData, "data_merged.txt") # write out the merged dataset

############################################################
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # dim(30)
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "tidy.txt") # write out the tidy dataset
