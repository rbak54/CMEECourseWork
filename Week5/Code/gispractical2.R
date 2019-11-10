#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: gispractical2.R
#Desc: gis work part 2
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
graphics.off()
#loading vector data
ne_110 <- st_read('../Data/data(1)/data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp')
life_exp <- read.csv(file = "../Data/WHOSIS_000001.csv")
##if time, task to make graphs of above
so_data <- read.csv('../Data/Southern_Ocean.csv', header=TRUE)
head(so_data)
# Convert the data frame to an sf object
#eg of xy data- southern ocean. read then convert into sfobject
so_data <- st_as_sf(so_data, coords=c('long', 'lat'), crs=4326)
head(so_data)

#loading raster data
etopo_25 <- raster('../Data/etopo_25.tif')
print(etopo_25)
plot(etopo_25)
#####if time task to make specific graph--colour scheme
tmax <- getData('worldclim', download=TRUE, path='../Data', var='tmax', res=10)
print(tmax)
dir('../Data/wc10')
# scale the data
tmax <- tmax / 10
# Extract  January and July data and the annual maximum by location.
tmax_jan <- tmax[[1]]
tmax_jul <- tmax[[7]]
tmax_max <- max(tmax)
# Plot those maps
par(mfrow=c(3,1), mar=c(2,2,1,1))
bks <- seq(-500, 500, length=101)
pal <- colorRampPalette(c('lightblue','grey', 'firebrick'))
cols <- pal(100)
ax.args <- list(at= seq(-500, 500, by=100))
plot(tmax_jan, col=cols, breaks=bks, axis.args=ax.args, main='January maximum temperature')
plot(tmax_jul, col=cols, breaks=bks, axis.args=ax.args, main='July maximum temperature')
plot(tmax_max, col=cols, breaks=bks, axis.args=ax.args, main='Annual maximum temperature')
##cropping data
so_extent <- extent(-60, -20, -65, -45)
# The crop function for raster data...
so_topo <- crop(etopo_25, so_extent)
# ... and the st_crop function to reduce some higher resolution coastline data
ne_10 <- st_read('../Data/data(1)/data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')
st_agr(ne_10) <- 'constant'
so_ne_10 <- st_crop(ne_10, so_extent)
## although coordinates are longitude/latitude, st_intersection assumes that they are planar
plot(so_topo, col=cols, asp=1, legend=FALSE, main='cropped')
###if time task to make specific graph
###spatial joining
