##Here the steps thati follow for resolve the exercise 
#Step1 DOWNLOAD THE DATA
library(data.table)
Fileurl= "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI HAR Dataset.zip")){
        download.file(Fileurl, destfile = "./UCI HAR Dataset.zip", mode = "wb")
        unzip ("UCI HAR Dataset.zip", exdir= getwd())
} 
##Step2 Reading the data

features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep=" ")
features <- as.character(features [,2])

Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainactivity <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep= " ") 
data.train <-read.csv("./UCI HAR Dataset/train/subject_train.txt", header= FALSE, sep=" ")

data.test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

##Step3 Convert Data 
data.train_converted <-  data.frame(data.train, trainactivity, Xtrain)
names(data.train) <- c(c('subject', 'activity'), features)

data.test_converted <-  data.frame(data.test.subject, data.test.activity, data.test.x)
names(data.test) <- c(c('subject', 'activity'), features)

##Step4 Merging data sets
data.all <- rbind(data.train_converted, data.test_converted) 

##Step5 Extract the data

mean_std.select <- grep('mean|std', features)
data.sub <- data.all[,c(1,2,mean_std.select + 2)]


##Step6 Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

##Step7 Appropriately labels the data set with descriptive variable names. 
name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

##Step8 Tidy Data
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)

##Here the steps thati follow for resolve the exercise 
#Step1 DOWNLOAD THE DATA
library(data.table)
Fileurl= "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI HAR Dataset.zip")){
        download.file(Fileurl, destfile = "./UCI HAR Dataset.zip", mode = "wb")
        unzip ("UCI HAR Dataset.zip", exdir= getwd())
} 
##Step2 Reading the data

features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep=" ")
features <- as.character(features [,2])

Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainactivity <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep= " ") 
data.train <-read.csv("./UCI HAR Dataset/train/subject_train.txt", header= FALSE, sep=" ")

data.test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

##Step3 Convert Data 
data.train_converted <-  data.frame(data.train, trainactivity, Xtrain)
names(data.train) <- c(c('subject', 'activity'), features)

data.test_converted <-  data.frame(data.test.subject, data.test.activity, data.test.x)
names(data.test) <- c(c('subject', 'activity'), features)

##Step4 Merging data sets
data.all <- rbind(data.train_converted, data.test_converted) 

##Step5 Extract the data

mean_std.select <- grep('mean|std', features)
data.sub <- data.all[,c(1,2,mean_std.select + 2)]


##Step6 Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

##Step7 Appropriately labels the data set with descriptive variable names. 
name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

##Step8 Tidy Data
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)