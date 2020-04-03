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























