library(tools)
wd <- getwd()

## MORPH
loc <- file.path(getwd(), "dev", "Models", "MORPH")
saveto <- file.path(getwd(), "inst", "Models", "MORPH")
dir.create(saveto)
languages <- list.files(pattern = ".RDR|.DICT", path = loc, full.names = TRUE, recursive = TRUE)
languages <- basename(languages)
languages <- file_path_sans_ext(languages)
languages <- unique(languages)
lapply(languages, FUN=function(language){
  f <- list.files(pattern = language, path = loc, full.names = TRUE, recursive = TRUE)
  mydir <- dirname(f[1])
  setwd(mydir)
  zip(zipfile = file.path(saveto, sprintf("%s.zip", language)), files = basename(f))
  f
})
setwd(wd)

## POS
loc <- file.path(getwd(), "dev", "Models", "POS")
saveto <- file.path(getwd(), "inst", "Models", "POS")
dir.create(saveto)
languages <- list.files(pattern = ".RDR|.DICT", path = loc, full.names = TRUE, recursive = TRUE)
languages <- basename(languages)
languages <- file_path_sans_ext(languages)
languages <- unique(languages)
lapply(languages, FUN=function(language){
  f <- list.files(pattern = language, path = loc, full.names = TRUE, recursive = TRUE)
  mydir <- dirname(f[1])
  setwd(mydir)
  zip(zipfile = file.path(saveto, sprintf("%s.zip", language)), files = basename(f))
  f
})
setwd(wd)

## UNIPOS
loc <- file.path(getwd(), "dev", "Models", "UniPOS")
saveto <- file.path(getwd(), "inst", "Models", "UniversalPOS")
dir.create(saveto)
languages <- list.files(path = loc, full.names = TRUE)
languages <- basename(languages)
languages <- setdiff(languages, c("UDv1.3_results.txt", "Readme.md"))
languages <- unique(languages)
lapply(languages, FUN=function(language){
  f <- list.files(path = file.path(loc, language), full.names = TRUE, recursive = TRUE)
  mydir <- dirname(f[1])
  setwd(mydir)
  zip(zipfile = file.path(saveto, sprintf("%s.zip", gsub("UD_", "", language))), files = basename(f))
  f
})
setwd(wd)