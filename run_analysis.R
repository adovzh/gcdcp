# location of data directory
DATA_DIR <- "UCI HAR Dataset"

# train dataset locations
X_TRAIN_FNAME <- paste0(DATA_DIR, "/train/X_train.txt")
LABELS_TRAIN_FNAME <- paste0(DATA_DIR, "/train/y_train.txt")
SUBJECT_TRAIN_FNAME <- paste0(DATA_DIR, "/train/subject_train.txt")

# test dataset locations
X_TEST_FNAME <- paste0(DATA_DIR, "/test/X_test.txt")
LABELS_TEST_FNAME <- paste0(DATA_DIR, "/test/y_test.txt")
SUBJECT_TEST_FNAME <- paste0(DATA_DIR, "/test/subject_test.txt")

# activity and features labels file locations
ACTIVITY_LABELS_FNAME <- paste0(DATA_DIR, "/activity_labels.txt")
FEATURES_FNAME <- paste0(DATA_DIR, "/features.txt")

# name of the result file
RESULT_FILE <- "aggregated.txt"

# load datasets into appropriate data frames
Xtrain <- read.table(X_TRAIN_FNAME)
labels.train <- read.table(LABELS_TRAIN_FNAME)
subject.train <- read.table(SUBJECT_TRAIN_FNAME)
Xtest <- read.table(X_TEST_FNAME)
labels.test <- read.table(LABELS_TEST_FNAME)
subject.test <- read.table(SUBJECT_TEST_FNAME)
activity.labels <- read.table(ACTIVITY_LABELS_FNAME)
features <- read.table(FEATURES_FNAME)

# combine datasets column-wise
train <- cbind(labels.train, subject.train, Xtrain)
test <- cbind(labels.test, subject.test, Xtest)

# merge train and test datasets
data <- rbind(train, test)

# use 'features' dataset to label variables appropriately
var.names <- c("Activity", "Subject", as.character(features[,2]))
colnames(data) <- var.names

# Variables describing means (standard deviations) match 'mean()' ('std()')
meanStdCols <- grep("(mean|std)\\(\\)", var.names)
# Only 'Activity', 'Subject' and those describing means and 
# standard deviations variables are retained
data <- data[, c(1:2, meanStdCols)]

# Activity numbers are in the first columns
# Replace them with appropriate desciptive names from 'activity.labels' dataset
data[,1] <- sapply(data[,1], function(i) { 
    activity.labels[match(i, activity.labels[,1]), 2]
})

# Calculate means of each variable by Activity and Subject
agg <- aggregate(. ~ Activity + Subject, data, mean)

# Write tidy dataset on disk
write.table(agg, file = RESULT_FILE, row.names = FALSE)
