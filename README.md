# run-analysis
##Getting and Cleaning Data Week4 Final Assignment

The script is split into the following steps:

1. Downloading the data.
By storing the supplied link in "url" variable and creating a new folder called "sports"
to store the data, we use the download.file to download the zip file in our working
directory.

2. Unzip the data.
Function unzip helps us to unzip the downloaded file inside the "sports" folder.
The unziped folder is renamed from "UCI HAR Dataset" to "Data" for convenience with function
file.rename.

3. Read data files & create data frames.
Using read.table function, we read all the necessary files and import them in R as data frames.
More details about the representation of every initial data frame by a variable can be found
in the Code Book.

4. Name the columns of the data frames.
Using colnames() function, we assign new column names to the following datasets:
- "training" dataset (x_tr) --> takes column names from "features.txt".
- "test" dataset (x_test) --> takes column names from "features.txt".
- "training" dataset activity ids (y_tr) --> "Activity" is assigned as column name.
- "test" dataset activity ids (x_tr) --> "Activity" is assigned as column name.
- "training" dataset subject ids (sub_tr) --> "SubjectId" is assigned as column name.
- "test" dataset subject ids (sub_test) --> "SubjectId" is assigned as column name.
- "Activity" dataset with activity ids and names (activities) --> "ActivityId" & "ActivityName" are assigned
  as column names.

5. Merge data.
Initially, we form the full "training" & "test" datasets by adding the respective columns of "Activity"
and "SubjectId". Function cbind() is used to achieve this.
Afterwards we use rbind() function to stack the reformed "test" dataset under
the reformed "training" dataset.
The new complete dataset is called "all".

6. Subset data.
With grepl function, we detect the columns with "mean" & "std" in their names in "all". We keep
in our search columns "Activity" & "SubjectId". We store the filtered dataset in a variable
called "MeanStd".

7. Convert the "Activity" column into a "factor" variable.
We want the activity variable to have descriptive name for every activity type.
With factor() function we take the factor labels from the "activities" data frame column 2.
It corresponds to the levels of column 1 of the "activities" data frame.

8. Change column names to be more descriptive.
We update the names(MeanStd) vector by replacing short versions of words with their full version:
"time" for "t", "Gyroscope" for "Gyro", "Accelerometer" for "Acc", "Magnitude" for "Mag",
"frequency" for "f" and "Body" for "BodyBody"

9. Create the final tidy dataset.
With "aggregate" function we get the mean of every variable for every activity type & every subject.
Then with order, we sort the data to activity type and then to subject.

10. Create txt file.
With write.table we re-write the tidy dataset in a txt file.
