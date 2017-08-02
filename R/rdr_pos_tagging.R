#' @title Lists all installed Ripple Down Rules-based Part-Of-Speech Tagger language models
#' @description Lists all language models currently installed in the RDRPOSTagger package folder.
#' These current consists of language models for
#' \itemize{
#'  \item{MORPH: }{detailed morphological tagging for languages}
#'  \item{POS: }{basic parts of speech tagging for languages}
#'  \item{UniversalPOS: }{universal POS tagging for languages. Based on data from http://universaldependencies.org version 2.0}
#' }
#' @return a list of data.frames with elements MORPH, POS and UniversalPOS containing the
#' language, the location of the dictionary and the location of the ripple down rules
#' @export
#' @seealso \code{\link{rdr_model}}
#' @examples
#' models <- rdr_available_models()
#' models
#'
#' models$MORPH$language
#' models$POS$language
#' models$UniversalPOS$language
rdr_available_models <- function(){
  available <- list()
  available$MORPH$language <- list.files(system.file("Models", "MORPH", package = "RDRPOSTagger"), pattern = ".zip$", full.names = TRUE)
  available$POS$language <- list.files(system.file("Models", "POS", package = "RDRPOSTagger"), pattern = ".zip$", full.names = TRUE)
  available$UniversalPOS$language <- list.files(system.file("Models", "UniversalPOS", package = "RDRPOSTagger"), pattern = ".zip$", full.names = TRUE)
  
  x <- lapply(available$MORPH$language, FUN=function(f) unzip(f, list = TRUE)$Name)
  available$MORPH$dictionary <- sapply(x, FUN=function(f) file.path(system.file("Models", "MORPH", package = "RDRPOSTagger"), grep(".DICT$", f, value = TRUE)))
  available$MORPH$rules <- sapply(x, FUN=function(f) file.path(system.file("Models", "MORPH", package = "RDRPOSTagger"), grep(".RDR$", f, value = TRUE)))
  x <- lapply(available$POS$language, FUN=function(f) unzip(f, list = TRUE)$Name)
  available$POS$dictionary <- sapply(x, FUN=function(f) file.path(system.file("Models", "POS", package = "RDRPOSTagger"), grep(".DICT$", f, value = TRUE)))
  available$POS$rules <- sapply(x, FUN=function(f) file.path(system.file("Models", "POS", package = "RDRPOSTagger"), grep(".RDR$", f, value = TRUE)))
  x <- lapply(available$UniversalPOS$language, FUN=function(f) unzip(f, list = TRUE)$Name)
  available$UniversalPOS$dictionary <- mapply(file_path_sans_ext(basename(available$UniversalPOS$language)), x, FUN=function(language, f) file.path(system.file("Models", "UniversalPOS", package = "RDRPOSTagger"), language, grep(".DICT$", f, value = TRUE)), USE.NAMES = FALSE)
  available$UniversalPOS$rules <- mapply(file_path_sans_ext(basename(available$UniversalPOS$language)), x, FUN=function(language, f) file.path(system.file("Models", "UniversalPOS", package = "RDRPOSTagger"), language, grep(".RDR$", f, value = TRUE)), USE.NAMES = FALSE)
  available$MORPH$language <- file_path_sans_ext(basename(available$MORPH$language))
  available$POS$language <- file_path_sans_ext(basename(available$POS$language))
  available$UniversalPOS$language <- file_path_sans_ext(basename(available$UniversalPOS$language))
  
  available <- lapply(available, as.data.frame, stringsAsFactors = FALSE)
  class(available) <- "rdr_models"
  available
}


