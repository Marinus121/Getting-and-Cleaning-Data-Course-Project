#Set working directory as ../UCI HAR Dataset
#setwd("")

#Import all neccesary tables 

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
y_test <- read.table("test/y_test.txt")
X_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_train <- read.table("train/y_train.txt")
X_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Add column names

colnames(y_test) <- "Activity"
colnames(X_test) <- features[,2]
colnames(subject_test) <- "Subject"
colnames(y_train) <- "Activity"
colnames(X_train) <- features[,2]
colnames(subject_train) <- "Subject"

#Merge data sets

test <- cbind(subject_test,y_test,X_test)
train <- cbind(subject_train,y_train,X_train)

Data <- rbind(test,train)

#Label activities

Data$Activity <- factor(Data$Activity,levels = c(1:6),labels = activity_labels[,2])

#Extract mean and Std variables

MeanStdFilt <- grep("Activity|Subject|mean|std",names(Data),)

Data <- Data[,MeanStdFilt]

#Calculate mean across all variables for Activity and Subject

MeanData <- aggregate(Data[, 3:81],list(Data$Activity,Data$Subject), mean)

names(MeanData) <- sub("Group.1","Activity",names(MeanData),)
names(MeanData) <- sub("Group.2","Subject",names(MeanData),)

write.table(Data,"Data.txt")
write.table(MeanData,"MeanData.txt")
