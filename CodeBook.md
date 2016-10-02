#This is the Code Book for the run_analysis script.

##The following variables were used:

url: The link to the zipped data


x_test: Data frame from X_test.txt file. Contains the observations of "test" dataset.

y_test: Data frame from the y_test.txt file. Contains the activity type identifier for
each observation of the "test" dataset.

sub_test: Data frame from subject_test.txt. Contains the person identifier integers 
for every observation of the "test" dataset.


x_tr: Data frame from X_train.txt file. Contains the observations of "training" dataset.

y_tr: Data frame from y_train.txt file. Contains the activity type identifier for each 
observation of the "training" dataset.

sub_tr: Data frame from subject_train.txt file. Contains the person identifier integers 
for every observation of the "training" dataset.


feats: Data frame from features.txt file. Contains the variable names for the
"test" and "training" datasets.


activities: Data frame from activity_labels.txt file. Contains the id for every
type of activity and the related activity name.


tr: The final "training" dataset with column names taken from "feats" data,
with activity and with subject (volunteer) ids.


test: The final "test" dataset with column names taken from "feats" data,
with activity and with subject (volunteer) ids.


all: Data frame derived from the combination of "tr" and "test" datasets.
(Formed by binding "test" rows under "tr" rows).


data_names: The column names of "all" data frame.


subset_vec: The vector used to extract the columns with means and standard deviations from
"all" data frame.


MeanStd: The data frame with columns that include only means and standard deviations + activity
and subject id.


names(MeanStd): The column names of "MeanStd" data frame. Te following changes were made:

"t" in the the beginning of the column names was replaced by "time".

"f" in the the beginning of the column names was replaced by "frequency".

"Acc"  was replaced by "Accelerometer".

"Gyro"  was replaced by "Gyroscope".

"Mag"  was replaced by "Magnitude".

"BodyBody"  was replaced by "Body".


TidyData: Re-shaped data frame with the mean of every variable for each activity and subject id.

FinalTidyData: The final tidy dataset with data sorted according to ascending activity
and subject id.
