#Clear the system before running
#system("rm -f *.pdf *.tsv *.html ")

## JB: OK that command is legitimately terrifying. I will propose an 
## alternative. Frankly my alternative is not substantively different in its 
## effects but is R native, so is more portable, e.g. across OSes. I also build
## in an opportunity to inspect what's going to be deleted before we plunge in.

extsToDelete <- c("*.pdf", "*.tsv", "*.html")
outputs <- sapply(extsToDelete, function(x) list.files(pattern = x))
(outputs <- unlist(outputs)) # inspect to prevent disaster!
file.remove(outputs)

#Run both scripts
source("Step1_Data_Prep.R")
source("Step2_Creating_Models.R")

#Knit the scripts
library(knitr)
stitch_rhtml("Step1_Data_Prep.R")
stitch_rhtml("Step2_Creating_Models.R")
