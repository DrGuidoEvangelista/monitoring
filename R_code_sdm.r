#Species Distribution Modelling

install.packages("sdm")
library(sdm)
library(raster)
library(rgdal)   
file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file)
plot(species)
species #to see the characteristics

plot(species[species$Occurrence == 1,],col='blue',pch=16)  #the map shows us only the occurences (==1)
points(species[species$Occurrence == 0,],col='red',pch=16)  #function to add also the absence

path <- system.file("external", package="sdm")  #path towards the folder

lst <- list.files(path=path,pattern='asc$',full.names = T)  #lst means list and not land surface temperature
preds <- stack(lst)
preds #to see all the values
plot(preds)
#changing the colours 
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)  #relations of elevation with species
plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16) #relations of temperature with species
plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16) #relations of precipitation with species
plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16) #relations of vegetation with species

#model
d <- sdmData(train=species, predictors=preds)
d
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16) #plot of the probability of distribution of species in space

s1 <- stack(preds,p1)
plot(s1, col=cl)



































