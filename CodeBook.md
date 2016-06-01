The analysis was performed according to the following steps:

1) I downloaded the data from the website given in the instructions, which contained 
a bunch of data sets for all the features related with the domain of the problem. 
After that, I tried to understand which of the data sets should be the ones I will be 
working on. So, I discovered that the files that will matter for me are: activity_labels.txt
and features.txt on the UCI HAR Dataset folder, the subject_train.txt, X_train.txt and y_train.txt 
on the train folder and the respective files on the test folder.

2) On my analysis, first I readed the features.txt file which contained all the variables that were 
collected during the study. I extracted the id and the name of the variables that were only related 
with mean and standart deviation (std). 

3) I readed the X_test.txt data set, which contained the observations and selected only the collums
that were chosen in step 2 (variable id_mean_std). I also readed the subject_test.txt file and the 
y_test.txt file, that contained respectively the subjects related to that observation and the type of
activity related with that observation (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING
5 STANDING, 6 LAYING). On this step I also renamed the collums according with the ones selected in
step 2 (variable names_mean_std). I did the same thing on the test folder. Here are the names of the 
varibles of the data set:

4) After that, I labeled the name of each observation on the "activity" collum according with their
respective names (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING).

5) I merged the two data sets (test and training). For more information, read the comments on the 
run_analysis.R file.

