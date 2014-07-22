data.dir <- "UCI HAR Dataset"
Xtrain.fname <- paste0(data.dir, "/train/X_train.txt")
ytrain.fname <- paste0(data.dir, "/train/y_train.txt")
Xtest.fname <- paste0(data.dir, "/test/X_test.txt")
ytest.fname <- paste0(data.dir, "/test/y_test.txt")
subjecttest.fname <- paste0(data.dir, "/test/subject_test.txt")
activitylabels.fname <- paste0(data.dir, "/activity_labels.txt")
features.fname <- paste0(data.dir, "/features.txt")

Xtrain <- read.table(Xtrain.fname)
ytrain <- read.table(ytrain.fname)
Xtest <- read.table(Xtest.fname)
ytest <- read.table(ytest.fname)
subjecttest <- read.table(subjecttest.fname)
activitylabels <- read.table(activitylabels.fname)
features <- read.table(features.fname)

train <- cbind(ytrain, Xtrain)
test <- cbind(ytest, Xtest)

data <- rbind(train, test)
var.names <- c("ActivityId", as.character(features[,2]))
colnames(data) <- var.names
meanStdCols <- grep("(mean|std)\\(\\)", var.names)
data <- data[, c(1, meanStdCols)]

colnames(activitylabels) <- c("ActivityId", "Activity")
