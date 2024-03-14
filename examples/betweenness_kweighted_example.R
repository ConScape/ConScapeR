library(ConScapeR)
library(terra)

# Launch Julia
ConScapeR_setup("your_path_to...../Julia-1.9.3/bin")

# Create a SpatRaster from a file for the landscape permeability or affinities and habitat suitability
aff <- terra::rast(system.file("data/affinities_2000.asc", package="ConScapeR"))
hab <- terra::rast(system.file("data/suitability_2000.asc", package="ConScapeR"))

# Create a ConScape Grid
g <- ConScapeR::Grid(affinities=aff, sources=hab, targets=hab, costs="x -> -log(x)")

# Create a ConScape GridRSP by providing the randomness parameter theta
# note: on larger graphs this may be a computation intensive step
h <- ConScapeR::GridRSP(g, theta=0.1)

# Compute quality-and proximity-weighted betweenness
betw <- ConScapeR::betweenness_kweighted(h, alpha=1/47)

# Convert matrix to raster
betw <- ConScapeR::mat2rast(betw)
plot(betw)
