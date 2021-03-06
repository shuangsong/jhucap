rm(list=ls())
data_path<-paste(getwd(),"/final/en_US", sep="")
setwd(data_path)
#package I use to do this project:
library(knitr) # for knit html
library(ggplot2) # for ggplot2 plotting
library(NLP) # for natural language processing
library(stringr) # package for handling string in R
library(qdap) # count word
library(stringi) # use to count lines fast 
library(pryr) # to see file size with command object_size
library(ngram)
library(wordcloud) # for visualization 
library(tm)
library(slam) #rollup
library(SnowballC)
#read in the data and read several lines of data:
con_twitts<- file("en_US.twitter.txt",open="rb") 
con_news<- file("en_US.news.txt", open="rb") 
con_blogs<- file("en_US.blogs.txt", open="rb")
#use readlines to store content : 
twitts<-readLines(con_twitts,encoding="UTF-8",warn=FALSE)
news<-readLines(con_news,encoding="UTF-8")
blogs<-readLines(con_blogs,encoding="UTF-8")
#close connection: 
close(con_twitts)
close(con_news)
close(con_blogs)


ran_twitts<-sample(twitts, 30000, replace=FALSE)
ran_news<-sample(news, 30000, replace=FALSE)
ran_blogs<-sample(blogs, 30000, replace=FALSE)
all<-paste(ran_twitts, ran_news, ran_blogs)



#function to clean corpus , get dtm.
#tokenization : create corpus 
clean<-function(all){
        all<-gsub("can't"," can not", all) 
        all<-gsub("n't", " not", all)   #expand words contractions 
        all<-gsub("'ve"," have", all)
        all<-gsub("'m|’m"," am", all)
        all<-gsub("'ll"," will", all)
        all<-gsub("'s|’s"," is", all)
        all<-gsub(":m","m",all)  # p:m 
        all<-gsub("u.s.","us",all)
        all<-gsub("'re"," are",all)
        all<-gsub("'d|’d"," had",all)
        all<-gsub("N.Y."," NY", all)
        all<-gsub("[0-9]", "", all)
        all<-gsub("“|”|’|‘", " ", all)
        all<-gsub("[[:punct:]]+", " ", all)
        all<-gsub("\u0092|\u0093|\u0094|\u0090","",all)
        all<-gsub("^u$|^U$", "you", all)
        all<-gsub("\\W"," ",all)  #remove not word
        all<-gsub("[^[:alpha:] ]","",all)
        all<-tolower(all)
        corp<-VCorpus(VectorSource(all),readerControl=list(language='UTF-8'))
        my_corp<-tm_map(corp, removePunctuation)
        my_corp<-tm_map(my_corp, stripWhitespace)
        my_corp<-tm_map(my_corp, content_transformer(removeNumbers))
        my_corp<-tm_map(my_corp, content_transformer(tolower)) #convert to lower case
        my_corp<-tm_map(my_corp, removeWords, stopwords("english"))
        profane_path<-paste(getwd(), "/profane.txt",sep="")
        my_corp<-tm_map(my_corp, removeWords, profane_path)
        my_corp<-tm_map(corp, PlainTextDocument)
        return(my_corp)
        #corp_copy<- my_corp
        #my_corp<-tm_map(my_corp, stemDocument)
        #stm<-wordStem(my_corp)
        #stemmer_corp<-stemCompletion(my_corp, corp_copy, "prevalent")
        #stemmer<-tm_map(my_corp, stemCompletion, dictionary=corp_copy)
        #stemming
}
        
        
clean(all)

gc(reset=TRUE)
options(mc.cores=1)
library(tm)
library(RWeka)
UnigramTokenizer<-function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer<-function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer<-function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadgramTokenizer<-function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

tdm_unigram<-TermDocumentMatrix(clean(all), control = list(tokenize = UnigramTokenizer))
tdm_bigram<-TermDocumentMatrix(clean(all), control = list(tokenize = BigramTokenizer))
tdm_trigram<-TermDocumentMatrix(clean(all), control = list(tokenize = TrigramTokenizer))
tdm_quagram<-TermDocumentMatrix(clean(all), control = list(tokenize = QuadgramTokenizer))


df<-function(tdm){
        mat<-as.matrix(rollup(tdm, 2, FUN=sum))
        dframe<-sort(rowSums(mat), decreasing=TRUE)
        df_ngram<-data.matrix(dframe)
        myDF <- cbind(terms= rownames(df_ngram), df_ngram)
        row.names(myDF) <- NULL
        colnames(myDF) <- NULL
        colnames(myDF) <- c("terms", "count")
        dataframe<-as.data.frame(myDF)
        dataframe$terms<-as.character(dataframe$terms)
        dataframe$count<-as.numeric(dataframe$count)
        return(dataframe)
        
}

df_unigram<-df(tdm_unigram)
df_bigram<-df(tdm_bigram)
df_trigram<-df(tdm_trigram)
df_quagram<-df(tdm_quagram)

head(df_unigram)
head(df_bigram)
#write csv

write.csv(df_unigram, file="C:/Users/stephanie song/Desktop/uni.csv")
write.csv(df_bigram, file="C:/Users/stephanie song/Desktop/bi.csv")
write.csv(df_trigram, file="C:/Users/stephanie song/Desktop/tri.csv")
write.csv(df_quagram, file="C:/Users/stephanie song/Desktop/qua.csv")


#write Rdata


save(df_unigram, file="C:/Users/stephanie song/Desktop/uni.Rdata")
save(df_bigram, file="C:/Users/stephanie song/Desktop/bi.Rdata")
save(df_trigram, file="C:/Users/stephanie song/Desktop/tri.Rdata")
save(df_quagram, file="C:/Users/stephanie song/Desktop/qua.Rdata")























#try
try<-"we've been to u.s. ---&^%%% I'm so happy and we'd like to he's / cat. ..."
all<-gsub("n't"," not", all) #expand words contractions 
all<-gsub("'ve"," have", all)
all<-gsub("'m|’m"," am", all)
all<-gsub("'ll"," will", all)
all<-gsub("'s|’s"," is", all)
all<-gsub(":m","m",all)  # p:m 
all<-gsub("u.s.","us",all)
all<-gsub("'re"," are",all)
all<-gsub("'d|’d"," had",all)
all<-gsub("N.Y."," NY", all)
all<-gsub("[0-9]", "", all)
all<-gsub("“|”|’|‘", " ", all)
all<-gsub("[[:punct:]]+", " ", all)
all<-gsub("\u0092|\u0093|\u0094|\u0090","",all)
all<-gsub("^u$|^U$", "you", all)
all<-gsub("\\W"," ",all)  #remove not word
all<-gsub("[^[:alpha:] ]","",all)
all<-tolower(all)