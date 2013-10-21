#Clear the system before running
system("rm -f *.pdf *.tsv")

#Run both scripts
source("Step1_Data_Prep.R")
source("Step2_Creating_Models.R")

#Knit the scripts
library(knitr)
stitch_rhtml("Step1_Data_Prep.R")
stitch_rhtml("Step2_Creating_Models.R")