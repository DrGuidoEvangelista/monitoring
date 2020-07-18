#Project            
                                                          
                                     
#2017 situation                    
                   
######## MAY 2017 #############

#May 2017 situation: the vegetation cover is normal
setwd("C:/lab/project")
library(raster)                   
rlist20170518 <- list.files(pattern="T33TVF_20170518")
rlist20170518
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#B11 (SWIR) -> band 5  (20 m)
#lapply function : applying to all the files of the list the raster function
import20170518 <- lapply(rlist20170518, raster)

#We cannot make the analysis if the resolution is different between the bands
#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20170518 <- resample(import20170518[[1]], import20170518[[5]])  
B03_green_20170518 <- resample(import20170518[[2]], import20170518[[5]])  
B04_red_20170518 <- resample(import20170518[[3]], import20170518[[5]]) 
B08_nir_20170518 <- resample(import20170518[[4]], import20170518[[5]])
B11_swir_20170518 <-import20170518[[5]]
#resample worked!

may17 <- stack(B02_blue_20170518 , B03_green_20170518, B04_red_20170518, B08_nir_20170518, B11_swir_20170518)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude to unlight the Vesuvius                 
ves20170517 <- crop(may17, ext)  
#ves20170517 zoom of the park from 05 May 2017, two months before the fires
plotRGB(ves20170517, r=3, g=2, b=1, stretch="lin")    #showing the park in human eye colors            

#Near Infra Red analysis
plotRGB(ves20170517, r=4, g=3, b=2, stretch="lin") #the vegetation is shown in red 

#####  JULY 2017   ########  
                 
#Let's add the data from July 2017 when the fires started                  
rlist20170707 <- list.files(pattern="T33TVF_20170707")
rlist20170707 #to check if the list is correct
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#B11 (SWIR) -> band 5  (20 m)
#lapply function : applying to all the files of the list the raster function
import20170707 <- lapply(rlist20170707, raster)

#We cannot make the analysis if the resolution is different between the bands
#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20170707 <- resample(import20170707[[1]], import20170707[[5]])  
B03_green_20170707 <- resample(import20170707[[2]], import20170707[[5]])  
B04_red_20170707 <- resample(import20170707[[3]], import20170707[[5]]) 
B08_nir_20170707 <- resample(import20170707[[4]], import20170707[[5]])
B11_swir_20170707 <-import20170707[[5]]
#resample worked!

july17 <- stack(B02_blue_20170707, B03_green_20170707, B04_red_20170707, B08_nir_20170707, B11_swir_20170707)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude                 
ves20170707 <- crop(july17, ext)  
#ves20170707 zoom of the park from 07 July 2017, when the area started to burn
plotRGB(ves20170707, r=3, g=2, b=1, stretch="lin")
#NIR 
plotRGB(ves20170707, r=4, g=3, b=2, stretch="lin")  #vegetation in red


########## AUGUST 2017 ############

rlist20170806 <- list.files(pattern="T33TVF_20170806")
rlist20170806 #to check the new disposition of the bands (all 10 m except from SWIR)
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#B11 (SWIR) -> band 5  (20 m)
#lapply function : applying to all the files of the list the raster function
import20170806 <- lapply(rlist20170806, raster)

#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20170806 <- resample(import20170806[[1]], import20170806[[5]])  
B03_green_20170806 <- resample(import20170806[[2]], import20170806[[5]])  
B04_red_20170806 <- resample(import20170806[[3]], import20170806[[5]]) 
B08_nir_20170806 <- resample(import20170806[[4]], import20170806[[5]])
B11_swir_20170806 <-import20170806[[5]]  
#resample worked!

august17 <- stack(B02_blue_20170806, B03_green_20170806, B04_red_20170806, B08_nir_20170806, B11_swir_20170806)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude                 
ves20170806 <- crop(august17, ext)

#Now all 20 m resolution
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#B11 (SWIR) -> band 5   

