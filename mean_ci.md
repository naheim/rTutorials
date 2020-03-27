# Mean Body Size (or some other trait) and 95% confidence intervals

## Introduction


## Calculating Mean body Size 

This tutorial assums you understand what loops are and how to construct them to perform repetitive tasks, such as calculating mean size for nearly 100 time intervals. It is also expected that you undersand the logic for finding which genera are extant in each time interval based on stratigraphic ranges. If you are not familiar with loops or extracting extant taxa, you can learn about them (or remind yourself) [here](manipulatedf.md).

### Get the data

```` r
# Read in Heim et al. 2015 body size data from the web
sizeData <- read.delim(file='https://stacks.stanford.edu/file/druid:rf761bx8302/supplementary_data_file.txt')
head(sizeData) # it's always a good idea to look at you data to make sure it looks like you expect and to learn the relevant column names for analyses.

# Read in the timescale file
timescale <- read.delim(file='https://raw.githubusercontent.com/naheim/paleosizePaper/master/rawDataFiles/timescale.txt')
nBins <- nrow(timescale) # this is the number if time intervals and I find it convenient to calculate in here and use rBins rather than writing out nrow(timescale) everytime I need it.

````
### Set up variables & calculate values
Once you've read in your data files, you want to set up variables to store the results of your calculations. The thre are three quantities you want to keep track of: the number of genera, mean size of genera, and the standard deviation of size. You will want to calculate these variables in each 99 time inervals of ``timescale``. 

```` r
nGenera <- vector(mode="numeric", length=nBins) # a numeric vector to hold the number of genera extant in each time interval
meanGenera <- nGenera # same as above, note that because we haven't added any values, I can just copy the previously created vector--saves typing
sdGenera <- nGenera # a vector for standard deviation

# loop through each time interval to calculate important properties
for(i in 1:nBins) {
	#get extant taxa
	tempTaxa <- subset(sizeData, fad_age > timescale$age_top[i] & lad_age < timescale$age_bottom[i])
	
	# calculate quantities for extant taxa
	nGenera[i] <- nrow(tempTaxa)
	meanGenera[i] <- mean(tempTaxa$log10_volume)
	sdGenera[i] <- sd(tempTaxa$log10_volume)
	
}

````

### calculate confidence intervals & plot 

```` r
ci <- 1.96*sdGenera/(sqrt(nGenera-1))

par(las=1, pch=16, mar=c(5, 4.25, 4, 2) + 0.1) # set some plot parameters

plot(timescale$age_mid, meanGenera, type="o", xlim=c(541, 0), ylim=range(c(meanGenera+ci, meanGenera-ci)), xlab="Geological time (Ma)", ylab=expression(paste("Mean biovolume (log"[10]," mm"^3,")")))

segments(timescale$age_mid, meanGenera-ci, timescale$age_mid, meanGenera+ci)
````