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
  available$MORPH <- file_path_sans_ext(list.files(system.file("Models", "MORPH", package = "RDRPOSTagger"), pattern = ".DICT$|.RDR$"))
  available$POS <- file_path_sans_ext(list.files(system.file("Models", "POS", package = "RDRPOSTagger"), pattern = ".DICT$|.RDR$"))
  available$UniversalPOS <- file_path_sans_ext(list.files(system.file("Models", "UniPOS", package = "RDRPOSTagger")))
  available$UniversalPOS <- setdiff(available$UniversalPOS, c("Readme", "UDv1.3_results"))
  available <- lapply(available, unique)
  available$MORPH <- data.frame(language = available$MORPH,
                                dictionary = system.file("Models", "MORPH", sprintf("%s.DICT", available$MORPH), package = "RDRPOSTagger"),
                                rules = system.file("Models", "MORPH", sprintf("%s.RDR", available$MORPH), package = "RDRPOSTagger"),
                                stringsAsFactors = FALSE)
  available$POS <- data.frame(language = available$POS,
                              dictionary = system.file("Models", "POS", sprintf("%s.DICT", available$POS), package = "RDRPOSTagger"),
                              rules = system.file("Models", "POS", sprintf("%s.RDR", available$POS), package = "RDRPOSTagger"),
                              stringsAsFactors = FALSE)
  available$UniversalPOS <- data.frame(language = available$UniversalPOS,
                                       dictionary = sapply(available$UniversalPOS, FUN=function(loc) list.files(system.file("Models", "UniPOS", loc, package = "RDRPOSTagger"), pattern = "\\.DICT$", full.names=TRUE)),
                                       rules = sapply(available$UniversalPOS, FUN=function(loc) list.files(system.file("Models", "UniPOS", loc, package = "RDRPOSTagger"), pattern = "\\.RDR$", full.names=TRUE)),
                                       stringsAsFactors = FALSE)
  available
}


#' @title Set up a Ripple Down Rules-based Part-Of-Speech Tagger for tagging sentences
#' @description Set up a Ripple Down Rules-based Part-Of-Speech Tagger for tagging sentences
#' Possible languages are:
#' \itemize{
#'  \item{MORPH: }{Bulgarian, Czech, Dutch, French, German, Portuguese, Spanish, Swedish}
#'  \item{POS: }{English, French, German, Hindi, Italian, Thai, Vietnamese}
#'  \item{UniversalPOS: }{UD_Ancient_Greek, UD_Ancient_Greek-PROIEL, UD_Arabic, UD_Basque, UD_Belarusian, 
#'  UD_Bulgarian, UD_Catalan, UD_Chinese, UD_Coptic, UD_Croatian, UD_Czech, UD_Czech-CAC, UD_Czech-CLTT, 
#'  UD_Danish, UD_Dutch, UD_Dutch-LassySmall, UD_English, UD_English-LinES, UD_English-ParTUT, UD_Estonian, 
#'  UD_Finnish, UD_Finnish-FTB, UD_French, UD_French-ParTUT, UD_French-Sequoia, UD_Galician, UD_Galician-TreeGal, 
#'  UD_German, UD_Gothic, UD_Greek, UD_Hebrew, UD_Hindi, UD_Hungarian, UD_Indonesian, UD_Irish, UD_Italian, 
#'  UD_Italian-ParTUT, UD_Japanese, UD_Korean, UD_Latin, UD_Latin-ITTB, UD_Latin-PROIEL, UD_Latvian, UD_Lithuanian, 
#'  UD_Norwegian-Bokmaal, UD_Norwegian-Nynorsk, UD_Old_Church_Slavonic, UD_Persian, UD_Polish, UD_Portuguese, 
#'  UD_Portuguese-BR, UD_Romanian, UD_Russian, UD_Russian-SynTagRus, UD_Slovak, UD_Slovenian, UD_Slovenian-SST, 
#'  UD_Spanish, UD_Spanish-AnCora, UD_Swedish, UD_Swedish-LinES, UD_Tamil, UD_Turkish, UD_Urdu, UD_Vietnamese}
#' }
#' @param language the language which is one of the languages for the annotation shown in \code{\link{rdr_available_models}}
#' @param annotation the type of annotation. Either one of 'MORPH', "POS' or 'UniversalPOS'
#' @param available_models a list of available models as returned by \code{\link{rdr_available_models}}
#' @return An object of class RDRPOSTagger which is a list with elements model (the location of the dictionary and the rules of that language),
#' the type of annotation and java objects tagger, initialtagger, dictionary and utility.
#' This model object can be used to tag sentences based on the specified POS tags.
#' @seealso \code{\link{rdr_model}}
#' @export
#' @examples
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
#' tagger <- rdr_model(language = "UD_Ancient_Greek", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Ancient_Greek-PROIEL", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Arabic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Basque", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Belarusian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Bulgarian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Catalan", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Chinese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Coptic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Croatian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Czech", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Czech-CAC", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Czech-CLTT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Danish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Dutch", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Dutch-LassySmall", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_English", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_English-LinES", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_English-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Estonian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Finnish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Finnish-FTB", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_French", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_French-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_French-Sequoia", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Galician", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Galician-TreeGal", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_German", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Gothic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Greek", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Hebrew", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Hindi", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Hungarian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Indonesian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Irish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Italian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Italian-ParTUT", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Japanese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Korean", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Latin", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Latin-ITTB", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Latin-PROIEL", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Latvian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Lithuanian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Norwegian-Bokmaal", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Norwegian-Nynorsk", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Old_Church_Slavonic", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Persian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Polish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Portuguese", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Portuguese-BR", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Romanian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Russian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Russian-SynTagRus", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Slovak", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Slovenian", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Slovenian-SST", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Spanish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Spanish-AnCora", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Swedish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Swedish-LinES", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Tamil", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Turkish", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Urdu", annotation = "UniversalPOS")
#' tagger <- rdr_model(language = "UD_Vietnamese", annotation = "UniversalPOS")
rdr_model <- function(language,
                      annotation = c("MORPH", "POS", "UniversalPOS"),
                      available_models = rdr_available_models()){
  ## Check if model exists
  annotation <- match.arg(annotation)
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
  cat(head(readLines(x$model$rules), 10), sep = "\n")
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
#' tagger <- rdr_model(language = "UD_Dutch", annotation = "UniversalPOS")
#' rdr_pos(tagger, x = x)
#' 
#' x <- c("Oleg Borisovich Kulik is a Ukrainian-born Russian performance artist, 
#'   sculptor, photographer and curator.")
#' tagger <- rdr_model(language = "English", annotation = "POS")
#' rdr_pos(tagger, x = x)
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
#' @return the character vector \code{x} where a space is put around punctuations
#' @export
#' @examples
#' x <- c("Dus godvermehoeren met pus in alle puisten, zei die schele van Van Bukburg.Nieuwe zin.", 
#'   "  ", "", NA)
#' rdr_add_space_around_punctuations(x)
rdr_add_space_around_punctuations <- function(x){
  idx <- which(is.na(x))
  r <- gregexpr(pattern = "[[:punct:]]", text = x)
  rm <- regmatches(x, r)
  regmatches(x, r) <- lapply(rm, FUN=function(x){
    if(length(x) == 0) return(x)
    sprintf(" %s ", x)
  }) 
  x[idx] <- NA
  x
}