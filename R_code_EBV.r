
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















