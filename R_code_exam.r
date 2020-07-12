#R code exam
1 R code first
2 R codespatial
3 Multipanel
4 Point pattern analysis
5 Multivariate analysis
6 Remote sensing data analysis    
7 Ecosystem functions
8 PCA remote data    
9 faPAR     
10 Radiance
11 Essential Biodiversity Variables (EBV)
12 Cladonya analysis
13 Snow cover
14 NO2 concentration
15 Zoom on snow cover   
16 Temperature interpolation
17 Species Distribution Modelling (SDM)
18 Project
##############################

1 #R code first
install.packages("sp")

library(sp)
data(meuse)
#to enter a comment
meuse
#let's look at the first row of the set
head(meuse)
#let's plot two variables if is there a correlation between the two events
#let's see if is there a connection between the zin concentration and the copper
#to attach the dataset write "attach"
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="pink")
#pch to use a simbol in the graph
plot(zinc,copper,col="purple",pch=19)
#cex is for the form of the points bigger or smaller
plot(zinc,copper,col="purple",pch=19,cex=2)

#####################################
2 Spatial R
# R code for spatial view of points
install.packages("sp")
library(sp)

data(meuse)

head(meuse)

#coordinates
coordinates(meuse) = ~x+y
plot(meuse)

spplot(meuse,"zinc")

spplot(meuse,"cadmium")

#Exercise : plot the spatial amount of copper
spplot(meuse, "copper",main="copper concentration")

#bubble are big if the parameter of zinc or whatever is big
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="zinc concentration")

#exercise : bubble copper in read

bubble(meuse,"copper",main="copper concentration", col="red")


#importing new data downloaded from iol and put it in a folder called lab in :C 
#setting the working directory: lab
#Windows users
setwd("C:/lab")

#now we can import data

