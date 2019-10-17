# Geographic Range Occupancy
more to come

```` r
library(geosphere)

# get Stenolaemata (Phylum: Bryozoa) occurrences from PBDB
steno <- read.delim("https://paleobiodb.org/data1.2/occs/list.tsv?&base_name=Stenolaemata&idreso=lump_genus&show=class,paleoloc")

# Timescale excluding Pleistocene and Holocene
timescale <- read.delim("https://paleobiodb.org/data1.2/intervals/list.tsv?scale_level=5&min_ma=2.588")

# generate data frame for genus-level infomation
# FAD, LAD, nPalocont, nOccur 

# calculate geographic range 
apply(coords, 1, distGeo, coords)


````