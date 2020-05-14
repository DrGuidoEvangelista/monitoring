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


























