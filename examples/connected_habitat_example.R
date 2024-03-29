library(ConScapeR)
library(terra)

# Launch Julia
ConScapeR_setup(Sys.getenv("JULIA_PATH"))

# Create a SpatRaster from a file for the landscape permeability or affinities and habitat suitability
aff <- terra::rast(system.file("extdata/affinities_2000.asc", package="ConScapeR"))
hab <- terra::rast(system.file("extdata/suitability_2000.asc", package="ConScapeR"))

# Create a ConScape Grid
g <- ConScapeR::Grid(affinities=aff, sources=hab, targets=hab, costs="x -> -log(x)")

# Create a ConScape GridRSP by providing the randomness parameter theta
# note: on larger graphs this may be a computation intensive step
h <- ConScapeR::GridRSP(g, theta=0.1)

# Compute habitat functionality
func <- ConScapeR::connected_habitat(h, alpha=1/100)

# Convert matrix to raster
func <- ConScapeR::mat2rast(func, hab)
plot(func)
