#Analysis on changing of NO2 concentration in time after the spread of covid-19
#Donwload the EN zip file from iol and extract it into the lab foulder
#put the images into a new foulder called "NO2" inside lab

setwd("C:/lab/NO2/")

#function to see all 13 pictures on R (copyed from the snow code)
library(raster)
rlist <- list.files(pattern="EN")
rlist
#lapply function : applying to all the files of the list the raster function
import <- lapply(rlist, raster)
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN, col=cl)

#let's do a plot with only 2 images : the first and the last (january and march) with par function
#par creates a graph with row and colomns
dev.off() #to close the previous graphs
par(mfrow=c(1,2)) 
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#RGB space
plotRGB(EN, r=1, g=7, b=13, stretch="lin")  #matching the colours with the number of images, rgb= red green blue

#difference map
dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dif, col=cld)

#we have to find the mean of the date between the 13 images
#new function calle boxplot
#quantitative estimate
#taking all the data from the first image and all the data from the last picture
boxplot(EN)
boxplot(EN, outline=F)
#let's put the boxplot horizontally
boxplot(EN, outline=F, horizontal=T)
#and the axis
boxplot(EN, outline=F, horizontal=T, axes=T)  #final graph

#plot
plot(EN$EN_0001, EN$EN_0013)
abline(0,1, col="red")

setwd("C:/lab/snow/") 

# fast version of import and plot of many data for lazy people!
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

rlist <- list.files(pattern="snow20")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)
plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r) 
abline(0,1, col="red")
























