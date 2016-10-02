#Download the zip file and create directory to store it

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./sports")){dir.create("./sports")}
download.file(url, destfile = "./sports/wk4.zip")

#Unzip the file

unzip(zipfile = "./sports/wk4.zip", exdir = "./sports")
file.rename("./sports/UCI HAR Dataset", "./sports/Data")

#read all the data files and create tables

x_test <- read.table("./sports/Data/test/X_test.txt")
y_test <- read.table("./sports/Data/test/y_test.txt")
sub_test <- read.table("./sports/Data/test/subject_test.txt")
x_tr <- read.table("./sports/Data/train/X_train.txt")
y_tr <- read.table("./sports/Data/train/y_train.txt")
sub_tr <- read.table("./sports/Data/train/subject_train.txt")
feats <- read.table("./sports/Data/features.txt")
activities <- read.table("./sports/Data/activity_labels.txt")

#Name the columns of "training" & "test" datasets from the feature.txt file

colnames(x_tr) <- feats[ ,2]
colnames(x_test) <- feats[ ,2]

#Name the y table columns as "Activity". Both tables are single columns
#and they keep integers from 1 - 6 to identify activity type

colnames(y_tr) <- "Activity"
colnames(y_test) <- "Activity"

#Name the subject table columns as "SubjectId". Both tables are single columns
#and they keep integers from 1 - 30 to identify each single volunteer
#of the experiment.

colnames(sub_tr) <- "SubjectId"
colnames(sub_test) <- "SubjectId"

#Name the columns of the "activities" table that has is formed
#from activity_labels.txt

colnames(activities) <- c("ActivityId","ActivityName")

#Merge the datasets.

#tr is the final "training" dataset with column names from the
#feature.txt file and with "Activity" & "SubjectId" added.

#test is the final "test" dataset with column names from the
#feature.txt file and with "Activity" & "SubjectId" added.

#all: "training" and "test" datasets combined.

tr <- cbind(y_tr, sub_tr, x_tr)
test <- cbind(y_test, sub_test, x_test)
all <- rbind(tr, test)

#Subset "all" dataset to obtain columns with mean and standard
#deviation (std). The new dataset is called "MeanStd".

data_names <- names(all)
subset_vec <- (grepl("Activity", data_names) | 
			grepl("SubjectId", data_names) | 
			grepl("mean\\(\\)", data_names) |
			grepl("std\\(\\)", data_names))
MeanStd <- all[ , subset_vec == TRUE]

#Give descriptive names to the "Activity" column of "MeanStd" dataset.

MeanStd$Activity <- factor(MeanStd$Activity, levels = activities[,1], labels = activities[,2])

#Change column names to be more descriptive.

names(MeanStd)<-gsub("^t", "time", names(MeanStd))
names(MeanStd)<-gsub("^f", "frequency", names(MeanStd))
names(MeanStd)<-gsub("Acc", "Accelerometer", names(MeanStd))
names(MeanStd)<-gsub("Gyro", "Gyroscope", names(MeanStd))
names(MeanStd)<-gsub("Mag", "Magnitude", names(MeanStd))
names(MeanStd)<-gsub("BodyBody", "Body", names(MeanStd))

#Create the tidy dataset by summarising the mean of every variable
# for every activity and every subject.

TidyData <- aggregate(. ~Activity + SubjectId, MeanStd, mean)

#Re-arrange the dataset: Sort according to "Activity" & "SubjectId".

FinalTidyData<- TidyData[order(TidyData$Activity,TidyData$SubjectId),]

#Write data in a txt file and store inside the working directory.

write.table(FinalTidyData, file = "FinalTidyData.txt",row.name=FALSE)