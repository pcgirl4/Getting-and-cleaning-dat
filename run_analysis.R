# First we create some objects to use later.
data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archivo <- "./original.dataset.zip"
directorio <- "./UCI HAR Dataset"

tidy.data.file <- './tidy-UCI-HAR-dataset.csv'
tidy.avgs.data.file <- './tidy-UCI-HAR-avgs-dataset.csv'

# We must verify that the file is in the environment.
if(!file.exists(archivo)){
  download.file(data.url, destfile = archivo)
}

# If the file cannot be found, then "crash"
if(!file.exists(archivo)){
  stop(paste(archivo), " must be in the environment")
}

# Then unzip the file
if(!file.exists(directorio)){
  unzip(archivo)
}

# Again, if can't, "crash"
if(!file.exists(directorio)){
  stop("unable to unzip file")
}

# Read activity labels
actividades <- read.table(paste(directorio, 'activity_labels.txt', sep = '/'),
                   header = FALSE)
names(actividades) <- c('id', 'name')

# Read feature labels
caracteristicas <- read.table(paste(directorio, 'features.txt', sep = '/'),
                    header = FALSE)
names(caracteristicas) <- c('id', 'name')

# Read the plain data files, assigning sensible column names
train.X <- read.table(paste(directorio, 'train', 'X_train.txt', sep = '/'),
                      header = FALSE)
names(train.X) <- caracteristicas$name
train.y <- read.table(paste(directorio, 'train', 'y_train.txt', sep = '/'),
                      header = FALSE)
names(train.y) <- c('activity')
train.subject <- read.table(paste(directorio, 'train', 'subject_train.txt',
                                  sep = '/'),
                            header = FALSE)
names(train.subject) <- c('subject')
test.X <- read.table(paste(directorio, 'test', 'X_test.txt', sep = '/'),
                     header = FALSE)
names(test.X) <- caracteristicas$name
test.y <- read.table(paste(directorio, 'test', 'y_test.txt', sep = '/'),
                     header = FALSE)
names(test.y) <- c('activity')
test.subject <- read.table(paste(directorio, 'test', 'subject_test.txt',
                                 sep = '/'),
                           header = FALSE)
names(test.subject) <- c('subject')

# Merge the training and test sets
X <- rbind(train.X, test.X)
y <- rbind(train.y, test.y)
subject <- rbind(train.subject, test.subject)

# Extract just the mean and SD features
X <- X[, grep('mean|std', caracteristicas$name)]

# Convert activity labels to meaningful names
y$activity <- actividades[y$activity,]$name

# Merge partial data sets together
tidy.data.set <- cbind(subject, y, X)

# Dump the data set
write.csv(tidy.data.set, tidy.data.file)

# Compute the averages grouped by subject and activity
tidy.avgs.data.set <- aggregate(tidy.data.set[, 3:dim(tidy.data.set)[2]],
                                list(tidy.data.set$subject,
                                     tidy.data.set$activity),
                                mean)
names(tidy.avgs.data.set)[1:2] <- c('subject', 'activity')

# Dump the second data set
write.csv(tidy.avgs.data.set, tidy.avgs.data.file)
