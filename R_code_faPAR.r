  #How to look to chemical cycles by satellites
  library(raster)
  library(rasterVis)
  library(rasterdiv)
  
  plot(copNDVI)    #copernicus and NDVI
 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)
 
setwd("C:/lab/") 
faPAR10 <- raster("faPAR10.tif")
levelplot(faPAR10)

#to save the pic as a pdf - IMPORTANT
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

load("faPAR.RData")

#let's see the range of the faPAR data
ls()


#### regression model between faPAR and NDVI
erosion <- c(12,14,16,24,26,40,55,67)
hm <- c(30,100,150,200,260,340,460,600)   #ppm quantity of heavy metals

plot(erosion,hm,col ="red", pch= 19, xlab="Erosion", ylab="Heavy metals", cex=2)

model1 <- lm( hm ~ erosion)
summary(model1)
abline(model1)


setwd("C:/lab/") 
library(raster)
faPAR10 <- raster("faPAR10.tif")
plot(faPAR10)
library(rasterdiv)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

install.packages("sf")
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000)
copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)
plot(copNDVIp,faPAR10p)

#photosynthesis vs biomass
model2 <- lm(faPAR10p~copNDVIp)

plot(copNDVIp,faPAR10p,col="green")
abline(model2,col="red")

























