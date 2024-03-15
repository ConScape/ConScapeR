
# ConScapeR <img src="man/figures/ConScapeR_hex_logo.png" align="right" alt="" width="150" />

<!-- badges: start -->
<!-- badges: end -->

`ConScapeR` provides a R wrapper to the [ConScape.jl library](https://github.com/ConScape/ConScape.jl) in [Julia](https://julialang.org/), which allows the use of ConScape from an R interface. However, using ConScape from the Julia interface is still recommended for full flexibility. 

ConScape (i.e. 'connected landscapes') is a software library implemented in the high-performance open-source Julia language to compute landscape ecological metrics — originally developed in metapopulation ecology (such as 'metapopulation capacity' and 'probability of connectivity') — for large landscapes. Moreover,in addition to traditional distance metrics used in ecology (i.e. Euclidean and least-cost distance), ConScape implements the randomized shortest paths framework to represent connectivity along the continuum from optimal to random movements.


## Installation

To run ConScape through R, you need to download and install [Julia](https://julialang.org/downloads/) to your computer, which R will run on the background.

You will need to provide the path to this Julia installation. An easy way to do this is by adding it to the `.Renviron` file (more information [here](https://support.posit.co/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf)). The easiest way to edit this file is with the `usethis` library:

``` r
library(usethis)
usethis::edit_r_environ()
```

Then add to this file the following line:

`JULIA_PATH = "your_path_to...../Julia-1.9.3/bin`

Then you can call this path through:
``` r
Sys.getenv("JULIA_PATH")
```

Finally, to install the development version of the `ConScapeR` R package:

```r
library(devtools)
devtools::install_github("ConScape/ConScapeR", ref = "HEAD")
```

## Example

First time, install the `ConScape` library in Julia:

``` r
library(ConScapeR)

# If the ConScape library is not installed in Julia, run:
ConScapeR_setup(Sys.getenv("JULIA_PATH"), install_libraries=TRUE)
```

This is a basic example demonstrating the basic workflow:

``` r
library(ConScapeR)
library(terra)

# Launch Julia
ConScapeR_setup(Sys.getenv("JULIA_PATH"))

# Create a SpatRaster from a file for the landscape permeability or affinities and habitat suitability
aff <- terra::rast(system.file("data/affinities_2000.asc", package="ConScapeR"))
hab <- terra::rast(system.file("data/suitability_2000.asc", package="ConScapeR"))
plot(aff)
plot(hab)

# Create a ConScape Grid
g <- ConScapeR::Grid(affinities=aff, sources=hab, targets=hab, costs="x -> -log(x)")

# Create a ConScape GridRSP by providing the randomness parameter theta
# note: on larger graphs this may be a computation intensive step
h <- ConScapeR::GridRSP(g, theta=0.1)

# Compute quality-weighted betweenness
betw <- ConScapeR::betweenness_qweighted(h)

# Convert matrix to raster
betw <- ConScapeR::mat2rast(betw)
plot(betw)

# Compute quality-and proximity-weighted betweenness (and convert to raster)
betw <- ConScapeR::mat2rast(ConScapeR::betweenness_kweighted(h, alpha=1/100), aff)
plot(betw)

# Compute habitat functionality (and convert to raster)
func <- ConScapeR::mat2rast(ConScapeR::connected_habitat(h, alpha=1/100), aff)
plot(func)
```

