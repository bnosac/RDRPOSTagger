####Pre-trained Universal POS tagging models for 40 languages

The models are learned using the training data from <a href="http://universaldependencies.org/" target="_blank">the Universal Dependencies (UD) project</a> (version 1.3). The tagging accuracies on the UD v1.3 test sets are as follows:

UD_Ancient_Greek : 91.5686507465

UD_Ancient_Greek-PROIEL : 95.7193816885

UD_Arabic : 94.414521

UD_Basque : 92.4263559531

UD_Bulgarian : 96.1294012966

UD_Catalan : 96.5174210621

UD_Chinese : 89.4522144522

UD_Croatian : 93.8666666667

UD_Czech : 97.676954331

UD_Czech-CAC : 97.8256880734

UD_Czech-CLTT : 97.008027244

UD_Danish : 93.4738273283

UD_Dutch : 88.7557761424

UD_Dutch-LassySmall : 94.3665059185

UD_English : 92.7040165763

UD_English-LinES : 94.399245372

UD_Estonian : 93.8360794254

UD_Finnish : 92.2428884026

UD_Finnish-FTB : 90.9631537

UD_French : 95.2288488211

UD_Galician : 96.3053855981

UD_German : 90.3972909234

UD_Gothic : 93.854207057

UD_Greek : 96.8595624559

UD_Hebrew : 93.5171584991

UD_Hindi : 95.0239909681

UD_Hungarian : 88.6894923259

UD_Indonesian : 90.7470288625

UD_Irish : 90.6045537817

UD_Italian : 96.4843416674

UD_Kazakh : 79.2207792208

UD_Latin : 90.3973509934

UD_Latin-ITTB : 98.2437385461

UD_Latin-PROIEL : 95.786931437

UD_Latvian : 86.3488080301

UD_Norwegian : 94.602783512

UD_Old_Church_Slavonic : 94.6249261666

UD_Persian : 95.9982628118

UD_Polish : 94.0848990953

UD_Portuguese : 95.0814436282

UD_Portuguese-BR : 95.0879815205

UD_Romanian : 94.5197278912

UD_Russian-SynTagRus : 97.6535452073

UD_Slovenian : 94.0268790443

UD_Slovenian-SST : 91.1555404947

UD_Spanish : 95.1279527559

UD_Spanish-AnCora : 96.7886891714

UD_Swedish : 94.3956421456

UD_Swedish-LinES : 94.4701020904

UD_Tamil : 82.0888685295

UD_Turkish : 91.9262341167

Noted that the accuracy is obtained with a weak initial tagger (The internal initial tagger developed inside RDRPOSTagger is simply based on a lexicon extracted from the training set). It is likely to obtain higher results with a stronger external initial tagger such as <a href="http://www.coli.uni-saarland.de/~thorsten/tnt/" target="_blank">the TnT tagger</a>.