#name of the dataset = covid
#heat =T means true,correct way to see the data --> you can notice that in the first line there are no datas
covid <- read.table("covid_agg.csv", head=T
head(covid)

attach(covid)
plot(country,cases)

plot(country,cases, las=0) #parallel labels
plot(country,cases, las=1) #orizzontal labels
plot(country,cases, las=2) #perpendicular labels
plot(country,cases, las=3) #vertical labels
plot(country,cases, las=3, cex.axis=0.5)  #cex = exagerating

#ggplot2 package
install.packages("ggplot2")
library(ggplot2)  #require(ggplot2) 

# type q() to save the data and close

setwd("C:/lab/")
                    
load("spatial.RData")             

ls()
#covid

                    
library(ggplot2)               
data(mpg)
head(mpg)
# key components : data, aesthetic, geometry
ggplot(mpg, aes(x = displ, y=hwy)) + geom_point()

ggplot(mpg, aes(x = displ, y=hwy)) + geom_line()

ggplot(mpg, aes(x=displ,y=hwy)) + geom_polygon()

head(covid)
ggplot(covid,aes( x= lon, y=lat, size=cases)) + geom_point()

#######################################

3 Multipanel
# Multipanel in R 
install.packages("sp")
#I will install new packages found on the web
                    
#the softwer R will distinguish between normal and capital letters
install.packages("GGally")
library(GGally)
library(sp) #require(sp) will also do the job
data(meuse) #there is a dataset available named meuse
attach(meuse)
                    
#Exercise : see the names of the variables and plot cadmius vs zinc
#there are 2 ways to know the names of the database:
#name(meuse) and head(meuse) 
plot(cadmium,zinc,pch=12,col=red)
pairs(meuse) #to see the group of graphs
pairs(~ cadmium + copper + zinc + lead, data=meuse) #to see another group of graphs
pairs(meuse[,3:6]) #other manner to see the graphs of the dataset we used before
#exercise : prettify with the graph
pairs(meuse[,3:6,col="purple",pch=14, cex=2])
#not working close the quadratic paranthesis
pairs(meuse[,3:6],col="purple",pch=14, cex=2)

#GGallypackage will prettify the graph
ggpairs(meuse[,3:6])

                    
############################
4 Point pattern analysis
# Point Pattern Analysis : density map

insall.packages("spatstat")

library(spatstat)

attach(covid)
head(covid)
covids <- ppp( lon, lat, c(-180,180), c(-90,90))
#without attaching the covid set

d <- density(covids)
plot(d)
points(covids)

#continue
load("pj.RData")
ls()
library(spatstat)
# d = density map used last time
plot(d)
points(covids)

#dowloaded the coastlines files from iol and extracted with winrar into the lab foalder

install.packages("rgdal")
library(rgdal)
#let's put vector lines (x0y0, x1y1, x2y2..)
#.shp = shape file extension 
coastlines <- readOGR("ne_10m_coastline.shp")
#add means to add something from the previous image
#to see how much are dense this points in space
#important to see how much samples are present in a place and how they change in time

plot(d)
points(covids)
plot(coastlines, add=T)

#let's change the colours of the map to see the hotspots in red 
# the argoument (100) to see 100 of colour shapes, number of discrete colours
cl <- colorRampPalette(c("yellow","orange","red"))(100)
plot(d, col=cl)
points(covids)
plot(coastlines, add=T)

#Exercise : new colour ramp palette
cp <- colorRampPalette(c("white","pink","red"))(100)
plot(d, col=cp)
points(covids)
plot(coastlines, add=T)
#to add the title to the graph add main="Densities of covid-19" and add to the plot function plot(d, col=cp)
#so this is gonna be the new function
plot(d, col=cp, main="Densities of covid-19")

cp <- colorRampPalette(c("yellow","green","purple"))(200)
plot(d, col=cp, main="Densities of covid-19")
points(covids)
plot(coastlines, add=T)

#let's see how to export the map as a pdf and maybe put it into another file or document like the thesis 
pdf("covid_density.pdf")
cp <- colorRampPalette(c("yellow","green","purple"))(200)
plot(d, col=cp, main="Densities of covid-19")
points(covids)
plot(coastlines, add=T)
dev.off()

#the same way to have a png image
png("covid_density.png")
clr <- colorRampPalette(c("light green", "yellow","orange","violet")) (100)
plot(d, col=clr, main="Densities of covid-19")
points(covids)
plot(coastlines, add=T)
dev.off()

########################

5 Multivariate analysis
# R code for multivariate analysis 

setwd("C:/lab")
library(vegan)

biomes

biomes <- read.table("biomes.csv", header= T, sep= ",")
head(biomes_types)
head( biomes)  #View biomes

#Decorana = DEtrended CORrenspondence ANAlysis
multivar <- decorana(biomes)

biomes_types <- read.table("biomes_types.csv", header= T, sep= ",")
head(biomes_types)
attach(biomes_types)
ordiellipse(multivar, type, col= 1:4, kind= "ehull", lwd=3)
#colour col= c("blue", "green", ...)

ordispider(multivar, type, col=1:4, label = T)
                    
##############################
                    
6 Remote sensing data analysis  
#R code for remote sensing data analysis
# raster
setwd("C:/lab")
install.packages("raster")
library(raster)
#grd means grid
#brick imports 
#p means path and r road
brick("p224r63_2011_masked.grd") 
p224r63_2011_masked <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
# bands of Landsat
# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir) 
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared

#now we will change colour to the pictures

cl <- colorRampPalette(c("black","grey","blue"))(100)
plot(p224r63_2011, col=cl)

#multiframe of different plots
# $ to link different parts, here linking the band to the images
par(mfrow = c(2,2))
# B1 : blue
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(p224r63_2011$B1_sre, col=clb)
#colours() to see all codes of the colours in R

#Exercise: do the same for the green band B2_sre
#B2: green
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)

#B3: red
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)


#B4: nir
cln <- colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=cln)


par(mfrow = c(4,2))
# B1 : blue
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(p224r63_2011$B1_sre, col=clb)
#colours() to see all codes of the colours in R

#Exercise do the same for the green band B2_sre
#B2: green
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)

#B3: red
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)


#B4: nir
cln <- colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=cln)

#plotRGB
#stretch = to stretch the colour
#respecting the band of Landset used before, Lin means linear
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch ="Lin")

#we can only use three bands at the time so to add the infra red we have to eliminate one colour, let's remove the blue
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch ="Lin")
#plants are reflecting a lot of infra red radiation
#the infra red images show the vegetation in red

#Exercise put the NIR on top of the green component
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch ="Lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch ="Lin")

#24/04 lesson
setwd("C:/lab")
load("rs.RData")
ls()

