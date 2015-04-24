run_analysis <- function(){
  # All files should be saved and unzipped in working directory
  library(dplyr)
  
  ## Import raw data and combine datasets 
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  data <- rbind(x_test, x_train)
  
  ## Import features list, find and subset mean and standard deviations
  features <- read.table("/Users/michelle/UCI HAR Dataset/features.txt")
  index_mean <- grep("mean()",features$V2)
  index_std <- grep("std()",features$V2)
  index <- c(index_mean, index_std)
  data <- data[,index]
  
  ## Name the variables
  names <- as.character(features$V2[index])
  names <- gsub("-", "", names)
  names <- gsub("[()]","", names)
  colnames(data) <- names
  
  ## Add Subjects
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subjects <- rbind(subject_test, subject_train)
  colnames(subjects) <- "Subject"
  data <- cbind(subjects, data)  
  
  ## Add activities
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  activities <- rbind(y_test, y_train)
  colnames(activities) <- "ActivityCode"
  data <- cbind(activities, data)
  key <- read.table("/Users/michelle/UCI HAR Dataset/activity_labels.txt")
  data <- merge(key, data, by.x = "V1", by.y = "ActivityCode", sort = FALSE)
  colnames(data) <- c("ActivityCode", "Activity", "Subject", names)

  ## Summarize output and write to .txt file
  groups <- group_by(data, Subject, Activity)
  output <- summarise_each(groups, funs(mean), -ActivityCode)
  write.table(output, file = "./output.txt")
  
}