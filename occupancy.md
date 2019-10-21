# Geographic Range Occupancy
The purpose of this tutorial is to demonstrate the calculation of geographic occupancy, as presented in [Foote et al. (2007)](http://doi.org/10.1126/science.1146303). Geographic occupancy describes history of geographic range size for a taxon, such as the genus *Gryphea*. By calculating the occupancy for many taxa, we can then start to make statistical comments about the temporal trajectories of taxa with respect to geographic rage. below is a figure from Foote et al. (2007) that show exemplar occupancy curves for several species of Cenozoic mollusks from New Zealand.

![Fig 1 Foote *et al.* (2007)](Foote07Fig1.jpg)
*"Empirical occupancy histories of Cenozoic molluscan species of New Zealand. Species are keyed to table S1; for example, species number 16 in table S1 is in row 1, column 6 in this figure. Durations are scaled to unit length from the base of the stage of first appearance to the top of the stage of last appearance, with the given numerical ages in millions of years ago (Ma) based on (27). Each occupancy history is scaled to its maximum. Species showing a relatively short-lived peak in occupancy away from the endpoints of the stratigraphic range are shaded."* Foote et al. (2007)

In this example, 130 species occupancy curves are given. Notice that the curves take a variety of shapes. Also notice that the width and maximum height of each curve are the same. This is because each curve is scaled to the maximum occupancy on the y-axis and to unit-length on the x-axis. In essence, both axes were converted to percentages. This scaling is crucial for being able to statistically aggregate the occupancy curves. 

After computing and scaling individual occupancy curves, we can then generate an average occupancy curve. This is done simply by summing the individual curves and dividing by the number of curves. Below are the average genus and species occupancy curves for Cenozoic Mollusks of New Zealand. Note that 1) the average curves have been smoothed and 2) that both genera and species tend to have their maximum geographic range near the middle of their durations.

![Fig 2 Foote *et al.* (2007)](Foote07Fig2.jpg)
*"Average occupancy history of Cenozoic molluscan species (thick curves) and genera (thin curves) of New Zealand, with durations scaled to unit length from the base of the stage of first appearance to the top of the stage of last appearance (27). The solid curves are the smoothed averages of the level of occupancy of all taxa at 100 evenly spaced, interpolated points between the times of first and last appearance (SOM). Dashed curves show 1 SE on either side of the average, as estimated from a bootstrap resampling procedure (SOM). The horizontal lines show the overall mean occupancy of all taxa over time."* Foote et al. (2007)


## Using the PBDB to calculate geographic range occupancy for Stenolaemata (Phylum: Bryozoa)

Before beginning our analysis, it's important to select the measure of geographic range. In paleobiological studies, there are number of commonly used metrics. Here we will use two to calculate two occupancy curves. The two metrics are maximum great circle distance and the number of occupied tectonic blocks.

**Maximum Great Circle Distance** Great circle distance is the shortest distance between two points on the surface of the sphere. For each genus in each stage, we will fine the maximum great distance between all pairs of occurrences. We will do this using the ``geosphere`` library, which assumes the spehere is the size of the Earth and returns distances in uits of kilometers. We will, of course, use paleocoordinates by adding ``&show=paleoloc`` to the API call. 

**Number of Tectonic Blocks** The Earth's lithosphere is divided into a series of tectonic blocks that move relative to each other over geological time, though some are now sutured to other blocks and move as single larger blocks. The PBDB, 


```` r
library(geosphere)

# get Stenolaemata occurrences from PBDB
steno <- read.delim("https://paleobiodb.org/data1.2/occs/list.tsv?&base_name=Stenolaemata&idreso=lump_genus&show=class,paleoloc")

# Timescale excluding Pleistocene and Holocene
timescale <- read.delim("https://paleobiodb.org/data1.2/intervals/list.tsv?scale_level=5&min_ma=2.588")

# generate data frame for genus-level infomation
# FAD, LAD, nPalocont, nOccur 

# calculate geographic range 
apply(coords, 1, distGeo, coords)


````