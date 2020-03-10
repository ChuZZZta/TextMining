#zaladowanie bibliotek
library(tm)
#zmiana katalog roboczego
wordDir <- "D:\\DD\\TextMinig11S"
setwd(wordDir)

#definicj katalogów funkcjynych
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspaceDir <- ".\\workspaces"
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspaceDir, showWarnings = FALSE)


#utworzenie korpusu dokumentow
corpusDiir <- paste(inputDir,"Literatura - streszczenia - oryginal", sep="\\")
corpus <- VCorpus(
  DirSource(
    corpusDiir, 
    pattern = "*.txt", 
    encoding = "UTF-8"),
  readerControl = list(language="pl_PL"))

#wstepne przetwarzainie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stopListFile <- paste(inputDir,"stopwords_pl.txt", sep="\\")
stopList <- readLines(stopListFile, encoding = "UTF-8")
corpus <- tm_map(corpus, removeWords,stopList)
corpus <- tm_map(corpus, stripWhitespace)

#wyswietlenie zawartosci pojedynczego dokument
writeLines(as.character(corpus[[1]]))
writeLines(corpus[[1]]$content)