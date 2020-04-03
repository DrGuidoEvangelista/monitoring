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
