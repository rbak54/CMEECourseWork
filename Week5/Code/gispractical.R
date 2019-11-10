#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: gispractical.R
#Desc: gis work
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
#http://rpubs.com/david_orme/GIS_in_R
library(raster)
library(sf)
library(viridis)
library(units)
library(rgdal)
library(rgeos)
library("lwgeom")
pop_dens <- data.frame(n_km2 = c(260, 67,151, 4500, 133), 
                       country = c('England','Scotland', 'Wales', 'London', 'Northern Ireland'))
print(pop_dens)
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

scotland<-st_polygon(list(scotland))
england<-st_polygon(list(england))

wales<-st_polygon(list(wales))
ireland<-st_polygon(list(ireland))
uk_eire<-st_sfc(wales, england, scotland, ireland, crs=4326)

plot(uk_eire)


uk_eire_capitals<-data.frame(long=c(-0.1, -3.2, -3.2, -6.0, -6.25),lat=c(51.5,51.5,55.8, 54.6, 53.3),
                             name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin'))
uk_eire_capitals<-st_as_sf(uk_eire_capitals,coords=c('long', 'lat'),crs=4326)

st_pauls<-st_point(x=c(-0.098056, 51.513611))
london<-st_buffer(st_pauls, 0.25)
england_no_london<-st_difference(england, london)

lengths(scotland)

lengths(england_no_london)

wales<-st_difference(wales, england)
ni_area<-st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4,56,55,54,54.4))))



northern_ireland<-st_intersection(ireland, ni_area)                         


eire<-st_difference(ireland, ni_area)
uk_eire<- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)



plot(uk_eire,asp=1)

uk_country<-st_union(uk_eire[-6])
print(uk_eire)
graphics.off()

print(uk_country)
par(mfrow=c(1,2),mar=c(3,3,1,1))
plot(uk_eire, asp=1, col=rainbow(6))
plot(st_geometry(uk_eire_capitals), add=TRUE)
plot(uk_country, asp=1, col="lightblue")
uk_eire<-st_sf(name=c('Wales','England','Scotland','London','Northern Ireland', 'Eire'),
               geometry=uk_eire)
plot(uk_eire,asp=1)

uk_eire$capital<-c('London', 'Edinburgh', 'Cardiff', NA, 'Belfast', 'Dublin')
uk_eire<-merge(uk_eire,pop_dens, by.x='name', by.y='country', all.x=TRUE)

print(uk_eire)
uk_eire_centroids<- st_centroid(uk_eire)
st_coordinates(uk_eire_centroids)
uk_eire$area<-st_area(uk_eire)

uk_eire$length<-st_length(uk_eire)

print(uk_eire)

uk_eire$area<-set_units(uk_eire$area,'km^2')
uk_eire$length<-set_units(uk_eire$length, 'km')
#uk_eire$area<-set_units(uk_eire$area, 'kg^2')
uk_eire$length<-as.numeric(uk_eire$length)
print(uk_eire)
st_distance(uk_eire)
st_distance(uk_eire_centroids)
#plotting sf objects
plot(uk_eire['n_km2'],asp=1,logz=TRUE)
#logz so log scale axis
#reprojecting vector data
uk_eire_BNG<-st_transform(uk_eire, 27700)
st_bbox(uk_eire)
st_bbox(uk_eire_BNG)
uk_eire_UTM50N<-st_transform(uk_eire,32650)
par(mfrow=c(1,3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire), asp=1, axes=TRUE, main='WGS 84')
plot(st_geometry(uk_eire_BNG), asp=1, axes=TRUE, main='OSGB 1936/ BNG')
plot(st_geometry(uk_eire_UTM50N), asp=1, axes=TRUE, main='UTM 50N')
graphics.off()
st_pauls<-st_sfc(st_pauls, crs=4326)
one_deg_west_pt<-st_sfc(st_pauls - c(1,0), crs=4326)
one_deg_north_pt<-st_sfc(st_pauls + c(0,1), crs=4326)
st_distance(st_pauls, one_deg_west_pt)
st_distance(st_pauls, one_deg_north_pt)
st_distance(st_transform(st_pauls, 27700), st_transform(one_deg_west_pt, 27700))
library(units)
d<-units::set_units(25, km)
st_pauls_bng <- st_transform(st_pauls, crs=27700)
london_bng<-st_buffer(st_pauls_bng, d)
#plot(london_bng)
england_bng<-st_transform(st_sfc(england, crs=4326), crs=27700)
england_no_london_bng<-st_difference(england_bng, london_bng)
others_bng<-st_transform(st_sfc(eire, northern_ireland, wales, scotland, crs=4326), 27700)
#plot(uk_eire)
uk_eire_bng<-c(others_bng, england_no_london_bng, london_bng)
plot(uk_eire_bng, axes=TRUE, main ="25 km radius around London")
###########
#####RASTERS
graphics.off()
uk_raster_WGS84 <- raster(xmn=-11,  xmx=2,  ymn=49.5, ymx=59, 
                          res=0.5, crs="+init=epsg:4326")
hasValues(uk_raster_WGS84)
values(uk_raster_WGS84)<-seq(length(uk_raster_WGS84))

graphics.off()

#issue here 
plot(uk_raster_WGS84)
plot(st_geometry(uk_eire), add=TRUE, border='black', lwd=2, col="#FFFFFF44")

