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














