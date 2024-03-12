#' Provide path to the julia installation
#'
#' @param julia_path
#' @param install_libraries
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
