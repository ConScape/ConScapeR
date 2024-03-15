library(ConScapeR)
library(terra)

# Launch Julia
ConScapeR_setup(Sys.getenv("JULIA_PATH"))

# Create a SpatRaster from a file for the landscape permeability or affinities and habitat suitability
aff <- terra::rast(system.file("data/affinities_2000.asc", package="ConScapeR"))
hab <- terra::rast(system.file("data/suitability_2000.asc", package="ConScapeR"))

# Create a ConScape Grid
g <- ConScapeR::Grid(affinities=aff, sources=hab, targets=hab, costs="x -> -log(x)")
