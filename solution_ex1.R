## set working directory to UCI HAR Dataset

### Project files for getting and cleaning data
######################################################################
### Part 1: Merge test and traing data sets

features = read.table('./features.txt',header=FALSE);
activity_Type = read.table('./activity_labels.txt',header=FALSE);
subject_Train = read.table('./train/subject_train.txt',header=FALSE);
x_Train = read.table('./train/x_train.txt',header=FALSE);
y_Train = read.table('./train/y_train.txt',header=FALSE);

colnames(activity_Type) = c('activityId','activityType');
colnames(subject_Train) = "subjectId";
colnames(x_Train) = features[,2]; 
colnames(y_Train) = "activityId";

### Merge data sets
training_Data = cbind(y_Train,subject_Train,x_Train);

# Import test data
subject_Test = read.table('./test/subject_test.txt',header=FALSE);
x_Test = read.table('./test/x_test.txt',header=FALSE);
y_Test = read.table('./test/y_test.txt',header=FALSE);

## New column names to test data set
colnames(subject_Test) = "subjectId";
colnames(x_Test)       = features[,2]; 
colnames(y_Test)       = "activityId";

# Merge test datasets to create final test data set
test_Data = cbind(y_Test,subject_Test,x_Test);

# Combine training and test data to create a final data set
final_Data = rbind(training_Data,test_Data);

# Create a vector for the column names 
colNames  = colnames(final_Data); 

###############################################################################
## Part 2: Mean and standard deviations for measurements.

logical_Vector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
final_Data = final_Data[logical_Vector==TRUE];

###############################################################################
## Part 3: Provide descriptive activity names

final_Data = merge(final_Data,activity_Type,by='activityId',all.x=TRUE);
colNames  = colnames(final_Data); 

###############################################################################
## Part 4: Provide labels to dataset

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(final_Data) = colNames;

###############################################################################
## Part 5: Create a tidy version of the dataset

finalDataNoActivityType  = final_Data[,names(final_Data) != 'activity_Type'];
tidy_Data = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);
tidy_Data = merge(tidy_Data,activity_Type,by='activityId',all.x=TRUE);

###############################################################################
# Write the final tidy data set file csv format
write.table(tidy_Data, './tidy_Data.csv',row.names=FALSE,sep=',');