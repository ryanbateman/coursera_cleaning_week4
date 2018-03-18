require(dplyr)

## This loads the activity names and their requisite IDs
activity_labels <- read.csv("data/activity_labels.txt", header = FALSE, sep = " ", col.names = c("id", "activity"))

## Load the training set
training_set <- read.table("data/train/X_train.txt")
training_labels <- read.table("data/train/y_train.txt")
training_subjects <- read.table("data/train/subject_train.txt")
training_labels <- cbind(training_subjects, training_labels)
names(training_labels) <- c("subjectid", "activityid")
training_names <- colnames(training_set)
## Calculate the mean and standard deviation for each row
training_set <- training_set %>% rowwise() %>% do(data.frame(., mean = mean(unlist(.[training_names])), standarddeviation = sd(unlist(.[training_names]))))
## Remove unnecessary columns
training_set <- training_set[, 562:563]
## Merge the labels and the newly calculated data
merge_training <- cbind(training_labels, training_set)

## Load the test set
test_set <- read.table("data/test/X_test.txt")
test_labels <- read.table("data/test/y_test.txt")
test_subjects <- read.table("data/test/subject_test.txt")
test_labels <- cbind(test_subjects, test_labels)
names(test_labels) <- c("subjectid", "activityid")
testNames <- colnames(test_set)
## Calculate the mean and standard deviation for each row
test_set <- test_set %>% rowwise() %>% do(data.frame(., mean = mean(unlist(.[testNames])), standarddeviation = sd(unlist(.[testNames]))))
## Remove unnecessary columns
test_set <- test_set[, 562:563]
merge_test <- cbind(test_labels, test_set)

## Combine the two data sets
all_data <- rbind(merge_test, merge_training)

## Turn activity IDs into activity labels
all_data$activity <- tolower(activity_labels$activity[match(all_data$activity, activity_labels$id)])

## Summarise the data
summary <- all_data %>% group_by(subjectid, activity) %>% summarise(average_mean = mean(mean), average_sd = mean(standarddeviation))