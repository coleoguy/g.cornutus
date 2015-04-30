# This scripts processes data from measurements of body
# and horn length in Gnatocerus cornutus males, and determines
# which individuals should be selected as the high and low 
# line parents for each generation
# Athena Meyer
# Heath Blackmon
# coleoguy#gmail.com

# set wd to the main analysis scripts folder
setwd("~/Desktop/Copy/gitrepos/g.cornutus/analyses")

# load are local functions
source("../fnx/working.func.R")

# read in the data for the current generation
# the excel file should be edited so we have just 2 columns
# in the csv 1 = measurement and 2 = vial
raw.data <- read.csv("../data/stockP1.csv")

# reformat the data from the microscope
f.data <- FixData(raw.data)

# identify individuals with largest horn size
# corrected for body size
ResSel(data = f.data, 
       traits = c(3,2), 
       percent = 11, 
       identifier = 1, 
       model = "linear")

