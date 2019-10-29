# Spindle Diagrams of Diversity Over Time
Here is a function that takes a time series of richness values for a set of taxa, and plots them as spindle diagrams. 

### The Function
You can load the function directly from GitHub ([fxn goes here]()) or you can paste it into your code from below.

```` r 
spindle.diagram <- function(diversity, timescale, boundaries=NA, yLabShift=1.00, file.name="spindle.pdf", label.cex=0.5) {
	#convert 0 to NA
	diversity[diversity == 0] <- NA
	# get scales for axes--all diagrams will be on same scale
	divRange <- range(c(0 - diversity/2, 0 + diversity/2), na.rm=TRUE)
	divRange <- divRange + c(-1,1)*diff(divRange)*0.03
	timeRange <- rev(range(c(timescale$min_ma, timescale$max_ma)))
	
	# setup plot layout with more columns than rows
	mfrow <- sort(n2mfrow(ncol(diversity)))	
	pdf(file=file.name, height=2*mfrow[1], width=mfrow[2])
	par(mfrow=mfrow, las=1, mar=c(4.5,4.25,2,0), cex.main=label.cex, font.main=2, xpd=TRUE)
	for(i in 1:ncol(diversity)) {
		# set up rectangle corners
		x1 <- 0 - diversity[,i]/2
		y1 <- timescale$max_ma
		x2 <- 0 + diversity[,i]/2
		y2 <- timescale$min_ma
		# initialize plot
		plot(1:10, type="n", xlim=divRange, ylim=timeRange, xlab='', ylab='', axes=FALSE, main=colnames(diversity)[i])
		
		# set up x-axis
		if(i == (mfrow[1]-1) * mfrow[2] + 1) {
			# find scale, ~ 20 % of diversity
			possibleScales <- 0:floor(max(diversity, na.rm=TRUE)*.2)
			if(length(which(possibleScales %% 10 == 0)) > 1) {
				maxScale <- possibleScales[max(which(possibleScales %% 10 == 0))]
			} else {
				maxScale <- possibleScales[max(which(possibleScales %% 2 == 0))]
			}
			
			# scale axis with ticks
			axis(side=1, at=c(0,maxScale), labels=NA, line=2.5)
			
			# axis label
			corners = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
			par(xpd = TRUE) #Draw outside plot area
			mtext(paste(maxScale, "genera", sep=" "), side=1, line=1, cex=0.75)
		}
		# set up y-axis
		if(i %% mfrow[2] == 1) {
			# axis with ticks
			axis(side=2, at=pretty(timeRange))
			
			# axis label
			corners = par("usr") #Gets the four corners of plot area (x1, x2, y1, y2)
			par(xpd = TRUE) #Draw outside plot area
			text(x = corners[1] - abs(diff(corners[1:2]))*yLabShift, y = mean(corners[3:4]), "Time (Ma)", srt = 90)
		}
		# add horizontal lines at specified time points
		if(!is.na(boundaries)) {
			if(i %% mfrow[2] == 1) {
				par(xpd = FALSE)
			}
			abline(h=boundaries)
		}
		rect(x1, y1, x2, y2, col="black", main=colnames(diversity)[i])
	}
	dev.off()
}
````


### Here's an example of it's use with a bryozoan download from the PBDB.
This example will save a pdf to your working directory

```` r
# SET YOUR WORKING DIRECTORY

# load the function
source("https://raw.githubusercontent.com/naheim/rTutorials/master/scripts/spindleFxn.r")

x <- read.delim(file="https://paleobiodb.org/data1.2/occs/list.tsv?base_name=Stenolaemata&idreso=lump_genus&show=paleoloc,class")
x$family[x$family==''] <- 'NO_FAMILY_SPECIFIED'
x <- droplevels(x)
tsMin <- min(x$min_ma)
tsMax <- max(x$max_ma)
timescale <- read.delim(file=paste("https://paleobiodb.org/data1.2/intervals/list.tsv?scale_level=5&min_ma=",tsMin,"&max_ma=",tsMax, sep=""))
nBins <- nrow(timescale)

fad <- tapply(x$max_ma, x$accepted_name, max)
lad <- tapply(x$min_ma, x$accepted_name, min)
genera <- data.frame('genus'=names(fad), fam=factor(tapply(x$family, x$accepted_name, function(x){return(as.character(x[1]))})), fad, lad)

fam <- levels(x$family)
diversity <- data.frame(matrix(NA, nrow=nBins, ncol=length(fam), dimnames=list(timescale$interval_name, fam)))

for(i in 1:nBins) {
	temp <- genera[genera$fad > timescale$min_ma[i] & genera$lad < timescale$max_ma[i],]
	diversity[i,] <- as.numeric(table(temp$fam))
}

spindle.diagram(diversity, timescale, boundaries=c(252.17, 66))
````

