### Getting and Cleaning Data
#### October 2015

#### Script to create tidy data set
The source of the original data is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file is to be downloaded and its contents extracted so that one R working
directory contains a directory titled, "UCI HAR Dataset".

The run_analysis.R scripting file contains code to read the following files in this order:
1. features.txt - This file contains the names of all the feature vectors.  It is 
parsed with a grep() to find the specific features required for the tidy data.  This parsing
will result in a vector containing the column indexes of the required features and a 
vector containing the feature names to be used to add column headers to the tidy data.

2.  activity_labels.txt - This file contains textual labels for the activities
the subjects performed.  In the final tidy data the labels will be used to substitute for
the numeric activity variable.

3. test/x_test.txt - The actual data from the experiments is contained in this file.

4. test/y_test.txt - This file contains a row-by-row match of the activity performed
and the data from x_test.txt.

5. test/subject_test.txt - Like the activities from y_test.txt, this file lines up the
subjects with their activities and data.

Files 3 through 5 are used to create a data set of the "test" data.  These steps are then
repeated to create the "train" data from train/X_train.txt, train/y_train.txt, and
train/subject_train.txt/


The "test" and "train" data will combined into one data set.  From it the data will be
aggregated into means for each feature, separated out by subject and activity.  This 
will result in 180 observations for 66 features.


The run_analysis.R script will output a comma delimited file, "tidy_data.txt" in 
the working directory.

#### Codebook

run_analysis.R will not rename the variables from feature.txt.  I decided to leave the
names the same as I don't see how I can add any value to that provided by the original
researchers.  "tBodyGyroJerk-mean()-X" may be a bit cryptic but it's a lot more concise 
than my interpretation of "the average of the subject's gyroscope's rapid and sudden 
movement along the X axis."

Sixty-six features plus columns for Subject and Activity yield sixty-eight variables in
tidy_data.txt.

Here is the subset of features in the tidy data, by position:
```
 1                     Subject
 2                    Activity
 3           tBodyAcc-mean()-X
 4           tBodyAcc-mean()-Y
 5           tBodyAcc-mean()-Z
 6            tBodyAcc-std()-X
 7            tBodyAcc-std()-Y
 8            tBodyAcc-std()-Z
 9        tGravityAcc-mean()-X
10        tGravityAcc-mean()-Y
11        tGravityAcc-mean()-Z
12         tGravityAcc-std()-X
13         tGravityAcc-std()-Y
14         tGravityAcc-std()-Z
15       tBodyAccJerk-mean()-X
16       tBodyAccJerk-mean()-Y
17       tBodyAccJerk-mean()-Z
18        tBodyAccJerk-std()-X
19        tBodyAccJerk-std()-Y
20        tBodyAccJerk-std()-Z
21          tBodyGyro-mean()-X
22          tBodyGyro-mean()-Y
23          tBodyGyro-mean()-Z
24           tBodyGyro-std()-X
25           tBodyGyro-std()-Y
26           tBodyGyro-std()-Z
27      tBodyGyroJerk-mean()-X
28      tBodyGyroJerk-mean()-Y
29      tBodyGyroJerk-mean()-Z
30       tBodyGyroJerk-std()-X
31       tBodyGyroJerk-std()-Y
32       tBodyGyroJerk-std()-Z
33          tBodyAccMag-mean()
34           tBodyAccMag-std()
35       tGravityAccMag-mean()
36        tGravityAccMag-std()
37      tBodyAccJerkMag-mean()
38       tBodyAccJerkMag-std()
39         tBodyGyroMag-mean()
40          tBodyGyroMag-std()
41     tBodyGyroJerkMag-mean()
42      tBodyGyroJerkMag-std()
43           fBodyAcc-mean()-X
44           fBodyAcc-mean()-Y
45           fBodyAcc-mean()-Z
46            fBodyAcc-std()-X
47            fBodyAcc-std()-Y
48            fBodyAcc-std()-Z
49       fBodyAccJerk-mean()-X
50       fBodyAccJerk-mean()-Y
51       fBodyAccJerk-mean()-Z
52        fBodyAccJerk-std()-X
53        fBodyAccJerk-std()-Y
54        fBodyAccJerk-std()-Z
55          fBodyGyro-mean()-X
56          fBodyGyro-mean()-Y
57          fBodyGyro-mean()-Z
58           fBodyGyro-std()-X
59           fBodyGyro-std()-Y
60           fBodyGyro-std()-Z
61          fBodyAccMag-mean()
62           fBodyAccMag-std()
63  fBodyBodyAccJerkMag-mean()
64   fBodyBodyAccJerkMag-std()
65     fBodyBodyGyroMag-mean()
66      fBodyBodyGyroMag-std()
67 fBodyBodyGyroJerkMag-mean()
68  fBodyBodyGyroJerkMag-std()
```
