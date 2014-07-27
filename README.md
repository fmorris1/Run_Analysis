Run_Analysis
============

Getting and Cleaning Data - Course Project

The purpose of this project was to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

I was required to submit: 

1) a tidy data set as described below
2) a link to a Github repository with my script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md. 

This README.md file how all of the scripts work and how they are connected.  


I created a R script called run_analysis.R that does the following

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
4) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Run_analysis directly performs task 1 to 4.  When task 4 is completed and the first Tidy Dataset is saved, run_analysis call a second script call run_analysis_tidy_data2.R to complete the task of creating a separate independent dataset starting from the original raw data.