#ves20170806 zoom of the park from the 08 August 2017
plotRGB(ves20170806, r=3, g=2, b=1, stretch="lin", main="06/08/2017", scale= "1000", axes = TRUE)  #human eye  
#NIR 
plotRGB(ves20170806, r=4, g=3, b=2, stretch="lin", main="06/08/2017", scale= "1000", axes = TRUE)  #vegetation in red
#Highlight the burnt area (SWIR-NIR-red)
plotRGB(ves20170806, r=5, g=4, b=3, stretch="lin", main="06/08/2017", scale= "1000", axes = TRUE)  #vegetation in green while the burnt area has natural colors

#Analysis of 2017 

#Comparing the months of May,July and August
#Human eye analysis
par(mfrow=c(1,3)) 
plotRGB(ves20170517, r=3, g=2, b=1, stretch="lin", main="05/17/2017", scale="1000", axes= TRUE) #may
plotRGB(ves20170707, r=3, g=2, b=1, stretch="lin", main="07/07/2017", scale="1000", axes= TRUE) #july
plotRGB(ves20170806, r=3, g=2, b=1, stretch="lin", main="06/08/2017", scale= "1000", axes = TRUE)  #august

#NIR analysis : vegetation in red
#We can notice how much vegetation was lost
par(mfrow=c(1,3)) 
plotRGB(ves20170517, r=4, g=3, b=2, stretch="lin", main="05/17/2017", scale= "1000", axes = TRUE)  #vegetation in red
plotRGB(ves20170707, r=4, g=3, b=2, stretch="lin", main="07/07/2017", scale= "1000", axes = TRUE)  #vegetation in red
plotRGB(ves20170806, r=4, g=3, b=2, stretch="lin", main="06/08/2017", scale= "1000", axes = TRUE)  #vegetation in red

#Comparing the burnt area of July (start of the fires) and August 2017
#Burnt area analysis: vegetation in green while the burnt area has natural colors
par(mfrow=c(1,2))                                
plotRGB(ves20170707, r=5, g=4, b=3, stretch="lin", main="Burnt area 07/07/2017", scale= "1000", axes = TRUE)  
plotRGB(ves20170806, r=5, g=4, b=3, stretch="lin", main="Burnt area 06/08/2017", scale= "1000", axes = TRUE)  
                   
                   
#2018 situation                    
 
######## JULY 2018 #########
#Now we will see how much the vegatation changed a year after the fires
rlist20180702 <- list.files(pattern="T33TVF_20180702")
rlist20180702 #to check the new disposition of the bands
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#lapply function : applying to all the files of the list the raster function
import20180702 <- lapply(rlist20180702, raster)

#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20180702 <- resample(import20180702[[1]], import20180702[[5]])  
B03_green_20180702 <- resample(import20180702[[2]], import20180702[[5]])  
B04_red_20180702 <- resample(import20180702[[3]], import20180702[[5]]) 
B08_nir_20180702 <- resample(import20180702[[4]], import20180702[[5]])
B11_swir_20180702 <-import20180702[[5]]  
#resample worked!

july18 <- stack(B02_blue_20180702, B03_green_20180702, B04_red_20180702, B08_nir_20180702, B11_swir_20180702)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude                 
ves20180702 <- crop(july18, ext)
#Now all 20 m resolution
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#B11 (SWIR) -> band 5     
#ves20180806 zoom of the park from 02 July 2018
plotRGB(ves20180702, r=3, g=2, b=1, stretch="lin")  #human eye  #use this for the main and the axes always
#NIR 
plotRGB(ves20180702, r=4, g=3, b=2, stretch="lin")  #vegetation in red




#2019 situation                    
 
######## JUNE 2019 #########
#Now we will see how much the vegatation changed a year after the fires
rlist20190627 <- list.files(pattern="T33TVF_20190627")
rlist20190627 #to check the new disposition of the bands
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#lapply function : applying to all the files of the list the raster function
import20190627 <- lapply(rlist20190627, raster)

#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20190627 <- resample(import20190627[[1]], import20190627[[5]])  
B03_green_20190627 <- resample(import20190627[[2]], import20190627[[5]])  
B04_red_20190627 <- resample(import20190627[[3]], import20190627[[5]]) 
B08_nir_20190627 <- resample(import20190627[[4]], import20190627[[5]])
B11_swir_20190627 <-import20190627[[5]]  
#resample worked!

