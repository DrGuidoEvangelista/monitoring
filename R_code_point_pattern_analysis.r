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





