rdr_unzipped_models <- function(){
  default <- data.frame(language = character(),
                        dictionary = character(),
                        rules = character(),
                        stringsAsFactors = FALSE)
  available <- list()
  available$MORPH <- file_path_sans_ext(list.files(system.file("Models", "MORPH", package = "RDRPOSTagger"), pattern = ".DICT$|.RDR$"))
  available$POS <- file_path_sans_ext(list.files(system.file("Models", "POS", package = "RDRPOSTagger"), pattern = ".DICT$|.RDR$"))
  available$UniversalPOS <- file_path_sans_ext(list.files(system.file("Models", "UniversalPOS", package = "RDRPOSTagger")))
  available$UniversalPOS <- unique(available$UniversalPOS)
  available$UniversalPOS <- available$UniversalPOS[dir.exists(file.path(system.file("Models", "UniversalPOS", package = "RDRPOSTagger"), available$UniversalPOS))]
  available$UniversalPOS <- setdiff(available$UniversalPOS, c("Readme", "UDv1.3_results"))
  available <- lapply(available, unique)
  if(length(available$MORPH) > 0){
    available$MORPH <- data.frame(language = available$MORPH,
                                  dictionary = system.file("Models", "MORPH", sprintf("%s.DICT", available$MORPH), package = "RDRPOSTagger"),
                                  rules = system.file("Models", "MORPH", sprintf("%s.RDR", available$MORPH), package = "RDRPOSTagger"),
                                  stringsAsFactors = FALSE)  
  }else{
    available$MORPH <- default
  }
  if(length(available$POS) > 0){
    available$POS <- data.frame(language = available$POS,
                                dictionary = system.file("Models", "POS", sprintf("%s.DICT", available$POS), package = "RDRPOSTagger"),
                                rules = system.file("Models", "POS", sprintf("%s.RDR", available$POS), package = "RDRPOSTagger"),
                                stringsAsFactors = FALSE)
  }else{
    available$POS <- default
  }
  if(length(available$UniversalPOS) > 0){
    available$UniversalPOS <- data.frame(language = available$UniversalPOS,
                                         dictionary = sapply(available$UniversalPOS, FUN=function(loc) list.files(system.file("Models", "UniversalPOS", loc, package = "RDRPOSTagger"), pattern = "\\.DICT$", full.names=TRUE)),
                                         rules = sapply(available$UniversalPOS, FUN=function(loc) list.files(system.file("Models", "UniversalPOS", loc, package = "RDRPOSTagger"), pattern = "\\.RDR$", full.names=TRUE)),
                                         stringsAsFactors = FALSE)
  }else{
    available$UniversalPOS <- default
  }
  class(available) <- "rdr_models"
  available
}



rdr_unzip <- function(language, annotation){
  zipfile <- file.path(system.file("Models", annotation, sprintf("%s.zip", language), package = "RDRPOSTagger"))
  if(!file.exists(zipfile)){
    stop(sprintf("Language %s not part of the possible languages for annotation %s. Run rdr_available_models() to see the available language/annotation models.", language, annotation))
  }
  existing <- rdr_unzipped_models()
  existing <- existing[[annotation]]$language
  existsalready <- language %in% existing
  if(annotation %in% c("MORPH", "POS")){
    storeat <- dirname(zipfile)
  }else if(annotation %in% "UniversalPOS"){
    storeat <- file.path(dirname(zipfile), file_path_sans_ext(basename(zipfile)))
  } 
  if(!existsalready){
    if(!dir.exists(storeat)){
      dir.create(storeat)  
    }
    unzip(zipfile = zipfile, exdir = storeat)
  }
}

# rdr_read_file <- function(file){
#   readLines(file, encoding = "UTF-8")
#   x <- list.files(system.file(package = "RDRPOSTagger"), recursive = TRUE, full.names = TRUE, pattern = ".DICT|.RDR")
#   x <- lapply(x, FUN = function(file) readLines(file, encoding = "UTF-8"))
#   save(x, file = "test.RData", compress = "xz")
# }
# rdr_init <- function(){
#   modelszip <- system.file("Models.zip", package = "RDRPOSTagger")
#   modelsfolder <- system.file(package = "RDRPOSTagger")
#   unzip(m, overwrite = TRUE, exdir = system.file(package = "RDRPOSTagger"))
# }



