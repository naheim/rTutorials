# Making simple maps

### In this tutorial you will make a two-panel plot. One panel of the map will be of Washington, Oregon, and Califnornia with some cities added. The second panel will show latitudinal ranges of some hypothetical.
<hr />

* Step 1: Set up pot


````r
# load required libraries
library(maps)
library(mapdata)

# read in data files
cities <- read.delim(file="dataFiles/westCoastCities.txt")
species <- read.delim(file="dataFiles/speciesRanges.txt")

````