# Making simple maps

### In this tutorial you will make a two-panel plot. One panel of the map will be of Washington, Oregon, and Califnornia with some cities added. The second panel will show latitudinal ranges of some hypothetical.
<hr />

* Step 1: Set up pot


````r
# load required libraries
library(maps)
library(mapdata)

# read in data files
cities <- read.delim(file="https://raw.githubusercontent.com/naheim/rTutorials/master/dataFiles/westCoastCities.txt")
species <- read.delim(file="https://raw.githubusercontent.com/naheim/rTutorials/master/dataFiles/speciesRanges.txt")

# set up plot window
quartz(height=6, width=10) # open a new plot window and set the size (in inches)

layout(matrix(2:1, nrow=1, ncol=2), widths=c(0.65,0.35)) # this divides the plot window into two panels-one takes up 30% of window and the other 70%.
 
# set map plot region
lngRange <- c(-125.122705, -113.876853)
latRange <- c(32.45, 49.25)


# plot = FALSE saves the file, so we can set up our plot axes the way we want
# setting xlim and ylim limits the extnt of the map to the region we're interested in

# set up empty plot window
par(mar=c(4,0.2,0.2,4), las=1) # set margins (see ?par for explination) & rotate axis number to be in the most readable orientation
plot(1:10, type="n", xlim=lngRange, ylim=latRange, xlab="Longitude", ylab="", yaxt="n") # we are supressing the y-axis (yaxt) so we can put it on the right rather than the left
axis(side=4, at=pretty(latRange)) # add axis to right side
mtext("Longitude", side=4, line=2, las=0) # y-axis label

# add the map
map('worldHires', xlim=lngRange, ylim=latRange, fill=TRUE, col='gray', add=TRUE)

# add the cities
points(cities$lng, cities$lat, pch=8, col='red', cex=1.25)
text(cities$lng, cities$lat, labels=cities$

````