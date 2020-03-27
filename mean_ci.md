# Mean Body Size (or some other trait) and 95% confidence intervals

## Introduction


## Calculating Mean body Size 

This tutorial assums you understand what loops are and how to construct them to perform repetitive tasks, such as calculating mean size for nearly 100 time intervals. It is also expected that you undersand the logic for finding which genera are extant in each time interval based on stratigraphic ranges. If you are not familiar with loops or extracting extant taxa, you can learn about them (or remind yourself) [here](manipulatedf.md).

### Get the data

```` r
# Read in Heim et al. 2015 body size data from the web
sizeData <- read.delim(file='https://stacks.stanford.edu/file/druid:rf761bx8302/supplementary_data_file.txt')

# Read in the timescale file
timescale <- read.delim(file='https://raw.githubusercontent.com/naheim/paleosizePaper/master/rawDataFiles/timescale.txt')
nBins <- nrow(timescale) # this is the number if time intervals and I find it convenient to calculate in here and use rBins rather than writing out nrow(timescale) everytime I need it.

````
### Set up variables
Once you've read in your data files, you want to set up variables to store the results of your calculations. The thre are three quantities you want to keep track of: the number of genera, mean size of genera, and the standard deviation of size. You will want to calculate these variables in each 99 time inervals of ``timescale``. 

```` r

````