#' @export
print.rdr_models <- function(x, ...){
  cat('Riple down Rule based available taggers:', sep = "\n")
  cat('----------------------------------------', sep = "\n")
  
  cat("\n", sep = "")
  cat('1/ POS tagging for languages:', sep = "\n\n")
  if(length(x$POS$language) > 0){
    cat(paste(x$POS$language, collapse = ", "), sep = "\n")
  }else{
    cat("No languages for this type of POS tagging")
  }
  cat("\n", sep = "")
  cat('2/ MORPH tagging for languages:', sep = "\n\n")
  if(length(x$MORPH$language) > 0){
    cat(paste(x$MORPH$language, collapse = ", "), sep = "\n")
  }else{
    cat("No languages for this type of POS tagging")
  }
  cat("\n", sep = "")
  cat('3/ UniversalPOS tagging for languages:', sep = "\n")
  if(length(x$UniversalPOS$language) > 0){
    cat(paste(x$UniversalPOS$language, collapse = ", "), sep = "\n")
  }else{
    cat("No languages for this type of POS tagging")
  }
}

#' @title Set up a Ripple Down Rules-based Part-Of-Speech Tagger for tagging sentences
#' @description Set up a Ripple Down Rules-based Part-Of-Speech Tagger for tagging sentences
#' Possible languages are:
#' \itemize{
#'  \item{MORPH: }{Bulgarian, Czech, Dutch, French, German, Portuguese, Spanish, Swedish}
#'  \item{POS: }{English, French, German, Hindi, Italian, Thai, Vietnamese}
#'  \item{UniversalPOS: }{Ancient_Greek, Ancient_Greek-PROIEL, Arabic, Basque, Belarusian, 
#'  Bulgarian, Catalan, Chinese, Coptic, Croatian, Czech, Czech-CAC, Czech-CLTT, 
#'  Danish, Dutch, Dutch-LassySmall, English, English-LinES, English-ParTUT, Estonian, 
#'  Finnish, Finnish-FTB, French, French-ParTUT, French-Sequoia, Galician, Galician-TreeGal, 
#'  German, Gothic, Greek, Hebrew, Hindi, Hungarian, Indonesian, Irish, Italian, 
#'  Italian-ParTUT, Japanese, Korean, Latin, Latin-ITTB, Latin-PROIEL, Latvian, Lithuanian, 
#'  Norwegian-Bokmaal, Norwegian-Nynorsk, Old_Church_Slavonic, Persian, Polish, Portuguese, 
#'  Portuguese-BR, Romanian, Russian, Russian-SynTagRus, Slovak, Slovenian, Slovenian-SST, 
#'  Spanish, Spanish-AnCora, Swedish, Swedish-LinES, Tamil, Turkish, Urdu, Vietnamese}
#' }
#' @param language the language which is one of the languages for the annotation shown in \code{\link{rdr_available_models}}
#' @param annotation the type of annotation. Either one of 'MORPH', "POS' or 'UniversalPOS'
#' @return An object of class RDRPOSTagger which is a list with elements model (the location of the dictionary and the rules of that language),
#' the type of annotation and java objects tagger, initialtagger, dictionary and utility.
#' This model object can be used to tag sentences based on the specified POS tags.
#' @seealso \code{\link{rdr_model}}
#' @export
#' @examples
#' \dontrun{
#' ## MORPH models
#' tagger <- rdr_model(language = "Bulgarian", annotation = "MORPH")
#' tagger <- rdr_model(language = "Czech", annotation = "MORPH")
#' tagger <- rdr_model(language = "Dutch", annotation = "MORPH")
#' tagger <- rdr_model(language = "French", annotation = "MORPH")
#' tagger <- rdr_model(language = "German", annotation = "MORPH")
#' tagger <- rdr_model(language = "Portuguese", annotation = "MORPH")
#' tagger <- rdr_model(language = "Spanish", annotation = "MORPH")
#' tagger <- rdr_model(language = "Swedish", annotation = "MORPH")
#' ## POS models
#' tagger <- rdr_model(language = "English", annotation = "POS")
#' tagger <- rdr_model(language = "French", annotation = "POS")
#' tagger <- rdr_model(language = "German", annotation = "POS")
#' tagger <- rdr_model(language = "Hindi", annotation = "POS")
#' tagger <- rdr_model(language = "Italian", annotation = "POS")
#' tagger <- rdr_model(language = "Thai", annotation = "POS")
#' tagger <- rdr_model(language = "Vietnamese", annotation = "POS")
#' ## UniversalPOS models
#' tagger <- rdr_model(language = "Ancient_Greek", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Ancient_Greek-PROIEL", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Arabic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Basque", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Belarusian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Bulgarian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Catalan", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Chinese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Coptic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Croatian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Czech", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Czech-CAC", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Czech-CLTT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Danish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Dutch", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Dutch-LassySmall", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "English", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "English-LinES", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "English-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Estonian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Finnish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Finnish-FTB", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "French", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "French-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "French-Sequoia", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Galician", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Galician-TreeGal", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "German", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Gothic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Greek", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Hebrew", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Hindi", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Hungarian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Indonesian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Irish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Italian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Italian-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Japanese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Korean", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Latin", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Latin-ITTB", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Latin-PROIEL", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Latvian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Lithuanian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Norwegian-Bokmaal", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Norwegian-Nynorsk", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Old_Church_Slavonic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Persian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Polish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Portuguese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Portuguese-BR", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Romanian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Russian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Russian-SynTagRus", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Slovak", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Slovenian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Slovenian-SST", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Spanish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Spanish-AnCora", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Swedish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Swedish-LinES", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Tamil", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Turkish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Urdu", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "Vietnamese", annotation = "UniversalPOS")
#' }
rdr_model <- function(language,
                      annotation = c("MORPH", "POS", "UniversalPOS")){
  
  
  ## Check if model exists
  annotation <- match.arg(annotation)
  ## Unzip the model
  rdr_unzip(language, annotation)
    
  available_models <- rdr_unzipped_models()
  models <- available_models[[annotation]]
  idx <- which(models$language %in% language)
  idx <- head(idx, 1)
  if(length(idx) == 0){
    stop(sprintf("Language %s not part of the possible languages for annotation %s. Pick one of these languages: %s", language, annotation, paste(models$language, collapse = ", ")))
  }
  models <- models[idx, ]
  stopifnot(file.exists(models$rules))
  stopifnot(file.exists(models$dictionary))

  ## Construct the tagger
  utility <- rJava::.jnew("Utils")

  tagger <- .jnew("RDRPOSTagger")
  initialtagger <- .jnew("InitialTagger")

  tagger$constructTreeFromRulesFile(models$rules)
  dictionary <- utility$getDictionary(models$dictionary)

  z <- list(model = models, annotation = annotation,
            tagger = tagger, initialtagger = initialtagger, dictionary = dictionary, utility = utility)
  class(z) <- "RDRPOSTagger"
  z
}

