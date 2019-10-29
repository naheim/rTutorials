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