june19 <- stack(B02_blue_20190627, B03_green_20190627, B04_red_20190627, B08_nir_20190627, B11_swir_20190627)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude                 
ves20190627 <- crop(june19, ext)
#ves20190627 zoom of the park from 06 June 2019
plotRGB(ves20190627, r=3, g=2, b=1, stretch="lin")  #human eye  #use this for the main and the axes always
#NIR 
plotRGB(ves20190627, r=4, g=3, b=2, stretch="lin")  #vegetation in red

   
#2020 situation                    
 
######## JULY 2020 #########
#Now we will see how much the vegatation changed a year after the fires
rlist20200701 <- list.files(pattern="T33TVF_20200701")
rlist20200701 #to check the new disposition of the bands
#B02 (blue) -> band 1
#B03 (green) -> band 2
#B04 (red) -> band 3
#B08 (NIR) -> band 4
#lapply function : applying to all the files of the list the raster function
import20200701 <- lapply(rlist20200701, raster)

#I am using this function to bring bands of 10 m resolution to the SWIR resolution (20 m)
B02_blue_20200701 <- resample(import20200701[[1]], import20200701[[5]])  
B03_green_20200701 <- resample(import20200701[[2]], import20200701[[5]])  
B04_red_20200701 <- resample(import20200701[[3]], import20200701[[5]]) 
B08_nir_20200701 <- resample(import20200701[[4]], import20200701[[5]])
B11_swir_20200701 <-import20200701[[5]]  
#resample worked!

july2020 <- stack(B02_blue_20200701, B03_green_20200701, B04_red_20200701, B08_nir_20200701, B11_swir_20200701)
ext <- c(446500,457000, 4513000, 4525000)  #to zoom the picture at a certain latitude and longitude                 
ves20200701 <- crop(july2020, ext)
#ves20200701 zoom of the park from 01 July 2020
plotRGB(ves20200701, r=3, g=2, b=1, stretch="lin")  #human eye  #use this for the main and the axes always
#NIR 
plotRGB(ves20200701, r=4, g=3, b=2, stretch="lin")  #vegetation in red
                   
                   
#Now we uploaded all our data on R so let's compare all the picture together to see how much the vegetation changed in 3 years                   

#human eye analysis showing the differences from August 2017 to July 2020                   
par(mfrow=c(1,4)) 
plotRGB(ves20170806, r=3, g=2, b=1, stretch="lin", main="06/08/2017", axes = TRUE)  #06/08/2017
plotRGB(ves20180702, r=3, g=2, b=1, stretch="lin", main="02/07/2018", axes = TRUE)  #02/07/2018
plotRGB(ves20190627, r=3, g=2, b=1, stretch="lin", main="27/06/2019", axes = TRUE)  #27/06/2019 
plotRGB(ves20200701, r=3, g=2, b=1, stretch="lin", main="01/07/2020", axes = TRUE) #01/07/2020  

#NIR analysis showing the differences from August 2017 to July 2020                   
par(mfrow=c(1,4)) 
plotRGB(ves20170806, r=4, g=3, b=2, stretch="lin", main="06/08/2017", axes = TRUE)  #06/08/2017
plotRGB(ves20180702, r=4, g=3, b=2, stretch="lin", main="02/07/2018", axes = TRUE)  #02/07/2018
plotRGB(ves20190627, r=4, g=3, b=2, stretch="lin", main="27/06/2019", axes = TRUE)  #27/06/2019 
plotRGB(ves20200701, r=4, g=3, b=2, stretch="lin", main="01/07/2020", axes = TRUE) #01/07/2020  

#Burnt area analysis showing the differences from August 2017 to July 2020                   
par(mfrow=c(1,4)) 
plotRGB(ves20170806, r=5, g=4, b=3, stretch="lin", main="Burnt area 06/08/2017", axes = TRUE)  #06/08/2017
plotRGB(ves20180702, r=5, g=4, b=3, stretch="lin", main="Burnt area 02/07/2018", axes = TRUE)  #02/07/2018
plotRGB(ves20190627, r=5, g=4, b=3, stretch="lin", main="Burnt area 27/06/2019", axes = TRUE)  #27/06/2019 
plotRGB(ves20200701, r=5, g=4, b=3, stretch="lin", main="Burnt area 01/07/2020", axes = TRUE) #01/07/2020                     
                   
                