#' @export
print.RDRPOSTagger <- function(x, ...){
  cat(sprintf("RDRPOSTagger %s annotation for %s", x$annotation, x$model$language), sep = "\n")
  cat(sprintf("Based on dictionary of %s items", length(readLines(x$model$dictionary))), sep = "\n")
  cat(sprintf("Top 10 Ripple Down Rules at %s", x$model$rules), sep = "\n")
  cat(head(readLines(x$model$rules, encoding = "UTF-8"), 10), sep = "\n")
  cat(sprintf("..."), sep = "\n")
}


#' @title Part-Of-Speech Tagging for tagging sentences based on Ripple Down Rules
#' @description Part-Of-Speech Tagging for tagging sentences based on Ripple Down Rules
#' @param object And object of class RDRPOSTagger as returned by \code{\link{rdr_model}}
#' @param x a character vector in UTF-8 encoding where each element of the character vector contains only 1 sentence which you like to tag.
#' @param doc_id an identifier of a document with the same length as \code{x}.
#' @param add_space_around_punctuations logical indicating to add a space around punctuations before doing the RDR tagging. Defaults
#' to TRUE as the RDRPOStagger requires this.
#' @return a data frame with fields doc_id, token_id, token, pos where the pos field is the Parts of Speech tag 
#' @seealso \code{\link{rdr_model}}
#' @export
#' @examples
#' x <- c("Dus godvermehoeren met pus in alle puisten, zei die schele van Van Bukburg.", 
#'   "Er was toen dat liedje van tietenkonttieten kont tieten kontkontkont",
#'   "  ", "", NA)
#' tagger <- rdr_model(language = "Dutch", annotation = "MORPH")
#' rdr_pos(tagger, x = x)
#' 
#' tagger <- rdr_model(language = "Dutch", annotation = "UniversalPOS")
#' rdr_pos(tagger, x = x)
#' 
#' \dontrun{
#' x <- c("Oleg Borisovich Kulik is a Ukrainian-born Russian performance artist, 
#'   sculptor, photographer and curator.")
#' tagger <- rdr_model(language = "English", annotation = "POS")
#' rdr_pos(tagger, x = x)
#' }
rdr_pos <- function(object, x, doc_id = paste("d", seq_along(x), sep=""), add_space_around_punctuations=TRUE){
  x <- trimLeadingTrailing(x)
  if(add_space_around_punctuations){
    x <- rdr_add_space_around_punctuations(x)
  }
  x_tagged <- mapply(FUN = function(object, txt, doc){
    rdr_pos_one(object = object, x = txt, doc.id = doc)
  }, 
  txt = x,
  doc = doc_id,
  SIMPLIFY = FALSE, USE.NAMES = FALSE, MoreArgs = list(object = object))
  x_tagged <- rbindlist(x_tagged)
  setDF(x_tagged)
  x_tagged
}

