#' Launch the Julia installation from R and load the `ConScape` library in Julia
#'
#' The first time the function is ran, it is best to set the `install_libraries` to `TRUE` to install the `ConScape` library in Julia
#'
#' @param julia_path `[character]` The directory for the Julia bin, e.g. "C:/Programs/Julia-1.9.3/bin".
#' @param install_libraries `[logical]` If `FALSE` (default), Julia will be launched and the required libraries loaded without installing them. If `TRUE`, the libraries will be (re-)installed in Julia.
#'
#' @return
#' @export
#'
#' @example examples/ConScapeR_setup_example.R
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
