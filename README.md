
# ConScapeR <img src="man/figures/ConScapeR_hex_logo.png" align="right" alt="" width="150" />

<!-- badges: start -->
<!-- badges: end -->

`ConScapeR` provides a R wrapper to the ConScape library in Julia, which allows the use of ConScape directly from R.

ConScape (i.e. 'connected landscapes') is a software library implemented in the high-performance open-source Julia language to compute landscape ecological metrics — originally developed in metapopulation ecology (such as 'metapopulation capacity' and 'probability of connectivity') — for large landscapes. Moreover,in addition to traditional distance metrics used in ecology (i.e. Euclidean and least-cost distance), ConScape implements the randomized shortest paths framework to represent connectivity along the continuum from optimal to random movements.


## Installation

To install the development version of the `ConScapeR` R package:

```
library(devtools)
devtools::install_github("ConScape/ConScapeR", ref = "HEAD")
```

## Example

First time, install the `ConScape` library in Julia:

``` r
library(ConScapeR)

ConScapeR_setup("your_path_to...../Julia-1.9.3/bin", install_libraries=TRUE)
```

This is a basic example demonstrating the basic workflow:

``` r
library(ConScapeR)
library(terra)

ConScapeR_setup("your_path_to...../Julia-1.9.3/bin")

perm <- terra::rast("data/affinities_2000.asc")
plot(perm)

hab <- terra::rast("data/suitability_2000.asc")
plot(hab)

g <- ConScapeR::Grid(affinities=perm, sources=hab, targets=hab, costs="x -> -log(x)")
h <- ConScapeR::GridRSP(g, theta=0.1)
betw <- ConScapeR::mat2rast(ConScapeR::betweenness_qweighted(h), perm)
plot(betw)

betw <- ConScapeR::mat2rast(ConScapeR::betweenness_kweighted(h, alpha=1/47), perm)
plot(betw)

func <- ConScapeR::mat2rast(ConScapeR::connected_habitat(h, alpha=1/47), perm)
plot(func)
```

