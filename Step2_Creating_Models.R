library(lattice)
library(plyr)
library(ggplot2)

#Import the data, set the factors properly (trick shown to me by Sean Jewell)
iDat <- read.delim("GapMinderData_Sorted_ExtraVariables.tsv")
id  <- unique(iDat$continent)
iDat  <- within(iDat, continent  <- factor(as.character(continent),levels = id))

#Investigating to make sure it worked out
levels(iDat$continent)
head(iDat)
tail(iDat)

#Finding fits and coefficients using code modified from JB's data aggregation lecture.
yearMin <- min(iDat$year)
jFun <- function(x) {
  fit  <- lm(lifeExp ~ I(year - yearMin), x)
  estimates <- append(coef(fit),summary(fit)$sigma)
  names(estimates) <- c("intercept", "slope","sd_resid")
  return(estimates)
}

jCoefs <- ddply(iDat, ~ country + continent, jFun)

#Define best as the countries with the lowest residual standard error, i.e. lowest sd_resid
jCoefs<- arrange(jCoefs,continent,sd_resid)

#Create a data fame containing the fit details.
jCoefs <- ddply(iDat, ~country+continent, jFun)
jCoefs  <- arrange(jCoefs,continent)
write.table(jCoefs, "GapMinder_LifeExp_LinearFitDetails.tsv", quote = FALSE, sep = "\t", row.names=FALSE)

#For each continent, find the 4 best and 4 worst fits.
ExtremeCountries  <- jCoefs[-length(jCoefs[,1]):-1,]
for(con in levels(jCoefs$continent)){
n  <- length(subset(jCoefs, continent ==con)[,1])
ExtremeCountries <- rbind(ExtremeCountries,subset(jCoefs, continent ==con)[-(n-4):-5,])
}
#Check it out.
ExtremeCountries

#Save the Data and Fits for the Extreme Countries
write.table(ExtremeCountries, "GapMinder_LifeExp_LinearFitExtremes.tsv", quote = FALSE, sep = "\t", row.names=FALSE)

#Merge with more information so that we can generate better plots.
ExtremeCountriesbyYear  <- merge(ExtremeCountries,subset(iDat, country %in% ExtremeCountries$country))
ExtremeCountriesbyYear  <- within(ExtremeCountriesbyYear, country <- reorder(country, sd_resid))

#A loop which creates the desired plots.
PreFilename  <- "Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in"
for(con in levels(ExtremeCountriesbyYear$continent)){
  title  <- paste(PreFilename,con,"pdf",sep=".")
  pdf(title)
print(xyplot(lifeExp ~ year|country, subset(ExtremeCountriesbyYear,continent==con), type = c("p", "r"),ylab="Life Expectancy", xlab= "Year",layout=c(4,2)))
  dev.off()
}