#we will use data from 1988 for multiparate analysis #brick means importing
library(raster)
p224r63_1988 <-brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#compare both images from 1988 and 2011
par(nfor=c(2,1))
#plotRGB
# bands of Landsat
# B1: blue
# B2: green
# B3: red
# B4: NIR
#RGB means the 3 colours of the pc: red, green and blue
p224r63_2011 <- brick("p224r63_2011_masked.grd")
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch= "Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch= "Lin")

#Exercise plot in false colour RGB 432 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch= "Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch= "Lin")
#so easy to notice the difference in time with the false colour function 
#how much agricultural expanded during the years between 1988 and 2011

#enhance the noise
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch= "hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch= "hist")
#hist is a function that stretches the colours and underlight the "noise" and the humidity 

#value 50= healthy vegetation  10= dying vegetation 

#plotRGB
# bands of Landsat
# B1: blue
# B2: green
# B3: red  B3_sre
# B4: NIR  B4_sre

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c("darkorchid3","lightblue","lightpink4"))(100)
plot(dvi2011, col=cl)

#Exercise : dvi for 1988

dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c("darkorchid3","lightblue","lightpink4"))(100)
plot(dvi1988, col=cl)

#differences from one year to another
diff <- dvi2011 - dvi1988
plot(diff)

#let's change the grain of images
#lower the dimensions of picture, lower will be the capability to see the single objects -> we need high resolution images!
#res means resampling

p224r63_2011res <- aggregate(p224r63_2011,fact=10)
p224r63_2011res100 <- aggregate(p224r63_2011,fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch= "Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch= "Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch= "Lin") 
                    
#######################
                    
7 Ecosystem functions     
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

difdvi <- dvi1 - dvi2

cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

hist(difdvi)
                    
######################

8 PCA remote data                    
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


#############################
                    
9 faPAR
                    
                    
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
                    
########################
                    
10 Radiance 
                    
                    
# R_code_radiance.r

library(raster)
# we will invent the data so we won't set the working directory

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.55, 1.44, 2.45, 1.76)

toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)

toy4bits <- stretch(toy,minv=0,maxv=15) 
storage.mode(toy4bits[]) = "integer"    
plot(toy4bits)
text(toy4bits, digits=2)

toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)
                    
#########################
                    
11 Essential Biodiversity Variables (EBV)
                    
                    
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

                    
##########################
                    
12 Cladonya analysis
                    

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
                    
##########################
                    
13 Snow cover
                    
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
                    
######################
                    
14 NO2 concentration
                    
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
                    
############################
                    
15 Zoom on snow cover
                    
setwd("C:/lab")
library(raster)
library(ncdf4)
snow <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow, col=cl)

ext <- c(0, 20, 35, 50)  #to zoom the picture at a certain latitude and longitude
zoom(snow, ext=ext)  #italy zoom

dev.off()

#let's crop the image with the crop function instead of zoom
snowitaly <- crop(snow, ext)
plot(snowitaly, col=cl)
                    
############################
                    
16 Temperature interpolation 
                    
setwd("C:/lab/")
install.packages("spatstat")
library(spatstat)

#fagus sylvatica forest= extremely high canopy cover (very shady environment)
inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)
attach(inp) #R now knows we're working with  this dataset so we don't need $ simbol to work with different part of the dataset
#dataset was prevously restricted to the North-East area to better realise the interpolation
plot(X,Y)
summary(inp)
#ppp = planar point pattern function
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))  #rectangle

#marks function
names(inp) #to see the names to use in the next funcion
marks(inppp) <- Canopy.cov
canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green")  #we will see the values of density

#example with the cover of lichens on the trees, the name is show with the previous function names(inp)
# remember: the higher is the amount of lichens the higher is air quality
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)
#to see both maps together
#the graph will show that there is no congruence between lichens and canopy cover
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
#spatial correlations among different data
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, pch=19, col="red", cex=2) 

#Analysis on the file "dati_psammofile.csv" on Psammophilous vegetation
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psam)
head(inp.psam)  #coordinates
plot(E,N) #east and north coordinates, we see that the density is different from place to place
summary(inp.psam)  #to see the range 
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
#C_org = organic carbon into the top part of soil
marks(inp.psam.ppp) <- C_org

#Kandinsky alike map
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)   
                    
################
                    
17 Species Distribution Modelling (SDM)

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

                    
