library(dplyr)

run_analysis<-function() {
  data1<-data.frame(read.table("train/X_train.txt"))
  data2<-data.frame(read.table("test/X_test.txt"))
  data<-merge(data1, data2, all = TRUE)
  label1<-data.frame(read.table("train/y_train.txt"))
  label2<-data.frame(read.table("test/y_test.txt"))
  sub1<-read.table("train/subject_train.txt")
  sub2<-read.table("test/subject_test.txt")
  activity_names<-read.table("activity_labels.txt")
  feature_names<-read.table("features.txt", stringsAsFactors = FALSE)
  label<-c()
  mean_vec<-c()
  sd_vec<-c()
  name<-c()
  sub<-c()
  features_mean<-c()
  features_sd<-c()
  col_names<-c()
  for (i in 1:nrow(feature_names)) {
    if (grepl("mean[()]", feature_names[i,][[2]])) {
      features_mean<-c(features_mean, i)
      col_names<-c(col_names, feature_names[i,][[2]])
    }
    else if (grepl("std[()]", feature_names[i,][[2]])) {
      features_sd<-c(features_sd, i)
      col_names<-c(col_names, feature_names[i,][[2]])
    }
  }
  result<-select(data, c(features_mean, features_sd))
  colnames(result)<-col_names
  for (j in 1:nrow(label1)) {
    label<-c(label, as.numeric(as.vector(label1[j,])))
  }
  for (k in 1:nrow(label2)) {
    label<-c(label, as.numeric(as.vector(label2[k,])))
  }
  for (x in 1:length(label)) {
    name<-c(name, as.vector(activity_names[label[x],][[2]]))
  }
  for (y in 1:nrow(sub1)) {
    sub<-c(sub, as.numeric((as.vector(sub1[y,]))))
  }
  for (z in 1:nrow(sub2)) {
    sub<-c(sub, as.numeric((as.vector(sub2[z,]))))
  }
  result<-mutate(result, activity=name)
  result<-mutate(result, subject=sub)
  write.table(result, "data1.txt", row.names = FALSE)
}

run_analysis2 <- function() {
  data<-read.table("data1.txt", header = TRUE)
  dt<-group_by(data, subject, activity)
  mean<-summarise_each(dt, funs(mean), -matches("activity", "subject"))
  write.table(mean, "data2.txt", row.names = FALSE)
}