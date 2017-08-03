# RDRPOSTagger

R package to perform Parts of Speech tagging and morphological tagging based on the Ripple Down Rules-based Part-Of-Speech Tagger (RDRPOS) available at https://github.com/datquocnguyen/RDRPOSTagger. RDRPOSTagger supports pre-trained POS tagging models for 45 languages.

The R package allows you to perform 3 types of tagging. 

- **UniversalPOS** annotation where a reduced Part of Speech and globally used tagset which is consistent across languages is used to assign words with a certain label. This type of tagging is available for the following languages: **Ancient_Greek, Ancient_Greek-PROIEL, Arabic, Basque, Belarusian, Bulgarian, Catalan, Chinese, Coptic, Croatian, Czech, Czech-CAC, Czech-CLTT, Danish, Dutch, Dutch-LassySmall, English, English-LinES, English-ParTUT, Estonian, Finnish, Finnish-FTB, French, French-ParTUT, French-Sequoia, Galician, Galician-TreeGal, German, Gothic, Greek, Hebrew, Hindi, Hungarian, Indonesian, Irish, Italian, Italian-ParTUT, Japanese, Korean, Latin, Latin-ITTB, Latin-PROIEL, Latvian, Lithuanian, Norwegian-Bokmaal, Norwegian-Nynorsk, Old_Church_Slavonic, Persian, Polish, Portuguese, Portuguese-BR, Romanian, Russian, Russian-SynTagRus, Slovak, Slovenian, Slovenian-SST, Spanish, Spanish-AnCora, Swedish, Swedish-LinES, Tamil, Turkish, Urdu, Vietnamese**. 
- **POS** for doing Parts of Speech annotation based on an extended language/treebank-specific POS tagset. for This type of tagging is available for the following languages: **English, French, German, Hindi, Italian, Thai, Vietnamese**
- **MORPH** with very detailed morphological annotation. This type of tagging is available for the following languages: **Bulgarian, Czech, Dutch, French, German, Portuguese, Spanish, Swedish**

This is based on corpora collected and made available at http://universaldependencies.org.

## Examples on Parts of Speech tagging

The following shows how to use the package

```()
library(RDRPOSTagger)
models <- rdr_available_models()
models$MORPH$language
models$POS$language
models$UniversalPOS$language

x <- c("Oleg Borisovich Kulik is a Ukrainian-born Russian performance artist")
tagger <- rdr_model(language = "English", annotation = "POS")
rdr_pos(tagger, x = x)

x <- c("Dus godvermehoeren met pus in alle puisten, zei die schele van Van Bukburg.", 
       "Er was toen dat liedje van tietenkonttieten kont tieten kontkontkont",
       "  ", "", NA)
tagger <- rdr_model(language = "Dutch", annotation = "MORPH")
rdr_pos(tagger, x = x)

tagger <- rdr_model(language = "Dutch", annotation = "UniversalPOS")
rdr_pos(tagger, x = x)
```

The output of the POS tagging shows the following elements:
```
 doc_id token_id            token   pos
     d1        1              Dus   ADV
     d1        2   godvermehoeren  VERB
     d1        3              met   ADP
     d1        4              pus  NOUN
     d1        5               in   ADP
     d1        6             alle  PRON
     d1        7          puisten  NOUN
     d1        8                , PUNCT
     d1        9              zei  VERB
     d1       10              die  PRON
     d1       11           schele   ADJ
     d1       12              van   ADP
     d1       13              Van PROPN
     d1       14          Bukburg PROPN
     d1       15                . PUNCT
     d2        1               Er   ADV
     d2        2              was   AUX
     d2        3             toen SCONJ
     d2        4              dat SCONJ
     d2        5           liedje  NOUN
     d2        6              van   ADP
     d2        7 tietenkonttieten  VERB
     d2        8             kont PROPN
     d2        9           tieten  VERB
     d2       10     kontkontkont PROPN
     d3        0             <NA>  <NA>
     d4        0             <NA>  <NA>
     d5        0             <NA>  <NA>
```

More information about the model and the tagging can be found at https://github.com/datquocnguyen/RDRPOSTagger

The general architecture and experimental results of RDRPOSTagger can be found in the following papers:

- Dat Quoc Nguyen, Dai Quoc Nguyen, Dang Duc Pham and Son Bao Pham. [RDRPOSTagger: A Ripple Down Rules-based Part-Of-Speech Tagger](http://www.aclweb.org/anthology/E14-2005). In *Proceedings of the Demonstrations at the 14th Conference of the European Chapter of the Association for Computational Linguistics*, EACL 2014, pp. 17-20, 2014. [[.PDF]](http://www.aclweb.org/anthology/E14-2005) [[.bib]](http://www.aclweb.org/anthology/E14-2005.bib)

- Dat Quoc Nguyen, Dai Quoc Nguyen, Dang Duc Pham and Son Bao Pham. [A Robust Transformation-Based Learning Approach Using Ripple Down Rules for Part-Of-Speech Tagging](http://content.iospress.com/articles/ai-communications/aic698). *AI Communications* (AICom), vol. 29, no. 3, pp. 409-422, 2016. [[.PDF]](http://arxiv.org/pdf/1412.4021.pdf) [[.bib]](http://rdrpostagger.sourceforge.net/AICom.bib)


## Installation

Installation can easily be done as follows.

```
install.packages("rJava")
install.packages("data.table")
install.packages("RDRPOSTagger", repos = "http://www.datatailor.be/rcube", type = "source")
```

Or with devtools

```
devtools::install_github("bnosac/RDRPOSTagger", build_vignettes = TRUE)
```

More details in the package documentation and package vignette

```
vignette("rdrpostagger-overview", package = "RDRPOSTagger")
```


## License

The package is licensed under the GPL-3 license as described at http://www.gnu.org/licenses/gpl-3.0.html.



## Support in text mining

Need support in text mining. 
Contact BNOSAC: http://www.bnosac.be