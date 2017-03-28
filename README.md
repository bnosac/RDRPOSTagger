# RDRPOSTagger

R package to perform Parts of Speech tagging and morphological tagging based on the Ripple Down Rules-based Part-Of-Speech Tagger (RDRPOS) available at https://github.com/datquocnguyen/RDRPOSTagger. Tagging models include Bulgarian, Czech, Dutch, English, French, German, Hindi, Italian, Portuguese, Spanish, Swedish, Thai and Vietnamese. RDRPOSTagger also supports the pre-trained Universal POS tagging models for 40 languages.

- **MORPH** annotation for languages: **Bulgarian, Czech, Dutch, French, German, Portuguese, Spanish, Swedish**
- **POS** annotation for languages: **English, French, German, Hindi, Italian, Thai, Vietnamese**
- **UniversalPOS** annotation for languages: **Ancient_Greek, Ancient_Greek-PROIEL, Arabic, Basque, Bulgarian, Catalan, Chinese, Croatian, Czech, Czech-CAC, Czech-CLTT, Danish, Dutch, Dutch-LassySmall, English, English-LinES, Estonian, Finnish, Finnish-FTB, French, Galician, German, Gothic, Greek, Hebrew, Hindi, Hungarian, Indonesian, Irish, Italian, Kazakh, Latin, Latin-ITTB, Latin-PROIEL, Latvian, Norwegian, Old_Church_Slavonic, Persian, Polish, Portuguese, Portuguese-BR, Romanian, Russian-SynTagRus, Slovenian, Slovenian-SST, Spanish, Spanish-AnCora, Swedish, Swedish-LinES, Tamil, Turkish**. Prepend the UD_ to the language if you want to used these models.

## Examples on Parts of Speech tagging

The following shows how to use the package

```()
library(RDRPOSTagger)
rdr_available_models()

x <- c("Oleg Borisovich Kulik is a Ukrainian-born Russian performance artist")
tagger <- rdr_model(language = "English", annotation = "POS")
rdr_pos(tagger, x = x)

x <- c("Dus godvermehoeren met pus in alle puisten, zei die schele van Van Bukburg.", 
       "Er was toen dat liedje van tietenkonttieten kont tieten kontkontkont",
       "  ", "", NA)
tagger <- rdr_model(language = "Dutch", annotation = "MORPH")
rdr_pos(tagger, x = x)

tagger <- rdr_model(language = "UD_Dutch", annotation = "UniversalPOS")
rdr_pos(tagger, x = x)
```

The output of the POS tagging shows the following elements:
```
 sentence.id word.id             word word.type
           1       1              Dus       ADV
           1       2   godvermehoeren      VERB
           1       3              met       ADP
           1       4              pus      NOUN
           1       5               in       ADP
           1       6             alle      PRON
           1       7         puisten,      NOUN
           1       8              zei      VERB
           1       9              die      PRON
           1      10           schele       ADJ
           1      11              van       ADP
           1      12              Van     PROPN
           1      13         Bukburg.     PROPN
           2       1               Er       ADV
           2       2              was       AUX
           2       3             toen     SCONJ
           2       4              dat     SCONJ
           2       5           liedje      NOUN
           2       6              van       ADP
           2       7 tietenkonttieten      VERB
           2       8             kont     PROPN
           2       9           tieten      VERB
           2      10     kontkontkont     PROPN
           3       0             <NA>      <NA>
           4       0             <NA>      <NA>
           5       0             <NA>      <NA>
```

More information about the model and the tagging can be found at https://github.com/datquocnguyen/RDRPOSTagger

## Installation

Installation can easily be done as follows.

```
install.packages("devtools")
install.packages("rJava")
install.packages("data.table")
devtools::install_github("bnosac/RDRPOSTagger")
```

## License

The package is licensed under the GPL-3 license as described at http://www.gnu.org/licenses/gpl-3.0.html.


## Support in text mining

Need support in text mining. 
Contact BNOSAC: http://www.bnosac.be