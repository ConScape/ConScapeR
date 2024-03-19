#' Wrapper for the GridRSP function of `ConScape`
#'
#' Creates a GridRSP from a ConScape.Grid and the randomness parameter. Theta closer to zero gives a more random movement,
#' as theta increases the RSP distribution will converge to the optimal or least-cost paths.
#' Note that the computation becomes numerically unstable as theta becomes really small or large.
#' See Van Moorter et al. (2023, Methods in Ecology and Evolution) for more details.
#'
#' @param g `[Grid]` \cr The output from the [ConScapeR::Grid()] function.
#' @param theta `[numeric]` \cr The randomness parameter theta. Lower `theta` values
#' represent a more random walk, and higher values a more least-cost path behavior.
#'
#' @return A `ConScape.GridRSP` object within Julia.
#' @export
#'
#' @example examples/GridRSP_example.R
GridRSP <- function(g, theta) {
  h <- JuliaConnectoR::juliaLet("ConScape.GridRSP(g, θ=theta)", g=g, theta=theta)
  return(h)
}

#' Wrapper for the `betweenness_qweighted` function of `ConScape`
#'
#' Computes the quality-weighted betweenness for a ConScape.GridRSP object.
#' See Van Moorter et al. (2023, Methods in Ecology and Evolution) for more details.
#'
#' @param h `[GridRSP]` \cr The output from the [ConScapeR::GridRSP()] function.
#'
#' @return `matrix`
#' @export
#'
#' @example examples/betweenness_qweighted_example.R
betweenness_qweighted <- function(h) {
  betw <- JuliaConnectoR::juliaLet("ConScape.betweenness_qweighted(h)", h=h)
  return(betw)
}

#' Wrapper for the `betweenness_kweighted` function of `ConScape`
#'
#' Computes the quality- and proximity-weighted betweenness for a ConScape.GridRSP object.
#' See Van Moorter et al. (2023, Methods in Ecology and Evolution) for more details.
#'
#' @param h `[GridRSP]` \cr The output from the [ConScapeR::GridRSP()] function.
#' @param alpha `[numeric]` \cr The distance scaling for the exponential distance
#' to proximity transformation.
#'
#' @return `matrix`
#' @export
#'
#' @example examples/betweenness_kweighted_example.R
betweenness_kweighted <- function(h, alpha) {
  betw <- JuliaConnectoR::juliaLet("ConScape.betweenness_kweighted(h, distance_transformation=x -> exp(-x*alpha))", h=h, alpha=alpha)
  return(betw)
}

#' Wrapper for the `connected_habitat` function of `ConScape`
#'
#' Computes the habitat functionality for a ConScape.GridRSP object.
#' See Van Moorter et al. (2023, Methods in Ecology and Evolution) for more details.
#'
#' @param h `[GridRSP]` \cr The output from the [ConScapeR::GridRSP()] function.
#' @param alpha `[numeric]` \cr The distance scaling for the exponential distance to
#' proximity transformation.
#'
#' @return A `matrix` with loca (pixel) measures of habitat functionality.
#' @export
#'
#' @example examples/connected_habitat_example.R
connected_habitat <- function(h, alpha) {
  func <- JuliaConnectoR::juliaLet("ConScape.connected_habitat(h, distance_transformation=x -> exp(-x*alpha))", h=h, alpha=alpha)
  return(func)
}

#' Wrapper for the `expected_cost` function of `ConScape`
#'
#' Computes the RSP expected cost between all sources and non-zero targets.
#' See Van Moorter et al. (2023, Methods in Ecology and Evolution) for more details.
#'
#' @param h `[GridRSP]` \cr The output from the [ConScapeR::GridRSP()] function.
#'
#' @return
#' @export
#'
#' @example examples/expected_cost_example.R
expected_cost <- function(h) {
  dists = JuliaConnectoR::juliaLet("ConScape.expected_cost(h)", h=h)
  return(dists)
}


