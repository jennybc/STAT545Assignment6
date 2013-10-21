#import necessary packages
library(lattice)
library(plyr)
library(ggplot2)

#read in the data
gDat <- read.delim("gapminderDataFiveYear.txt")
#Check structure
str(iDat)

#drop Oceania
iDat <- droplevels(subset(gDat, continent != "Oceania"))
#Check structure
str(iDat)

#check orderings
head(iDat)
levels(iDat$continent)

# want to adjust continent factor levels according to increasing mean life expectancy
#add new column indicating mean life expectancy by continent (the mean is weighted by population)
iDat  <- ddply(iDat,~continent,mutate, Continent_meanlifeExp = sum(pop*lifeExp)/sum(pop))

#recheck orderings
levels(iDat$continent)
head(levels(iDat$country))
head(iDat)
#I just discovered mutate, and it seems to re-order the data. 
#After adjusting the factor, I change to an ordering that makes more sense.

#First reassign the continent factors according to mean life expectancy by continent.
iDat  <- within(iDat, continent <- reorder(continent, Continent_meanlifeExp))

#recheck orderings
levels(iDat$continent)
head(levels(iDat$country))
head(iDat)

#now reorder the actual data, sorting the observations by the new continent factors
# I will use additional criteria in this sorting, that is, I want the countries to occur within each continent ascending by minimum (over all years) life expectancy
#for each country I want its observations to be sorted by year.

#determine min life expectancy to help with the sorting
iDat  <- ddply(iDat,~country,mutate, minLifeExp = min(lifeExp))

#investigate results
head(iDat)

#Arrange according to the criteria
iDat  <- arrange(iDat, continent,minLifeExp,year)

#investigate results
head(iDat)
tail(iDat)

#Rwanda worries me, it doesn't appear to achieve its minimum value
iDat[1:12,]
#Oh yes it does, just later than expected.

#A violin plot of life Expectancy across continents
pdf("GapMinder_LifeExpectancy_ViolinPlot_AcrossContinents.pdf")
print(bwplot(lifeExp~continent, iDat, panel = function(...){panel.violin(...,col = "grey")}, xlab = "Continent", ylab = "Life Expectancy"))
dev.off() 

#A plot illustrating how life Expectancy changes throughout the years.
pdf("GapMinder_LifeExpectancy_byYearandContinent_stripplot_noweightbypopulation.pdf")
print(ggplot(iDat, aes(x = year, y = lifeExp, colour = continent)) + geom_point()+facet_wrap(~continent) + geom_smooth(colour ="blue", method = "loess") +ylab("Life Expectancy")+xlab("Year"))
dev.off()

#The above plot does not capture the populations properly, which has been a theme of our work so far.
#The following plot does a better job of including population information
pdf("GapMinder_LifeExpectancy_byYearandContinent_stripplot_nomeanline.pdf")
print(ggplot(iDat, aes(x = year, y = lifeExp, colour = continent, size = sqrt(pop)))+facet_wrap(~continent) + geom_point()+ylab("Life Expectancy")+xlab("Year"))
dev.off()

#It would be nice to have a typical value of population for each year like the LOESS curve above. 
#This is possible, but requires an additional data aggregation step.
iDat  <- ddply(iDat, ~continent+year, mutate, meanlifeexpbyyear  = sum(pop*lifeExp)/sum(pop))
head(iDat)
#The mutation messes with the sorting again, so we have to reapply our sorting method
iDat  <- arrange(iDat, continent,minLifeExp,year)

#This plot looks good
pdf("GapMinder_LifeExpectancy_byYearandContinent_stripplot_final.pdf")
print(ggplot(iDat)+facet_wrap(~continent) + geom_point(aes(x = year, y = lifeExp, colour = continent, size = sqrt(pop)))+geom_line(data = iDat, aes(x = year, colour = "Mean", y = meanlifeexpbyyear))+ylab("Life Expectancy")+xlab("Year"))
dev.off()
#Time to save the files.
saveRDS(iDat, "GapMinderbyLifeExp.rds")

#In case the person using my file doesn't want the variables I added to sort with
iDat_without_additional_variables  <- subset(iDat, select = -c(minLifeExp,Continent_meanlifeExp,meanlifeexpbyyear) )
str(iDat_without_additional_variables)
saveRDS(iDat_without_additional_variables, "GapMinderbyLifeExpNoExtras.rds")