rdr_pos_one <- function(object, x, doc.id){
  if(is.na(x) || x == ""){
    return(data.table(doc.id = doc.id, word.id = 0L, word = NA_character_, word.type = NA_character_))
  }
  wordtags <- object$initialtagger$InitTagger4Sentence(object$dictionary, x)
  size <- wordtags$size()
  if(size == 0){
    return(data.table(doc.id = doc.id, word.id = 0L, word = NA_character_, word.type = NA_character_))
  }
  x <- lapply(0L:(size-1L), FUN=function(i){
    setDT(list(doc.id = doc.id, word.id = i+1L, word = wordtags$get(i)$word, word.type = wordtags$get(i)$tag))
  })
  x <- rbindlist(x)
  Encoding(x$word) <- "UTF-8"
  setcolorder(x, neworder = c("doc.id", "word.id", "word", "word.type"))
  setnames(x, old = c("doc.id", "word.id", "word", "word.type"), new = c("doc_id", "token_id", "token", "pos"))
  x
}

trimLeadingTrailing <- function(x){
  gsub("^([[:space:]])+|([[:space:]])+$", "", x)
}





#' @title Add space around punctuations so that it can be used in \code{rdr_pos}
#' @description Add space around punctuations so that it can be used in \code{rdr_pos}
#' and points/punctuations are not added to 1 specific word/term.
#' @param x a character vector
#' @param symbols a character class of regular expressions to be used to identify punctuation symbols
#' @return the character vector \code{x} where a space is put around punctuations
#' @export
#' @examples
#' x <- c("Dus godvermehoeren met pus in alle puisten, zei die schele van Van Bukburg.Nieuwe zin.", 
#'   "  ", "", NA)
#' rdr_add_space_around_punctuations(x)
rdr_add_space_around_punctuations <- function(x, symbols = "[!,-.:;?]"){
  idx <- which(is.na(x))
  r <- gregexpr(pattern = symbols, text = x)
  rm <- regmatches(x, r)
  regmatches(x, r) <- lapply(rm, FUN=function(x){
    if(length(x) == 0) return(x)
    sprintf(" %s ", x)
  }) 
  x[idx] <- NA
  x
}

