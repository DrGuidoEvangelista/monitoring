#Project


#First file downloaded from GloVis : analysis from 2017
#From June to August 2017

setwd("C:/lab/project/2017")
library(raster)
june2017 <- raster("L1C_T33TVF_A009943_20170518T095716.tif")  #to see the first picture
plot(june2017)  #default r colours
#let's stack together the 3 pictures (june-july-july2)
rlist <- list.files(pattern="L1C")
rlist
#lapply function : applying to all the files of the list the raster function
import <- lapply(rlist, raster)
L1C <- stack(import)
plotRGB(L1C, r=1, g=7, b=13, stretch="lin") 



#as the human eye see it (red-green-blue)
plotRGB(june2017,4,3,2, stretch="lin")


#zoom the picture 
#use this zoom for every picture
plot(june2017)
ext <- c(445000,460000, 4510000, 4525000)  #to zoom the picture at a certain latitude and longitude
zoom2017<- zoom(june2017, ext=ext)
plotRGB(zoom2017,4,3,2, stretch="lin")  #not working 

cl <- colorRampPalette(c("green","yellow","red"))(100)
plot(zoom2017, col=cl)



