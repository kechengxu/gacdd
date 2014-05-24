Data:

-data  the data for submit after merging work
-data_part2  the data required in the part 2 of the assignment.
-data_with_activity_names  the data after changing the activities from indices to names
-data_second  the data required in part 5 of the assignment

#################################################################################################################

Procedure of my work:

part 1: 
-use matrix rbind to merge train and test data
-use data.frame to construct the dataframe from matrix

part 2:
-use regular expressions to search required features
-search them one by one and merge them by rbind and data.frame as part 1

part3 and part 4:
-run a for loop to make change

part 5:
-calculate the means by for loop
-merge the them by cbind and data.frame
