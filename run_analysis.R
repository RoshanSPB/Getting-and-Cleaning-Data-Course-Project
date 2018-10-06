#Human Activity Recognition Using Smartphones - Data Extraction
#Here I use functionality of dplyr package
library(dplyr)

#assign a variable to the destination folder
destFolder <- "./GettingandCleaningDataCourseProject/"

#check weather directory exists, then create in not
if(!file.exists(destFolder)){dir.create("./GettingandCleaningDataCourseProject")}

#set the working directory
setwd("C:/Users/rbokalawela/Documents/GitHub/GettingandCleaningDataCourseProject")

#assign a variable to the url file
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#assign a varaiable to zip file
zipfile<-"./Dataset.zip"

#downlaod the url file
download.file(fileUrl,destfile=zipfile)

#unzip the downloaded zip file
unzip(zipfile)

#rename the unzip folder for clarity
file.rename("./UCI HAR Dataset","./Dataset")

#read data X_train, y_train, X_test, y_test, subject_train,subject_test, features and actvities into dataframes
x_train<-read.table("./Dataset/train/X_train.txt",header = FALSE)
y_train<-read.table("./Dataset/train/y_train.txt",header = FALSE)
x_test<-read.table("./Dataset/test/X_test.txt",header = FALSE)
y_test<-read.table("./Dataset/test/y_test.txt",header = FALSE)

#some parameters needs to be address for following dataframes
subject_train<-read.csv("./Dataset/train/subject_train.txt",header = FALSE,sep = "\n",fill = TRUE, comment.char = "")
subject_test<-read.csv("./Dataset/test/subject_test.txt",header = FALSE,sep = "\n",fill = TRUE, comment.char = "")

featuresCol<-read.csv("./Dataset/features.txt",header = FALSE,sep = "\n",fill = TRUE)
activitiesCol<-read.csv("./Dataset/activity_labels.txt",header = FALSE,sep = "\n",fill = TRUE)


#make sure read files imported into data.frames
featureTable<-as.data.frame(featuresCol)
subject_train<-as.data.frame(subject_train)
subject_test<-as.data.frame(subject_test)

x_trainTable<-as.data.frame(x_train)
y_train<-as.data.frame(y_train)
x_testTable<-as.data.frame(x_test)
y_test<-as.data.frame(y_test)
#transpose colun feature data.frame into a row frame.frame>> we need to assign features to the data columns
features<- t(featureTable)

#remove the [digits] and () in column names
features<-gsub("^\\d+\\s+|[()]", "", features)

#apply the features as column names 
colnames(x_train)<-c(features)
colnames(x_test)<-c(features)

#apply subject as title for subject field
colnames(subject_train)<-c("subject")
colnames(subject_test)<-c("subject")

#apply activity as title for y_train and y_test
colnames(y_train)<-c("activity")
colnames(y_test)<-c("activity")

#add the activity and subject columns to x_train and x_test
x_train<-cbind(x_train, subject_train, y_train)
x_test<-cbind(x_test, subject_test, y_test)

#1.Merges the training and the test sets to create one data set.
mergeData<-rbind(x_train,x_test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
##First extract column names from the data frame
extractColnames <- grep(c("tBodyAcc-mean|tBodyAcc-std|
               tGravityAcc-mean|tGravityAcc-std|
               tBodyAccJerk-mean|tBodyAccJerk-std|
               tBodyGyro-mean|tBodyGyro-std|
               tBodyGyroJerk-mean|tBodyGyroJerk-std|
               tBodyAccMag-mean|tBodyAccMag-std|
               tGravityAccMag-mean|tGravityAccMag-std|
               tBodyAccJerkMag-mean|tBodyAccJerkMag-std|
               tBodyGyroMag-mean|tBodyGyroMag-std|
               tBodyGyroJerkMag-mean|tBodyGyroJerkMag-std|
               fBodyAcc-mean|fBodyAcc-std|
               fBodyAccJerk-mean|fBodyAccJerk-std|
               fBodyGyro-mean|fBodyGyro-std|
               fBodyAccMag-mean|fBodyAccMag-std|
               fBodyAccJerkMag-mean|fBodyAccJerkMag-std
               fBodyGyroMag-mean|fBodyGyroMag-std
               fBodyGyroJerkMag-mean|fBodyGyroJerkMag-std"), names(mergeData), value = TRUE)


##3.extract the new dataframe using extarctCols
extractData<-mergeData[,c(extractColnames,"subject","activity")]

#4.assign activities to variable activities
activities<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

for(i in 1:length(extractData$activity))
   {
      if(extractData$activity[i] == 1)
        {
            extractData$activity[i] = activities[1]
      }
  else if(extractData$activity[i] == 2)
  {
    extractData$activity[i] = activities[2]
  }
  if(extractData$activity[i] == 3)
  {
    extractData$activity[i] = activities[3]
  }
  if(extractData$activity[i] == 4)
  {
    extractData$activity[i] = activities[4]
  }
  if(extractData$activity[i] == 5)
  {
    extractData$activity[i] = activities[5]
  }
  if(extractData$activity[i] == 6)
  {
    extractData$activity[i] = activities[6]
  }
}

##5.average the  each variable for each activity and each subject by using aggregate function.

  extractedMeanData <-  aggregate(extractData,by = list(extractData$subject , extractData$activity), mean )
#remove the residual columns at the end
  extractedMeanData <-extractedMeanData[,1:35]
#rename the defaulted group columns
  
  colnames(extractedMeanData)[1]<-'subject'
  colnames(extractedMeanData)[2]<-'activity'
#write tidy table to a file
  write.table(extractedMeanData,file ="./tidyData.txt",row.names = FALSE)
#final output tidy data  
  extractedMeanData
#END