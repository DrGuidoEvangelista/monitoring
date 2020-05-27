
#EVB = essential biodiversity variables
setwd("C:/lab/")
library(raster)

#now we will import the image sentinel dowloaded from iol 

snt <- brick("snt_r10.tif")   #function to brick the picture into R
snt # to see the details of the picture

plot(snt) #to see the 4 pictures in R; the colours are provided by R

#B1 blue
#B2 green
#B3 red
#B3 NIR

#b1 g2 r3
plotRGB(snt, 3, 2, 1, stretch="lin")   #real picture
plotRGB(snt, 4, 3, 2, stretch="lin")   #vegetation colored in red for NIR

pairs(snt)


#PCA analysis (Principal Component Analysis)
library(RStoolbox)   #we need this library for PCA analysis
sntpca <- rasterPCA(snt)
summary(sntpca$model)    #information about the sntpca 
#70% of information
plot(sntpca$map)     # to see the plot of the 4 different components 

plotRGB(sntpca$map,1,2,3, stretch="lin")   #kinda psychedelic but unlight the variability of the land

#set the moving window
window <- matrix(1, nrow = 5, ncol = 5)

#use focal function 
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
#let's change the colours
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100)
plot(sd_snt, col=cl)

#par() is used to put one image beside another 
par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")

#lesson 27/05 cladonya
# lichens are a measure of good air quality, if not present it means that the environment is polluted
# we will brick this image and calculate the variability in this image 

#brick function : improt several layers at the same time (raster import only 1 layer)
library(raster)
setwd("C:/lab/")
clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad,1,2,3, stretch="lin")  #to see the image in R
#let's build the window
window <- matrix(1, nrow=3, ncol=3)   #the number 1 is to set a number for the pixels but not impacting (arbitrary value)
window
library(RStoolbox)

#PCA Analysis
cladpca <- rasterPCA(clad)
cladpca
summary(cladpca$model)
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

#set the moving window
window <- matrix(1, nrow=3, ncol=3)   
window

sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)  #sd_clad = standard deviation clad

# par function = several graphs
#plot the calculation
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) 
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)
#with this graph we can see the standard gradation in the cladonya image
# plot the calculation
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot()
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)






















