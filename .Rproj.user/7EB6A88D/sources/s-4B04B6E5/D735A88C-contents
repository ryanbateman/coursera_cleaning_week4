require(dplyr)
require(matrixStats)

## This function loads a data set, given the data, label and subjects file common to the test and training data sets
loadDataSet <- function(datasetfile, labelfile, subjectsfile) {
    dataset <- read.table(datasetfile)
    datalabels <- read.table(labelfile)
    datasubjects <- read.table(subjectsfile)
    ## Combine the labels and subjects
    datalabels <- cbind(datasubjects, datalabels)
    ## Give the data the appropriate headings
    names(datalabels) <- c("subjectid", "activityid")
    training_names <- colnames(dataset)
    ## Calculate the mean and standard deviation for each row
    dataset <- dataset %>% transmute(mean = rowMeans(.[training_names]), standarddeviation = rowSds(as.matrix(.[training_names])))
    ## Merge the labels and the newly calculated data
    mergedData <- cbind(datalabels, dataset)
    mergedData
}

## This loads the activity names and their requisite IDs
activity_labels <- read.csv("data/activity_labels.txt", header = FALSE, sep = " ", col.names = c("id", "activity"))

## Set up the training and test files required
trainingDataFile <- "data/train/X_train.txt"
trainingLabelsFile <- "data/train/y_train.txt"
trainingSubjectsFile <- "data/train/subject_train.txt"
testDataFile <- "data/test/X_test.txt"
testLabelsFile <- "data/test/y_test.txt"
testSubjectsFile <- "data/test/subject_test.txt"

# Read, reshape and return the required test and training data sets
trainingData <- loadDataSet(trainingDataFile, trainingLabelsFile, trainingSubjectsFile)
testData <- loadDataSet(testDataFile, testLabelsFile, testSubjectsFile)

## Combine the two data sets
all_data <- rbind(testData, trainingData)

## Turn activity IDs into activity labels
all_data$activity <- tolower(activity_labels$activity[match(all_data$activity, activity_labels$id)])
all_data$activity <- gsub("_", " ", all_data$activity)

## Summarise the data
summary <- all_data %>% group_by(subjectid, activity) %>% summarise(average_mean = mean(mean), average_sd = mean(standarddeviation))