# Rarefaction
The purpose of this tutorial is parctice using rarefaction


```` r
library(vegan) # package developed by plant ecologists

# get all Carboniferous brachiopods with abundance counts
ozarks <- read.delim(file="https://paleobiodb.org/data1.2/occs/list.tsv?base_name=Brachiopoda&interval=Carboniferous&show=loc,class,abund&abundance=count")

# limit to only those from Heim (2009), which are from the Ozarks (reference_id = 26838)
# separate into two data frame, one for the Chesterian (latest Mississippian) and one for the Morrowan (earliest Pennsylvanian)
chester <- droplevels(subset(ozarks, early_interval == 'Chesterian' & reference_no == 26838))
morrow <- droplevels(subset(ozarks, early_interval == 'Morrowan' & reference_no == 26838))

# use table to make a sample by taxon community matrix, then convert to a data frame
chesterComm <- as.data.frame.matrix(table(chester$collection_no, chester$accepted_name))
morrowComm <- as.data.frame.matrix(table(morrow$collection_no, morrow$accepted_name))


````

#### Exercise Questions 2
 1. How many genera are there in the Chesterian community matrix? How many in the Morrowan?
 2. How many collections/samples are there in the Chesterian community matrix? How many in the Morrowan?