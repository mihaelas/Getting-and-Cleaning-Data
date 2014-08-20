Original instructions:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 


Project description: 

How the script run_analysis.R works: 

1. download the UCI HAR dataset into the working dataset
2. read the tables X_train.txt,y_train.txt,subject_test.txt from the directory called train 
3. load the feature key from features.txt : extract the measurements on the mean and standard deviation for each measurement 
4. read the activity_labels.txt: Label the data set with descriptive activity names
5. merge the training and test data sets called: data_merged.txt

