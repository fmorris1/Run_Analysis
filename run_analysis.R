## This script does the following:
## 1) Merges the training and the test sets to create one data set. 
## 2) Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
## 3) Uses descriptive activity names to name the activities 
## in the data set 
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) Calls a second script call run_analysis_tidy_data2.R to complete the task of creating
## a separate independent dataset starting from the original raw data.

## load dataset in R

dataFile = "dataset.RData"
if (!file.exists(dataFile)) {
        temp = read.table("activity_labels.txt", sep = "")
        activityLabels = as.character(temp$V2)
        temp = read.table("features.txt", sep = "")
        attributeNames = temp$V2
        
        Xtrain = read.table("./train/X_train.txt", sep = "")
        names(Xtrain) = attributeNames
        Ytrain = read.table("./train/y_train.txt", sep = "")
        names(Ytrain) = "Activity"
        Ytrain$Activity = as.factor(Ytrain$Activity)
        levels(Ytrain$Activity) = activityLabels
        trainSubjects = read.table("./train/subject_train.txt", sep = "")
        names(trainSubjects) = "subject"
        trainSubjects$subject = as.factor(trainSubjects$subject)
        train = cbind(trainSubjects, Xtrain,Ytrain)
        
        Xtest = read.table("./test/X_test.txt", sep = "")
        names(Xtest) = attributeNames
        Ytest = read.table("./test/y_test.txt", sep = "")
        names(Ytest) = "Activity"
        Ytest$Activity = as.factor(Ytest$Activity)
        levels(Ytest$Activity) = activityLabels
        testSubjects = read.table("./test/subject_test.txt", sep = "")
        names(testSubjects) = "subject"
        testSubjects$subject = as.factor(testSubjects$subject)
        test = cbind(testSubjects, Xtest, Ytest)
        
        save(train, test, file = dataFile)
        rm(train, test, temp, Ytrain, Ytest, Xtrain, Xtest, trainSubjects, testSubjects, 
           activityLabels, attributeNames)
}

load(dataFile)

## Merges the training and the test sets to create one data set

train$Partition = "Train"
test$Partition = "Test"
all = rbind(train, test)  # combine sets for further analysis
all$Partition = as.factor(all$Partition)


## Extracts only the measurements on the mean and standard deviation for each measurement

MnSvData <- all[,grepl("-mean()|-std()|subject|Activity|Partition", names(all))]

## Uses descriptive activity names to name the activities in the data set
## Activity labels were added to the end of the dataset during the read process

MnSvData2 <- MnSvData[c(80:82, 1:79)] ## Reorder the activity labels to the front of the dataset for clarity

## Appropriately labels the data set with descriptive variable names

names(MnSvData2) <- gsub("tBodyAccJerk","TimeBodylinearAccel", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyAccMag","TimeBodyAccelMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyAcc","TimeBodyAccel", names(MnSvData2) )
names(MnSvData2) <- gsub("tGravityAcc","TimeGravityAccel", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyGyroJerk","TimeBodyAngularVeclocity", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyGyro","TimeBodyGyro", names(MnSvData2) )
names(MnSvData2) <- gsub("tGravityAccMag","TimeGravityAccelMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyAccJerkMag","TimeBodylinearAccelMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyGyroJerkMag","TimeBodyGyroMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("tBodyGyroMag","TimeBodyAngularVeclocityMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyGyroJerkMag","FreqBodyAngularVeclocityMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyBodyAccJerkMag","FreqBodylinearAccelMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyAccMag","FreqBodyAccelMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyBodyAccJerk","FreqBodylinearAccel", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyGyroMag","FreqBodyGyroMagnitude", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyAcc","FreqBodyAccel", names(MnSvData2) )
names(MnSvData2) <- gsub("fBodyGyro","FreqBodyGyro", names(MnSvData2) )

print("Now saving Tidy Dataset 1")

write.csv(MnSvData2, file ="./TidyDataSet1.csv")   

source("run_analysis_tidy_data2.R")
                
