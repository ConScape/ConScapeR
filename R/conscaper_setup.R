#' Provide path to the julia installation
#'
#' The first time the function is ran, it is best to set the `install_libraries` to TRUE to install the ConScape library in Julia
#'
#' @param julia_path
#' @param install_libraries `TRUE/FALSE` for whether the libraries should be installed in Julia (FALSE by default)
#'
#' @return
#' @export
#'
#' @examples
ConScapeR_setup <- function(julia_path, install_libraries=F) {
  Sys.setenv(JULIA_BINDIR = julia_path)

  if (install_libraries){
    Pkg <- juliaImport("Pkg")
    juliaEval("Pkg.add(\"ConScape\")")
    juliaEval("Pkg.add(\"SparseArrays\")")
  }
  SA <- juliaImport("SparseArrays")
  CS <- juliaImport("ConScape")
}
