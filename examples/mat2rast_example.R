library(ConScapeR)
library(terra)

# Create a SpatRaster from a file for habitat suitability
hab <- terra::rast(system.file("data/suitability_2000.asc", package="ConScapeR"))
plot(hab)

# For this example: convert raster to matrix
mat <- terra::as.matrix(mat, wide=T)
image(mat)

# Convert matrix to raster
r <- ConScapeR::mat2rast(mat, hab)
plot(r)
