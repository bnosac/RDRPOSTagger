#' @import rJava
#' @importFrom tools file_path_sans_ext
#' @importFrom utils unzip
#' @importFrom data.table data.table rbindlist setDT setDF setcolorder setnames
NULL


.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc = libname)
}
