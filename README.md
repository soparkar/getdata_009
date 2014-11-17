This README file explains the steps executed in run_analysis.R file to generate the expcted tidy dataset.

First, we load and process train dataset. User (called subject) data is loaded first, followed by the activity. Appropriate column-names are added. Numbers for each of the 6 activities are replaced by descriptive activity-names. Now we load the data of all (561) observations, to populate complete train data-set.
Then the same set of command are applied to test dataset. Once done, we merge both these datasets (by rbind).

In second part, we read features.txt file, which contains specific variable names. Hence we replace the column-numbers in har_dat frame with these names, and generate har_subset frame.

Because we have replaced numbers with meaningful names, part 3 and 4 are covered already, as explaine din detail in the comments in the R file.

For the final (5th) part, we aggregate the data-frame by generating mean-values across all observation columns, grpuping for each (of 30) user and each (of 6) activity. This gives us tidy_means_aggegaate dataset which has 180 rows. In the end, we store this dataset in a file.

