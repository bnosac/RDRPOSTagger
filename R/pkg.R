#' @title Parts of Speech Tagging based on the Ripple Down Rules-based Part-Of-Speech Tagger
#' @description Parts of Speech tagging and morphological tagging based on the
#' Ripple Down Rules-based Part-Of-Speech Tagger (RDRPOS) available at https://github.com/datquocnguyen/RDRPOSTagger.
#' Tagging models include Bulgarian, Czech, Dutch, English, French, German, Hindi, Italian, Portuguese, Spanish, Swedish, Thai and Vietnamese.
#' RDRPOSTagger also supports the pre-trained Universal POS tagging models for 40 languages.
#' @docType package
#' @name RDRPOSTagger
#' @import rJava
#' @importFrom tools file_path_sans_ext
#' @importFrom data.table data.table rbindlist setDT setDF setcolorder
#' @seealso \code{\link{rdr_pos}}, \code{\link{rdr_model}}
NULL


.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc = libname)
}
