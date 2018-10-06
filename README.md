# Getting-and-Cleaning-Data-Course-Projectrun_analysis.R 


Steps to run the script

upload the run_analysis.R in RStudio

Select the whole script 

Then Run or source

Output console should show up tidy data table

or type View(extractedMeanData) to view the table

Thanks for grading 
#END

Variables used in the code and steps though

#assign a variable to the destination folder
destFolder 

#check weather directory exists, then create in not

#set the working directory

#assign a variable to the url file
fileUrl
#assign a varaiable to zip file
zipfile
#downlaod the url file
#unzip the downloaded zip file
unzip(zipfile)
#rename the unzip folder for clarity

#read data X_train, y_train, X_test, y_test, subject_train,subject_test, features and actvities into dataframes
x_train
y_train
x_test
y_test

#some parameters needs to be address for following dataframes
subject_train
subject_test

featuresCol
activitiesCol


#make sure read files imported into data.frames
#transpose colun feature data.frame into a row frame.frame>> we need to assign features to the data columns
features

#remove the [digits] and () in column names
features

#apply the features as column names 

#apply subject as title for subject field

#apply activity as title for y_train and y_test

#add the activity and subject columns to x_train and x_test

#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
##First extract column names from the data frame

##3.extract the new dataframe using extarctCols
extractData

#4.assign activities to variable activities
activities

##5.average the  each variable for each activity and each subject by using aggregate function.

  extractedMeanData
  extractedMeanData <-extractedMeanData[,1:35]- remove lasttwo columns
#rename the defaulted group columns
  
  colnames(extractedMeanData)[1]<-'subject'
  colnames(extractedMeanData)[2]<-'activity'
#write tidy table to a file
  write.table(extractedMeanData,file ="./tidyData.txt",row.names = FALSE)
#final output tidy data  
  extractedMeanData
#END
