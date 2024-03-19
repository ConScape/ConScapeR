#------------------------------------------------------------------------------
# Sample datasets

#' Sample map with affinities
#'
#' Map representing the affinities (i.e. the likelihood of movement) across
#' each pixel in an area.
#'
#' @format A ASC file. Original CRS: ETRS89 / UTM zone 33N.
#'
#' @examples
#' (f <- system.file("extdata/affinities_2000.asc", package = "ConScapeR"))
#' r <- terra::rast(f)
#' plot(r)
#'
#' @name affinities_2000.asc
#' @seealso [ConScapeR::suitability_2000.asc] \cr
#'
#' @source Van Moorter, B., Kivimäki, I., Noack, A., Devooght, R., Panzacchi, M.,
#' Hall, K. R., Leleux, P., & Saerens, M. (2023). Accelerating advances in landscape
#' connectivity modelling with the ConScape library. Methods in Ecology and Evolution,
#' 14(1), 133–145. https://doi.org/10.1111/2041-210X.13850
NULL

#' Sample map with suitability
#'
#' Map representing the habitat quality in each pixel in an area.
#'
#' @format A ASC file. Original CRS: ETRS89 / UTM zone 33N.
#'
#' @examples
#' (f <- system.file("extdata/suitability_2000.asc", package = "ConScapeR"))
#' r <- terra::rast(f)
#' plot(r)
#'
#' @name suitability_2000.asc
#' @seealso [ConScapeR::affinities_2000.asc] \cr
#'
#' @source Van Moorter, B., Kivimäki, I., Noack, A., Devooght, R., Panzacchi, M.,
#' Hall, K. R., Leleux, P., & Saerens, M. (2023). Accelerating advances in landscape
#' connectivity modelling with the ConScape library. Methods in Ecology and Evolution,
#' 14(1), 133–145. https://doi.org/10.1111/2041-210X.13850
NULL
