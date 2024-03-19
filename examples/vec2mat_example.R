library(ConScapeR)
library(terra)

# Launch Julia
ConScapeR_setup(Sys.getenv("JULIA_PATH"))

# Create a SpatRaster from a file for the landscape permeability or affinities
aff <- terra::rast(system.file("extdata/affinities_2000.asc", package="ConScapeR"))

# Create source and target file
aff <- terra::ifel(is.nan(aff), NaN, 1) # raster with 1/NaN
src <- terra::rast(as.matrix(aff, wide=T),
                   extent = terra::ext(aff),
                   crs = terra::crs(aff))
plot(src)

# copy map and select only one pixel as source and another as target
tgt <- terra::deepcopy(src)
tgt <- terra::ifel(tgt == 1, 0, tgt)
tgt[20, 26] <- 1
tgt[30, 40] <- 1
plot(tgt)

# Create a ConScape Grid
g <- ConScapeR::Grid(affinities=aff, sources=src, targets=tgt, costs="x -> -log(x)")

# Create a ConScape GridRSP by providing the randomness parameter theta
# note: on larger graphs this may be a computation intensive step
h <- ConScapeR::GridRSP(g, theta=0.1)

# Compute distances from sources (rows) to targets (columns)
dists <- ConScapeR::expected_cost(h)
dim(dists)

# Convert vector to matrix, and matrix to raster
dist <- ConScapeR::vec2mat(dists[,1], g)
dist <- ConScapeR::mat2rast(dist, aff)
plot(dist)
