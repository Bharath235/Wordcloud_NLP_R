library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

ckey <- '_________________________'         
skey <- '_________________________'
token <- '_________________________'
sectoken <- '_________________________'

setup_twitter_oauth(ckey,skey,token,sectoken)
soccer.tweets <- searchTwitter('transfer', n=1000, lang = 'en')

soccer.text <- sapply(soccer.tweets, function(x) x$getText())

soccer.text <- iconv(soccer.text, 'UTF-8', 'ASCII')
soccer.corpus <- Corpus(VectorSource(soccer.text))

term.doc.matrix <- TermDocumentMatrix(soccer.corpus, control = list(removePunctuation=T, stopwords=c('transfer','window','http',stopwords('english')), removeNumbers=T,tolower=T))

term.doc.matrix <- as.matrix(term.doc.matrix)

word.freq <- sort(rowSums(term.doc.matrix), decreasing=T)
dm <- data.frame(word=names(word.freq), freq=word.freq)

wordcloud(dm$word, dm$freq, random.order=F, colors=brewer.pal(8,'Dark2'))


