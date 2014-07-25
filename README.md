This script performs pre-processing of an input raw dataset collected from the accelerometers from the Samsung Galaxy S smartphone and produces a new tidy dataset, prepared for further analysis.

It is possible to run this script from the command line, like this:
```Bash
Rscript run_analysis.R
```

Otherwirse, it can be run from R
```R
source("run_analysis.R")
```

The necessary condition for this script to succeed is that it runs from the directory containing "UCI HAR Dataset" subdirectory with raw data. It will create aggregated.txt output text file with tidy dataset with the average of each variable for each activity and each subject.

The script reads 6 datasets into appropriate data frames:

- Training set
- Training labels
- Training subjects
- Test set
- Test labels
- Test subjects

Then it combines training datasets vertically and test datasets vertically, resulting in training and test datasets, and then combines them horizontally, resulting in union of all observations. Variable names are loaded from `features.txt` and assigned as a column names of a merged dataset. 

After that, only those columns that have either `mean()` or `std()` in their name are retained, all the other are discarded.

Activity labels are replaced with appropriate activity labels loaded from `activity_labels.txt`.

Finally, all the variables are aggregated by activity and subject, resulting in a mean value for each pair of an activity and a subject.
