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
In the above code we calculated the mean body size of fossil sampled from the fossil record. The key point here is that we have have sampled the fossil record--we have not measured every single fossil spcies, which in statistical terms is often called the population. So, Our assumption is that the sample can inform us about the mean size of fossil species in the total population. We could just assume that the sample mean is identical to the population mean, but that is unlikely. However, if we make a few assumptions about the distribution of body sizes in the population and that our sample is random, we can calculate a range of mean sizes that is likely to contain the population mean and we can assign a probability for how likely the population mean is to actually fall within that range.  This is the confidence interval. 

By convention, scientists typically calculate 95% confidence intervals, which means that we are 95% confident that the population mean lies within the defined range. If we assume that the population of body sizes is normally distributed, which is reasonable when sizes are log-transformed, then we can calculate the confidence interval as:<br/>
<br/>c.i. = x&#772; &plusmn; t<sup>&lowast;</sup> &#215; &sigma;<sub>x&#772;</sub>, 

where x&#772; is the sample mean, t<sup>&lowast;</sup> is the critical value of a t-distribution, and &sigma;<sub>x&#772;</sub> is the standard error of the sample. For a 95% confidence interval, t<sup>&lowast;</sup> = 1.96. &sigma;<sub>x&#772;</sub> = &sigma;/&radic;N, where &sigma; is the sample standard deviation and N is the sample size.

[Here](http://onlinestatbook.com/2/estimation/mean.html) is a more detailed explanation of how to calculate a confidence interval.

```` r
# calculate the conficence interval
ci <- 1.96*sdGenera/(sqrt(nGenera))

# finally let's make a plot
par(las=1, pch=16, mar=c(5, 4.25, 4, 2) + 0.1) # set some plot parameters

# plot the mean values, note that I set the y-limits using the total range of the confidence intervals so everyting will show up in the plot frame
plot(timescale$age_mid, meanGenera, type="o", xlim=c(541, 0), ylim=range(c(meanGenera+ci, meanGenera-ci)), xlab="Geological time (Ma)", ylab=expression(paste("Mean biovolume (log"[10]," mm"^3,")")))

# add the confidence intervals using the segments() function.
segments(timescale$age_mid, meanGenera-ci, timescale$age_mid, meanGenera+ci)
````