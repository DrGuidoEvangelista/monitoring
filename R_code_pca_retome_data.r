setwd("C:/lab/")
install.packages("RStoolbox")
library(raster)
library(RStoolbox)
  
p224r63_2011_masked <- brick("p224r63_2011_masked.grd")   #Brick function


#Landsat 7 satellite 
#b1 blue
#b2 green 
#b3 red
#b4 NIR
#b5 SWIR
#b6 thermal infrared
#b7 SWIR
#b8 panchromatic

plotRGB(p224r63_2011_masked, r=5, g=4, b=3, stretch="Lin")

#let's use ggplot2
library(ggplot2)
ggRGB(p224r63_2011_masked,5,4,3)

#Do the same with 1988 image 
p224r63_1988_masked <- brick("p224r63_1988_masked.grd")   #Brick function
plotRGB(p224r63_1988_masked, r=5, g=4, b=3, stretch="Lin")

#Function to put the 2 pictures close to compare them
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

names(p224r63_2011_masked)
#to see how much the two variables are correlated
plot(p224r63_2011_masked$B1_sre, p224r63_2011_masked$B3_sre)

#PCA
#decrease the resolution 
p224r63_2011_res <- aggregate(p224r63_2011_masked, fact=10)

library(RStoolbox)
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
plot(p224r63_2011_pca$map)  #color ramp pictures
#let's change color ramp 

cl <- colorRampPalette(c("dark grey", "grey", "light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$mdoel)
pairs(p224r63_2011_masked)
plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

#1988
p224r63_1988_res <- aggregate(p224r63_1988_masked, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model)
pairs(p224r63_1988_masked) 

#difference



























