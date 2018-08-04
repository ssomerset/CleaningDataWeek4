library(dplyr)

table_train_data  <- read.table("Dataset/train/X_train.txt")  ## Training data set - features, 7352 rows, 561 columns
table_test_data   <- read.table("Dataset/test/X_test.txt")    ## Testing data set - features, 2947 rows, 561 columns
table_merged_data <- rbind(table_train_data,table_test_data)  ## Combine the testing and training data set - 10299 rows, 561 columns


labels_features           <- read.table("dataset/features.txt")                         ## Read in the list of feature labels 561 rows, 2 columns
names(table_merged_data)  <- labels_features[,2]                                        ## Add the column names to the table
ind_std_mean              <- grep("(mean[(][)]){1}|(std[(][)]){1}",labels_features[,2]) ## Find the indices of the mean and standard deviation of each measurement


table_mean_std <- table_merged_data[,ind_std_mean]                        ## Extract only the mean and standard deviation, 10299 rows, 66 columns

table_train_subject   <- read.table("Dataset/train/subject_train.txt")    ## Training data set - subjects, 7352 rows, 1 column
table_train_activity  <- read.table("Dataset/train/y_train.txt")          ## Training data set - activities, 7352 rows, 1 column
table_train_meta      <- cbind(table_train_subject,table_train_activity)  ## Training data set - combined subjects and activities, 7352 rows, 2 columns

table_test_subject  <- read.table("Dataset/test/subject_test.txt")      ## Testing data set - subjects, 2947 rows, 1 column
table_test_activity <- read.table("Dataset/test/y_test.txt")            ## Testing data set - activities, 2947 rows, 1 column
table_test_meta     <- cbind(table_test_subject,table_test_activity)    ## Testing data set - combined subjects and activities, 2947 rows, 2 columns

table_subject_activity <- rbind(table_train_meta, table_test_meta)      ## Training and Testing set - subjects and activities 10299 rows, 2 columns

names(table_subject_activity) <- c("Subject", "Activity")               ## Name the subject and activity columns

table_mean_std <- cbind(table_subject_activity,table_mean_std)      ## Combined data sets with subjects and activities, only mean and std. dev., 10299 rows, 68 columns

table_activities <- read.table("Dataset/activity_labels.txt")       ## Read in the activity lables
table_mean_std[,2] <- table_activities[table_mean_std[,2],2]        ## Add meaningful names to the activites for each object

table_grouped <- group_by(table_mean_std, Subject, Activity)        ## Create groups within the table, first by subject and then activity using Dplyr
table_summarised <- summarise_all(table_grouped, funs(Mean = mean))            ## Summarise the table using the mean of each subject and activity

## Create a lookup table  to clean up the variable names
DF_Lookup <- data_frame(
  Key   = c("(-)", "(_)", "(mean[(][)])"     , "(std[(][)])"             , "^t"           ,"^f"                 , "(Acc)"         , "(Mag)"        , "(X)"       , "(Y)"       , "(Z)"       , "\\s+Mean$","Jerk"  ,"Body"  ,"\\s+"), 
  Value = c(" "  , " "  , " - Mean Value " , " - Standard Deviation ","Time Domain - ","Frequency Domain - ", " Acceleration ", " Magnitude "  , " (X-Axis) ", " (Y-Axis) ", " (Z-Axis) ", ""         ," Jerk" ," Body "," "   ))

## Create easy to read feature names using gsub
tidyNames      <- names(table_summarised)

for (j in 1:length(DF_Lookup[[1]])){
    FindValue     <- DF_Lookup[j,1]
    ReplaceValue  <- DF_Lookup[j,2]
    tidyNames     <- gsub(FindValue,ReplaceValue,tidyNames)
}

## Apple the tidy names to the summarised tables
names(table_summarised)    <- tidyNames
names(table_mean_std)      <- tidyNames

## Create output file
write.table(table_summarised, row.names=FALSE, file = "SummarisedDataSet.txt")

## Clean up
rm(table_train_data, table_test_data, labels_features,
   table_merged_data, table_grouped, DF_Lookup,FindValue,
   ReplaceValue, table_activities, table_subject_activity,
   table_test_activity, table_test_meta, table_test_subject,
   table_train_activity, table_train_meta, table_train_subject,
   j, ind_std_mean, tidyNames, table_summarised, table_mean_std)
