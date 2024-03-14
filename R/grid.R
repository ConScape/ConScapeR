#' Wrapper for the Grid function of `ConScape`
#'
#' Creates a Grid from affinities, sources, targets and costs.
#' Affinities, sources and targets can be provided either as SpatRaster from the terra library or as matrix.
#' The costs can be provided as SpatRaster or matrix,
#' but also as a string describing a transformation from the affinity matrix (e.g. "x -> -log(x)").
#'
#' @param affinities `[SpatRaster, matrix]`
#' @param sources `[SpatRaster, matrix]`
#' @param targets `[SpatRaster, matrix]`
#' @param costs `[SpatRaster, matrix, character]`
#'
#' @return
#' @export
#'
#' @example examples/Grid_example.R
Grid <- function(affinities, sources, targets, costs) {
  if (class(affinities)[1]=="SpatRaster"){
    affinities <- terra::as.matrix(affinities, wide=T)
  }
  if (class(sources)[1]=="SpatRaster"){
    sources <- terra::as.matrix(sources, wide=T)
  }
  if (class(targets)[1]=="SpatRaster"){
    targets <- terra::as.matrix(targets, wide=T)
  }
  if (class(costs)[1]=="SpatRaster"){
    costs <- terra::as.matrix(costs, wide=T)
  }
  if (class(costs)[1]=="matrix"){
    nans <- is.nan(sources) | is.nan(targets) | is.nan(affinities) | is.nan(costs)
    costs[nans] <- NaN
  }else{
    nans <- is.nan(sources) | is.nan(targets) | is.nan(affinities)
  }
  sources[nans] <- NaN
  targets[nans] <- NaN
  affinities[nans] <- NaN

  if (class(costs)=="character"){
    g <- juliaLet(paste0("ConScape.Grid(size(affinities)...,
                  affinities=ConScape.graph_matrix_from_raster(affinities),
                  source_qualities=sources,
                  target_qualities=SparseArrays.sparse(targets),
                  costs=ConScape.mapnz(", costs, ", ConScape.graph_matrix_from_raster(affinities)))"),
                  affinities=affinities, sources=sources, targets=targets)
  }else{
    g <- juliaLet("ConScape.Grid(size(affinities)...,
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
#' @param mat `[matrix]` matrix to be converted
#' @param rast `[SpatRaster]` template raster, usually one of those used in the `ConScapeR::Grid` function
#'
#' @return `[SpatRaster]`
#' @export
#'
#' @example examples/mat2rast_example.R
mat2rast <- function(mat, rast){
  rast2 <- rast(mat, extent=ext(rast), crs = crs(rast))
  return(rast2)
}

