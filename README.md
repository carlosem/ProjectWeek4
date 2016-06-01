
The script responsible for cleaning up the data is in the run_analysis.R 

The data sets used are in the UCI HAR Dataset folder.

The other files can be ignored.

## NOTE: I performed the analysis following a different order from the one on the instructions of the exercise, because I think it has a better flow for the programming and it is more intuitive

The script does the following:

1 - Read the Features and find out each collums have observations with mean and standart deviation, then extract the respective id's and name of the collums.
      
2 - Read the test set and select the appropriate observations from the previous steps. (It involved reading the files subject_test.txt, y_test.txt, X_test.txt and merging them). Do the same thing with the trainning set.
      
3 - Using descriptive names for the activities in the data set.

4 - Merging the datas.

5 - Creating a new tidy data set with the average of each variable for each activity and each subject.

