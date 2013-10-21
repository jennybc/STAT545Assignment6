STAT545 Assignment 6 Neil Spencer 82441160
==================

This is my final assignment for STAT 545, Exploratory Data Analysis, taught by Dr. Jenny Bryan at University of British Columbia. A description of the tasks for this assignment can be found [here](http://www.stat.ubc.ca/~jenny/STAT545A/hw06_puttingAllTogether.html). 

I have chosen to work with the gapminder data set. To add a little bit of an extra challenge, I chose to sort the continents based on average life expectancy for each continent (where the average life expectancy is weighted by population of the country). My data aggregation code, which uses the [plyr](http://plyr.had.co.nz/) function "mutate", looks simple. However, it actually took me quite a bit of time to develop this code. Discovering "mutate" made things a lot easier, even though it messes with the ordering of the data.

I have to thank Sean Jewell for helping me to get set up SourceTree. His suggestions were very helpful for putting this together.

The following four files make up the pipeline of my data analysis:

[Master_Script.R](https://github.com/neilspencer/STAT545Assignment6/blob/master/Master_Script.R)

[Step1_Data_Prep.R](https://github.com/neilspencer/STAT545Assignment6/blob/master/Step1_Data_Prep.R)

[Step2_Creating_Models.R](https://github.com/neilspencer/STAT545Assignment6/blob/master/Step2_Creating_Models.R)

[gapminderDataFiveYear.txt](https://github.com/neilspencer/STAT545Assignment6/blob/master/gapminderDataFiveYear.txt)

The master script sources the Step1 and Step2 R scripts, which complete the analysis. Step1 references the gapminderDataFiveYear, while Step2 references output of Step1. The master script also creates html files of Step1 and Step2. 

Note that (for convenience) the master script contains a commented out line which cleans the outputs of Step1 and Step2 out of the directory. It takes the approach of deleting all html and pdf files. I commented it out because I was worried that this might lead to unintended consequences on your end.

Below are the output files that can be obtained by an R CMD BATCH of the Master_Script.

[Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in.Africa.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Facetted%20Scatter%20Plot%20of%20Life%20Expectancy%20Versus%20Year%20for%20Extreme%20Countries%20in.Africa.pdf)

[Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in.Americas.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Facetted%20Scatter%20Plot%20of%20Life%20Expectancy%20Versus%20Year%20for%20Extreme%20Countries%20in.Americas.pdf)

[Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in.Asia.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Facetted%20Scatter%20Plot%20of%20Life%20Expectancy%20Versus%20Year%20for%20Extreme%20Countries%20in.Asia.pdf)

[Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in.Europe.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Facetted%20Scatter%20Plot%20of%20Life%20Expectancy%20Versus%20Year%20for%20Extreme%20Countries%20in.Europe.pdf)

[GapMinderData_Sorted_ExtraVariables.tsv](https://github.com/neilspencer/STAT545Assignment6/blob/master/GapMinderData_Sorted_ExtraVariables.tsv)

[GapMinderData_Sorted_Minimal.tsv](https://github.com/neilspencer/STAT545Assignment6/blob/master/GapMinderData_Sorted_Minimal.tsv)

[GapMinder_LifeExp_LinearFitDetails.tsv](https://github.com/neilspencer/STAT545Assignment6/blob/master/GapMinder_LifeExp_LinearFitDetails.tsv)

[GapMinder_LifeExp_LinearFitExtremes.tsv](https://github.com/neilspencer/STAT545Assignment6/blob/master/GapMinder_LifeExp_LinearFitExtremes.tsv)

[Step1_Data_Prep.html](https://github.com/neilspencer/STAT545Assignment6/blob/master/Step1_Data_Prep.html)

[Step2_Creating_Models.html](https://github.com/neilspencer/STAT545Assignment6/blob/master/Step2_Creating_Models.html)

[Strip_plot_LifeExp_final.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Strip_plot_LifeExp_final.pdf)

[Strip_plot_LifeExp_nomeanline.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Strip_plot_LifeExp_nomeanline.pdf)

[Strip_plot_LifeExp_noweights.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Strip_plot_LifeExp_noweights.pdf)

[Violin_Plot_LifeExp.pdf](https://github.com/neilspencer/STAT545Assignment6/blob/master/Violin_Plot_LifeExp.pdf)