m<-matrix(c(1, 1, 3, 3,
            1, 2, 4, 3,
            5, 5, 7, 8,
            6, 6, 7, 7), ncol=4, byrow=TRUE)
square<-raster(m)
square_agg_mean<-aggregate(square, fact=2, fun=mean)
values(square_agg_mean)
square_agg_max<-aggregate(square, fact=2, fun=max)
values(square_agg_max)
square_agg_modal<- aggregate(square, fact=2, fun = modal)
values(square_agg_modal)
square_disagg<- disaggregate(square, fact=2)
square_disagg_interp<- disaggregate(square, fact=2, method='bilinear')
plot(square_disagg)
plot(square_disagg_interp)
##reprojecting a raster
uk_pts_WGS84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2, 59)), crs=4326)
uk_pts_BNG<-st_sfc(st_point(c(-2e5,0)),st_point(c(7e5,1e6)), crs=27700)
uk_grid_WGS84<-st_make_grid(uk_pts_WGS84, cellsize=0.5)
uk_grid_BNG<-st_make_grid(uk_pts_BNG, cellsize = 1e5)
uk_grid_BNG_as_WGS84<-st_transform(uk_grid_BNG, 4326)
plot(uk_grid_WGS84, asp=1, border='grey', xlim=c(-13,4))
plot(st_geometry(uk_eire), add= TRUE, border='darkgreen', lwd=2)
plot(uk_grid_BNG_as_WGS84, border='red', add=TRUE)

uk_raster_BNG<- raster(xmn=-200000, xmx=700000, ymn=0, ymx=1000000,
                       res=100000, crs='+init=epsg:27700')

uk_raster_BNG_interp<-projectRaster(uk_raster_WGS84, uk_raster_BNG, method='bilinear')
uk_raster_BNG_ngb<-projectRaster(uk_raster_WGS84, uk_raster_BNG, method='ngb')
#compare
round(values(uk_raster_BNG_interp)[1:9], 2)
values(uk_raster_BNG_ngb)[1:9]
par(mfrow=c(1,3), mar=c(1,1,2,1))
plot(uk_raster_BNG_interp, main='Interpolated', axes=FALSE, legend=FALSE)
plot(uk_raster_BNG_ngb, main='Nearest Neighbour', axes=FALSE, legend=FALSE)
##converting between data types
graphics.off()
uk_20km <- raster(xmn=-200000, xmx=650000, ymn=0, ymx=1000000, 
                 res=20000, crs='+init=epsg:27700')

# Rasterizing polygons
uk_eire_poly_20km  <- rasterize(as(uk_eire_BNG, 'Spatial'), uk_20km, field='name')

# Rasterizing lines
st_agr(uk_eire_BNG)<-'constant'
uk_eire_BNG_line <- st_cast(uk_eire_BNG, 'LINESTRING')
uk_eire_line_20km <- rasterize(as(uk_eire_BNG_line, 'Spatial'), uk_20km, field='name')

# Rasterizing points 
# - This isn't quite as neat. You need to take two steps in the cast and need to convert 
#   the name factor to numeric.
uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, 'MULTIPOINT'), 'POINT')
uk_eire_BNG_point$name <- as.numeric(uk_eire_BNG_point$name)
uk_eire_point_20km <- rasterize(as(uk_eire_BNG_point, 'Spatial'), uk_20km, field='name')

# Plotting those different outcomes
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(uk_eire_poly_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')

plot(uk_eire_line_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')

plot(uk_eire_point_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)

plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')

##raster to vector
# rasterToPolygons returns a polygon for each cell and returns a Spatial object
poly_from_rast <- rasterToPolygons(uk_eire_poly_20km)
poly_from_rast <- as(poly_from_rast, 'sf')

# but can be set to dissolve the boundaries between cells with identical values
poly_from_rast_dissolve <- rasterToPolygons(uk_eire_poly_20km, dissolve=TRUE)
poly_from_rast_dissolve <- as(poly_from_rast_dissolve, 'sf')

# rasterToPoints returns a matrix of coordinates and values.
points_from_rast <- rasterToPoints(uk_eire_poly_20km)
points_from_rast <- st_as_sf(data.frame(points_from_rast), coords=c('x','y'))

# Plot the outputs - using key.pos=NULL to suppress the key and
# reset=FALSE to avoid plot.sf altering the par() options
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(poly_from_rast['layer'], key.pos = NULL, reset = FALSE)
plot(poly_from_rast_dissolve, key.pos = NULL, reset = FALSE)
plot(points_from_rast, key.pos = NULL, reset = FALSE)

##saving
#vectors
st_write(uk_eire,'../Data/uk_eire_WGS84.shp')
st_write(uk_eire_BNG, '../Data/uk_eire_BNG.shp')
st_write(uk_eire, '../Data/uk_eire_WGS84.geojson')
st_write(uk_eire, '../Data/uk_eire_WGS84.gpkg')
st_write(uk_eire, '../Data/uk_eire_WGS84.json', driver='GeoJSON')
st_drivers()
#rasters
#tiff most common
writeRaster(uk_raster_BNG_interp, '../Data/uk_raster_BNG_interp.tif')
writeRaster(uk_raster_BNG_ngb, '../Data/uk_raster_BNG_ngb.asc', format='ascii')
writeFormats()

