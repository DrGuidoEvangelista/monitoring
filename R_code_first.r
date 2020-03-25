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
