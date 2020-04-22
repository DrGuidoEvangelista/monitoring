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












