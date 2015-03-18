# Getting-and-cleaning-dat
## As requisite for grading

For the peer-assesmet we were ask to develop a script named run_analysis.R that can do the next tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script uses a database from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and tidies up the data producing an average from the training and test sets, creating an csv file with the data.  You need to save the script into the working directory and write <b> source("run_analysis.R") </b> to start the execution of the script.  The script will download the file for you and unzip it in the working directory, if this fail, you have to download the zip file from the url and unzip it in your working directory leaving the original name of the directory.

For more information about the data, please read the <b> codebook.md </b>. 

Thank you for your time reviewing this work.
