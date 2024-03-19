library(ConScapeR)
library(terra)

# Create a SpatRaster from a file for habitat suitability
hab <- terra::rast(system.file("extdata/suitability_2000.asc", package="ConScapeR"))
plot(hab)

# For this example: convert raster to matrix
mat <- terra::as.matrix(hab, wide=T)
image(mat)
# note that the coordinates shift here, but this works well internally for ConScape

# Convert matrix to raster
r <- ConScapeR::mat2rast(mat, hab)
plot(r)
