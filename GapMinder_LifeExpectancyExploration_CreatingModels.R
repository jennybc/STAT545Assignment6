library(lattice)
library(plyr)
library(ggplot2)

iDat <- readRDS("GapMinderbyLifeExpnoExtras.rds")
levels(iDat$continent)
head(iDat)
tail(iDat)

#borrowed from data aggregation lecture

yearMin <- min(iDat$year)
jFun <- function(x) {
  fit  <- lm(lifeExp ~ I(year - yearMin), x)
  estimates <- append(coef(fit),summary(fit)$sigma)
  names(estimates) <- c("intercept", "slope","sd_resid")
  return(estimates)
}
## jFun(subset(iDat, country == 'India')) to see what it does
jCoefs <- ddply(iDat, ~country+continent, jFun)
saveRDS(jCoefs, "GapMinder_LifeExp_LinearFitDetails.rds")

#Define best as the countries with the lowest residual standard error, i.e. lowest sd_resid
jCoefs<- arrange(jCoefs,continent,sd_resid)

ExtremeCountries  <- jCoefs[-length(jCoefs[,1]):-1,]
for(con in levels(jCoefs$continent)){
n  <- length(subset(jCoefs, continent ==con)[,1])
ExtremeCountries <- rbind(ExtremeCountries,subset(jCoefs, continent ==con)[-(n-4):-5,])
}
ExtremeCountries
saveRDS(ExtremeCountries, "GapMinder_Extreme_LinearFits_forLifeExpectancy.rds")

ExtremeCountriesbyYear  <- merge(ExtremeCountries,subset(iDat, country %in% ExtremeCountries$country))
ExtremeCountriesbyYear  <- within(ExtremeCountriesbyYear, country <- reorder(country, sd_resid))

PreFilename  <- "Facetted Scatter Plot of Life Expectancy Versus Year for Extreme Countries in"
for(con in levels(ExtremeCountriesbyYear$continent)){
  title  <- paste(PreFilename,con,"pdf",sep=".")
  pdf(title)
xyplot(lifeExp ~ year|country, subset(ExtremeCountriesbyYear,continent==con), type = c("p", "r"),ylab="Life Expectancy", xlab= "Year",layout=c(4,2))
  dev.off()
}