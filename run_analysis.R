train_x <- read.table("UCI HAR Dataset/train/X_train.txt")[, as.numeric(filter_feature[,1])]
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")[, as.numeric(filter_feature[,1])]

train_y <-read.table("UCI HAR Dataset/train/y_train.txt")
test_y <-read.table("UCI HAR Dataset/test/y_test.txt")

train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(test_subj,test_y,test_x)
train <- cbind(train_subj,train_y,train_x)
data <-rbind(test,train)

features <- read.table("./UCI HAR Dataset/features.txt")
filter_feature <- features[grep("mean|std", features[,2]), ]




# replace dash
filter_feature[,2]<- gsub("-","_", filter_feature[,2])
# remove ()
filter_feature[,2]<- gsub("[()]","", filter_feature[,2]) 

colnames(data) <- c("subject", "activity", filter_feature[,2]) 
# match activity name
activity_name <- read.table("./UCI HAR Dataset/activity_labels.txt")
data$activity <- factor(data$activity, levels = activity_name[, 1], labels = activity_name[, 2])

new_data <-aggregate(data[, 3:ncol(data)], by=list(data$subject,data$activity), FUN=mean, na.rm=TRUE)
colnames(new_data)[1]<-'subject'
colnames(new_data)[2]<-'activity'


