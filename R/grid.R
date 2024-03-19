#' Wrapper for the Grid function of `ConScape`
#'
#' Creates a Grid from affinities, sources, targets and costs.
#' Affinities, sources and targets can be provided either as
#' `SpatRaster` from the `terra` library or as `matrix`.
#' The costs can be provided as `SpatRaster` or `matrix`,
#' but also as a string describing a transformation from the affinity matrix
#' (e.g. `"x -> -log(x)"`).
#'
#' @param affinities `[SpatRaster, matrix]` \cr The affinities, represent the likelihood
#' of movement. They can be provided as a `SpatRaster` representing the affinity,
#' permeability, or resistance of each pixel to movement (in which case it is
#' internally transformed into a matrix), or as a matrix with affinities between
#' pairs of sources-targets directly.
#' @param sources `[SpatRaster, matrix]` \cr Map or matrix presenting the habitat
#' suitability/quality of source cells.
#' @param targets `[SpatRaster, matrix]` \cr Map or matrix presenting the habitat
#' suitability/quality of target cells.
#' @param costs `[SpatRaster, matrix, character]` \cr Map or matrix presenting the
#' cost of movement through each cell. Alternatively, a string describing a transformation
#' from the affinity matrix (e.g. `"x -> -log(x)"`)
#'
#' @return A `ConScape.Grid` object within Julia.
#' @export
#'
#' @example examples/Grid_example.R
Grid <- function(affinities, sources, targets, costs) {
  # affinities
  if (class(affinities)[1] == "SpatRaster") {
    affinities <- terra::as.matrix(affinities, wide = T)
  }
  # sources
  if (class(sources)[1] == "SpatRaster") {
    sources <- terra::as.matrix(sources, wide = T)
  }
  # targets
  if (class(targets)[1] == "SpatRaster") {
    targets <- terra::as.matrix(targets, wide = T)
  }
  # costs
  if (class(costs)[1] == "SpatRaster") {
    costs <- terra::as.matrix(costs, wide = T)
  }

  # check NaNs
  if (class(costs)[1] == "matrix") {
    nans <- is.nan(sources) | is.nan(targets) | is.nan(affinities) | is.nan(costs)
    costs[nans] <- NaN
  } else {
    nans <- is.nan(sources) | is.nan(targets) | is.nan(affinities)
  }
  sources[nans] <- NaN
  targets[nans] <- NaN
  affinities[nans] <- NaN

  # create Grid
  if (class(costs) == "character"){
    g <- JuliaConnectoR::juliaLet(
      paste0("ConScape.Grid(size(affinities)...,
              affinities=ConScape.graph_matrix_from_raster(affinities),
              source_qualities=sources,
              target_qualities=SparseArrays.sparse(targets),
              costs=ConScape.mapnz(", costs, ", ConScape.graph_matrix_from_raster(affinities)))"),
      affinities=affinities, sources=sources, targets=targets)
  } else {
    g <- JuliaConnectoR::juliaLet("ConScape.Grid(size(affinities)...,
                  affinities=ConScape.graph_matrix_from_raster(affinities),
                  source_qualities=sources,
                  target_qualities=SparseArrays.sparse(targets),
                  costs=ConScape.graph_matrix_from_raster(costs))",
                  affinities=affinities, sources=sources, targets=targets, costs=costs)
  }
  return(g)
}


#' Convert a matrix to raster
#'
#' @param mat `[matrix]` \cr Matrix to be converted.
#' @param rast `[SpatRaster]` \cr Template raster, usually one of those used in the
#' [ConScapeR::Grid()] function.
#'
#' @return `[SpatRaster]`
#' @export
#'
#' @example examples/mat2rast_example.R
mat2rast <- function(mat, rast){
  rast2 <- terra::rast(mat, extent = terra::ext(rast), crs = terra::crs(rast))
  return(rast2)
}

#' Convert a node vector to matrix
#'
#' @param vec `[matrix]` \cr Matrix to be converted
#' @param g `[Grid]` \cr Template raster, usually one of those used in the
#' [ConScapeR::Grid()] function.
#'
#' @return `[matrix]`
#' @export
#'
#' @example examples/vec2mat_example.R
vec2mat <- function(vec, g){
  mat <- JuliaConnectoR::juliaLet("ConScape._vec_to_grid(g, vec)", g=g, vec=vec)
  return(mat)
}

