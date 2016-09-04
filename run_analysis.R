### Set up the variables required to read and piece together 
###  the test and training data

## all files are in the UCI HAR Dataset directory in the working directory

## read the features.txt file to get the all column names
the_headers <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = " ")

## get the columns of interest
# For the purposes of this project, only the basic mean and standard deviations
#  will be part of the tidy data set.  The measurements which have been
#  calculated by meanFreq() and gravityMean() will not be part of this project
the_cols <- 
  unname(
    unlist(
      lapply(
        subset(
          the_headers, 
          select = c(2)), 
        function(x) grep("\\bmean()\\b|std()", x)
        )
      )
    )

## activity labels for the tidy data set later in this script
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", 
                            header = FALSE, 
                            sep = " ")

## The test and training data are fixed width format files.  Each column of
##  data is 16 characters and there are 561 columns of data.  The number of
##  columns can be discovered with:
##  length(the_headers[,1])

# reading all the columms is slow, so take advantage of the ability to skip
# columns when using read.fwf()
# create a vector with 561 elements; set them all to -16 to skip each column
col_widths <- rep(c(-16), each = 561)
# now set the columns we actually want to a positive sixteen
col_widths[the_cols] <- 16
# the file has a leading space
col_widths[1] <- 17
# to double check, each line in the file is 8977 characters. 
#    (8977 - 1)/16 = 561   Perfect.  Let's go read some data....


### Get the data for test, activities, and subjects
## Test data
test_x <- read.fwf("UCI HAR Dataset/test/X_test.txt", 
                   header = FALSE, 
                   widths = col_widths)

# rename the columns
names(test_x) <- as.vector(the_headers[the_cols,2])

## Test activities
test_y_activity <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE)

## Subjects
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Use column binding to place the subjects and their activites with their
##  corresponding data
test <- cbind(subject_test, test_y_activity, test_x)

## add names to these two new columns
names(test)[1:2] <- c("Subject", "Activity")

## clean up some memory space; like when I'm cooking, I try to clean as I go
rm(test_x)
rm(test_y_activity)
rm(subject_test)


### Get the data for training

train_x <- read.fwf("UCI HAR Dataset/train/X_train.txt", 
                    header = FALSE, 
                    widths = col_widths)

# The rbind() call to merge the data sets will fail if the column names don't
#  match so go ahead and name them.
names(train_x) <- as.vector(the_headers[the_cols,2])

train_y_activity <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE)

subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

train <- cbind(subject_train, train_y_activity, train_x)

names(train)[1:2] <- c("Subject", "Activity") 

rm(train_x)
rm(train_y_activity)
rm(subject_train)


### Combine test and train

## use row binding to stack the two data sets together
merged_data <- rbind(test, train)

rm(test)
rm(train)

rm(the_headers)
rm(col_widths)
rm(the_cols)


### Create the tidy data set
## unique(merged_data[, 1:2]) tells me I have 180 unique combinations of
##   subject and activity 

tidy_data <- aggregate(merged_data[, 3:68], 
                       list(merged_data$Subject, merged_data$Activity), 
                       mean)

### never assume anything; do a few spot checks to ensure the tidy data
###  is correct
# double_check <- subset(merged_data, 
#                        Subject == 2 & Activity == 5, 
#                        select = c(3))
# mean(double_check[,1])
# tidied_data <- tidy_data[which(
#   tidy_data$Group.1 == 2 & tidy_data$Group.2 == 5),]

names(tidy_data)[1:2] <- c("Subject", "Activity")

# change the activity codes to meaningful labels
tidy_data$Activity <- activity_labels$V2[match(tidy_data$Activity, 
                                               activity_labels$V1)]

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, sep = ",")

rm(activity_labels)
rm(merged_data)
rm(tidy_data)

