#Analysis on biomass changes in the Amazon forest
#R code to view the biomass around the world and calculate changes in ecosysyem funcitons
#Data based on Copernicus (European data) with the use of Sentinel 2 satellite
#Rasterdiv = diversity based on raster data
#DVI images to measure the RED and NIR --> index of vegetation
# DVI= NIR - R 

install.packages('rasterdiv')
install.packages('rasterVis')  #Vis = visualization

library(rasterdiv)
library(rasterVis)
data(copNDVI)


copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

 setwd("C:/lab/") 
 library(raster)
 defor1 <- brick("defor1_.jpg")
 defor2 <- brick("defor2_.jpg")
 
 #band1 : NIR
 #band2 : RED
 #band3 : GREEN

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2
#defor2
#band1 : NIR defor1_.1
#band2 : RED defor2_.2

dvi1 <- defor1$defor2_.1 - defor1$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi
















