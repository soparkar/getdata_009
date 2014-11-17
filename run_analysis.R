# part 1
# Processing train dataset
har_train_subject <- read.table("train/subject_train.txt")
har_train_y <- read.table("train/y_train.txt")
har_train_dat <- cbind(har_train_subject, har_train_y)
colnames(har_train_dat) <- c("user", "activity_name")
har_train_dat$activity_name[har_train_dat$activity_name == 1] <- "WALKING"
har_train_dat$activity_name[har_train_dat$activity_name == 2] <- "WALKING_UPSTAIRS"
har_train_dat$activity_name[har_train_dat$activity_name == 3] <- "WALKING_DOWNSTAIRS"
har_train_dat$activity_name[har_train_dat$activity_name == 4] <- "SITTING"
har_train_dat$activity_name[har_train_dat$activity_name == 5] <- "STANDING"
har_train_dat$activity_name[har_train_dat$activity_name == 6] <- "LAYING"
har_train_x <- read.table("train/x_train.txt")
har_train <- cbind(har_train_dat, har_train_x)

# Processing test dataset
har_test_user <- read.table("test/subject_test.txt")
har_test_y <- read.table("test/y_test.txt")
har_test_dat <- cbind(har_test_user, har_test_y)
colnames(har_test_dat) <- c("user", "activity_name")
har_test_dat$activity_name[har_test_dat$activity_name == 1] <- "WALKING"
har_test_dat$activity_name[har_test_dat$activity_name == 2] <- "WALKING_UPSTAIRS"
har_test_dat$activity_name[har_test_dat$activity_name == 3] <- "WALKING_DOWNSTAIRS"
har_test_dat$activity_name[har_test_dat$activity_name == 4] <- "SITTING"
har_test_dat$activity_name[har_test_dat$activity_name == 5] <- "STANDING"
har_test_dat$activity_name[har_test_dat$activity_name == 6] <- "LAYING"
har_test_x <- read.table("test/x_test.txt")
har_test <- cbind(har_test_dat, har_test_x)

har_dat <- rbind(har_train, har_test)
# har_dat contains all HAR entries, merged together, from train and test datasets.
# end of part 1

# part 2
features <- read.table("features.txt")
features <- data.frame(lapply(features, as.character), stringsAsFactors=FALSE)
base_columns <- c("user", "activity_name")
colnames(features) <- c("index", "titles")
titles <- c(base_columns, features$titles)
colnames(har_dat) <- titles
meansandstddevs <- titles[grepl("mean", titles) | grepl("std", titles)]
subset_titles <- c(base_columns, meansandstddevs)

har_subset <- har_dat[subset_titles]
# har_subset contains all those HAR entries whose variable-names contain either "mean" or "std"
# end of part 2

# part 3
# The problem-statement is: Use descriptive activity names to name the activities in the data set.
# This is already achieved, at lines 7 through 12, and then from 20 through 25, as seen above, by 
# replacing numbers 1 through 5 by their respective activities.
# end of part 3

# part 4
# The problem-statement is: Appropriately label the data set with descriptive variable names.
# This is already achieved, as the column-names of har_subset are extracted from features.txt
# Naming in this way helps standardize the names (which are camel-cased and hence very legible),
# and their descriptions are readily available in features_info.txt
# end of part 4

# part 5
tidy_means_aggegaate <- aggregate(x = har_subset[, 3:ncol(har_subset)], by = list(user = har_subset$user, activity_name = har_subset$activity_name), FUN = "mean")
# tidy_means_aggegaate is a 180*81 dataframe, where all subsequent columns contain the mean-values
# of their respective variables, calculated over each (of 30) users, for each (of 6) activities.
# end of part 5

# writing the output to a file
write.table(tidy_means_aggegaate, file="tidy_dataset.txt", row.name=FALSE)
