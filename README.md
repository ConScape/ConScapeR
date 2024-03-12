
# ConScapeR <img src="man/figures/ConScapeR_hex_logo_hex_logo.png" align="right" alt="" width="150" />

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

This is a basic example which shows you how to solve a common problem:

``` r
library(ConScapeR)

setup_ConScape("your_path_to...../Julia-1.9.3/bin")

perm <- rast("data/affinities_2000.asc")
plot(perm)

hab <- rast("data/suitability_2000.asc")
plot(hab)

g <- Grid(affinities=perm, sources=hab, targets=hab, costs="x -> -log(x)")
h <- ConScape_GridRSP(g, theta=0.1)
betw <- mat2rast(ConScape_betweenness_qweighted(h), perm)
plot(betw)

betw <- mat2rast(ConScape_betweenness_kweighted(h, alpha=1/47), perm)
plot(betw)

func <- mat2rast(ConScape_betweenness_connected_habitat(h, alpha=1/47), perm)
plot(func)
```

