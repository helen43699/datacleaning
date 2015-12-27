# Getting and Cleaning Data Course Project

#-------1. Merges the training and the test sets to create one data set-----------
library(data.table)  
# Merge activity data
train_x = fread("./UCI HAR Dataset/train/X_train.txt", sep = " ", header= FALSE)
test_x = fread("./UCI HAR Dataset/test/X_test.txt", sep = " ", header= FALSE)
x = rbind(train_x,test_x)

# Merge label data
train_y = fread("./UCI HAR Dataset/train/y_train.txt", sep = " ", header= FALSE)
test_y = fread("./UCI HAR Dataset/test/y_test.txt", sep = " ", header= FALSE)
y = rbind(train_y,test_y)

# Merge subject data
train_s = fread("./UCI HAR Dataset/train/subject_train.txt", sep = " ", header= FALSE)
test_s = fread("./UCI HAR Dataset/test/subject_test.txt", sep = " ", header= FALSE)
s = rbind(train_s,test_s)

# Merge data without labels
data0 = cbind(x,y,s)

# Add column names
features = read.table("./UCI HAR Dataset/features.txt")
colnames(x) = t(features[2])
colnames(y) = "Activity"
colnames(s) = "Subject"


# Merge all data to one set
data = cbind(x,y,s)

#-------2. Extracts only the measurements on the mean and standard deviation for each measurement----------
features = read.table("UCI HAR Dataset/features.txt", header=FALSE, stringsAsFactors=FALSE)
features = make.names(features[,"V2"])
g = grep(pattern="std|mean", x=features, ignore.case=TRUE)
data_mean = data[,c(g,562,563)]

#-------3. Uses descriptive activity names to name the activities in the data set-------------
activities = read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
data$Activity = factor(data$Activity,levels=activities$V1,labels=activities$V2)

#-------4. Appropriately labels the data set with descriptive variable names-----------
# Labels have been added in step 1.
# Replace Abbreviation with full name
names(data) = gsub("Acc", "Accelerator", names(data))
names(data) = gsub("Mag", "Magnitude", names(data))
names(data) = gsub("Gyro", "Gyroscope", names(data))
names(data) = gsub("^t", "time", names(data))
names(data) = gsub("^f", "frequency", names(data))

#-------5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.-------------
data_clean = aggregate(x = data, by = list(data$Subject, data$Activity),FUN = "mean")
# Somehow Task 2 didn't work properly, so it's repeated here. 
#-------2. Extracts only the measurements on the mean and standard deviation for each measurement----------
g = grep(pattern="std|mean", x=names(data_clean), ignore.case=TRUE)
data_final = data_clean[,c(1,2,g)]
colnames(data_final) = c("Subject","Activity",g)
write.table(data_final, file = "data.txt", row.names = FALSE) 

