# Introduction

This README outlines the data, process and output for the handling and processing of fitness data obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data processing

The data obtained from the above URL is downloaded and placed into a 'data' folder within the R workspace in which it will be processed. The script `run_analysis.R`, when run, will load, clean and process the data, before outputting a summary of it grouped by subject and activity to a file called `summarised_data.csv` workspace's main directory. It uses the 'dplyr' and 'matrixStats' libraries to accomplish this.  

The script `runAnalysis.R` performs the following steps for the two data sets, `test` and `training`. 

- Loads the features 

For each data set it runs the function `loadDataSet` which:
- Loads the data set file containing the observations (e.g. `X_test.txt`)
- Associate the relevant columns with their names, as pulled from the features file
- Loads the subjects file containing the list of subject IDs associated with the above observations (e.g. `subject_test.txt`)
- Loads the labels file containing the activity IDs associated with the observations (e.g. `y_text.txt`)
- Combine the labels and subject file into a single dataframe, given they are of the same length and order
- Obtain all readings which have either 'mean' or 'std' in their name, regardless of case
- Merge the calculated mean and standard deviation with the subject and activity ID data
- Return this data frame

Having loaded the `test` and `training` data sets with the above function, the script will then append one dataset to the other. The function `tidyActivities` is then run, and the combined dataset has its associated activity IDs replaced with human readable labels which were obtained by reading the `data/activity_labels.txt` file. This is turned into a factor to ensure data integrity.  

The data frame is then summarised by grouping it by subject and activity, and returning the average value of the mean and standard deviation values calculated for each grouping. This summarised data is then outputted to the `summarised_data.txt` file with the `write.table` command as specified. This creates a 'wide' dataset. 
