#R_code_snow.r
setwd("C:/lab/")
#we will work on the filed downloaded on the 27/05 about snow coverage
#import the file and the library
library(raster)
install.packages("ncdf4")  
library(ncdf4)
#remember raster function is uploading 1 layer 
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")   #name of the image
#let's add a colour ramp palette to the picture
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

#Exercise : plot the snow cover with the colorRampPalette
plot(snowmay, col=cl)

#several layers at the time
#create a new folder into the lab folder (called it snow) and move the 5 files extracted (snow ones)
#slow manner to import the set
setwd("C:/lab/snow")

#import all the data
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

#to see images all together with the function par (multiframe)
par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)
#but this way is too long and boring 

#let's try another way without copying and pasting endless file names 
#find a common pattern (common letters between different files) of the files (like the name, the tif ecc..)
rlist <- list.files(pattern="snow20")
rlist
#lapply function : applying to all the files of the list the raster function
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)
plot(snow.multitemp, col=cl)

#let's make a prediction  (use the file prediction.r downloaded from iol)
source("prediction.r")

##############
#03/06 lecture
setwd("C:/lab/snow")

#Exercise : import the snow cover images all together
rlist <- list.files(pattern="snow20")
rlist
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)



#download the predicted snow date of 2025 based of the previous trends
#let's load the image
prediction <- raster("predicted2025r.tif")
plot(prediction, col=cl)

#export the output
#writeRaster is creating a data, not only exporting a graph
writeRaster(prediction, "final.tif")
final.stack <- stack(snow.multitemp, prediction)
plot(final.stack, col=cl)

# REMEMBER THESE FUNCTIONS 

# export the R file into a pdf file
pdf("snow_graph.pdf")
plot(final.stack, col=cl)
dev.off()

#export the R file into a png file
png("snow_graph.png")
plot(final.stack, col=cl)
dev.off()




























