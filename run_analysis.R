setwd("~/Desktop/gacd/UCI HAR Dataset")

## read test data ###
subject_test=read.table("./test/subject_test.txt")
X_test=read.table("./test/X_test.txt")
y_test=read.table("./test/y_test.txt")

## read train data ###
subject_train=read.table("./train/subject_train.txt")
X_train=read.table("./train/X_train.txt")
y_train=read.table("./train/y_train.txt")
features=read.table("./features.txt")


##### 1. Merges the training and the test sets to create one data set. #####
X=rbind(X_train,X_test)
colnames(X)=features[,2]
y=rbind(y_train,y_test)
colnames(y)="activity"
subject=rbind(subject_train,subject_test)
colnames(subject)="subject"
data=data.frame(X,y,subject)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement. #####
data_part2=NULL;
data_part2_names=NULL;
data_ncol=ncol(data)
data_names=names(data)
for (i in 1:data_ncol ){
  if (regexec("[Mm]ean",data_names[i])>0 || regexec("[Ss]td",data_names[i])>0   ) {
    data_part2=cbind(data_part2,data[,i])
    data_part2_names=c(data_part2_names,data_names[i])
  }
}
colnames(data_part2)=data_part2_names
data_part2=data.frame(data_part2)

##### 3. Uses descriptive activity names to name the activities in the data set #####
# this has been done in part 1

##### 4. Appropriately labels the data set with descriptive activity names. #####
data_nrow=nrow(data)
y_act_names=y
for (i in 1:data_nrow){
    if (y[i,1]==1){
      y_act_names[i,1]="WALKING"
    }else if (y[i,1]==2){
      y_act_names[i,1]="WALKING_UPSTAIRS"
    }else if (y[i,1]==3){
      y_act_names[i,1]="WALKING_DOWNSTAIRS"
    }else if (y[i,1]==4){
      y_act_names[i,1]="SITTING"
    }else if (y[i,1]==5){
      y_act_names[i,1]="STANDING"
    }else{
      y_act_names[i,1]="LAYING"
    }
}
colnames(y_act_names)="activity.name"
data_with_activity_names=data.frame(X,y_act_names,subject)
write.table(data_with_activity_names, file = "data.txt",sep = ",")

##### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.#####
data_second=NULL
for (act in 1:6){
  for (sub in 1:30){
    subdata=subset(data,(data$activity==act & data$subject==sub))
    if (nrow(subdata)==0){
      data_second=rbind(data_second,0*(1:561))
    }else{
      tmp=NULL
      for (i in 1:561){
        tmp=c(tmp,mean(subdata[,i]))
      }
      data_second=rbind(data_second,tmp)
    }
  }
}

colnames(data_second)=features[,2]
unit30=1*c(1:30)
act_vec=c(1*unit30,2*unit30,3*unit30,4*unit30,5*unit30,6*unit30)
sub_vec=c(1:30,1:30,1:30,1:30,1:30,1:30)
as=cbind(act_vec,sub_vec)
colnames(as)=c("activity","subject")
data_second=data.frame(data_second,as)
write.table(data_with_activity_names, file = "second_data.txt",sep = ",")
