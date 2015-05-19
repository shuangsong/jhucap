#based on ngram markov model: 
#unigram: predict next word with previous one word, random predict.
#bigram: predict next word based on previous one word
#trigram: predict next word based on previous two words
#quadgram: predict next word based on previous three words

library(ggplot2)
library(NLP) # for natural language processing
library(stringr) # package for handling string in R
library(R.utils) # ultils to count lines
library(SnowballC) # for steming words.
library(RWeka) #for n-gram model
library(ngram) # for n-grams model
library(qdap) # count word
library(stringi) # use to count lines fast 
library(pryr) # to see file size with command object_size
library(wordcloud) # for wordcloud
library(tm)
#read in data frame csv files: 


df_unigram<-read.csv("C:/Users/stephanie song/Desktop/unigram.csv")
df_bigram<-read.csv("C:/Users/stephanie song/Desktop/bigram.csv")
df_trigram<-read.csv("C:/Users/stephanie song/Desktop/trigram.csv")
df_quagram<-read.csv("C:/Users/stephanie song/Desktop/quagram.csv")


# add prediction function : (bigram, trigra, and quagram)
predict_bigram<- function(input) {
        if (sapply(gregexpr("\\S+", input), length)<=1){
                return("please enter more than one word")
        }else {
        input1<-tolower(input)
        input2<-str_replace_all(input1, pattern="[[:punct:]]","") #remove punctuations
        input3<-str_replace_all(input2, pattern="\\s+", " ") # replace whitespace with space
        input_clean<-removeNumbers(input3) 
        clean_tail<-tail(unlist(strsplit(input_clean, " ")), 1)
        start_with_term<-paste("^","\\b", clean_tail,"\\b", sep="")
        find<-df_bigram[grep(start_with_term, df_bigram$terms),]
        if (nrow(find)==0) {
                uni<-df_unigram[sample(nrow(df_unigram),nrow(df_unigram)/1000,replace=TRUE,prob=NULL),]
                uni<-head(uni)
                term<-as.character(uni$terms)
                return(term)
        }
        find<-df_bigram[grep(start_with_term, df_bigram$terms),]
        merge<-NULL
        find$terms<-as.character(find$terms)
        find_mat<-matrix(unlist(strsplit(find$terms, " ")), ncol=2, byrow=TRUE)
        find$pred<-find_mat[,2]
        find2<-df_unigram[grep(paste("^","\\b", clean_tail,"\\b", sep=""), df_unigram$terms),]
        if (nrow(find2)==0){
                warning("There is no prediction")
                return()
        }
        find2<-data.frame(find2)
        for (i in 1: nrow(find)) {
                new_find<-data.frame("pred"=find[i,3], "pred_prob"=find[i,2]/find2[1,2])
                merge<-rbind(merge, data.frame(new_find))
        }
        high_prob<-merge[order(-merge$pred_prob),]
        high_prob<-head(high_prob,10)
        possible_term<-as.character(high_prob$pred)
        return(possible_term)
}}
#try
predict_bigram("how do you know last")
predict_bigram("first")
predict_bigram("nice weather")
predict_bigram("what the hell")
predict_bigram("how are you the")
predict_bigram("what the hell")
predict_bigram("we went to the orlando")






predict_trigram<-function(input){
        if (sapply(gregexpr("\\S+", input), length)<=1){
                return("please enter more than one word")
        }else {
                input1<-tolower(input)
                input2<-str_replace_all(input1, pattern="[[:punct:]]","") 
                input3<-str_replace_all(input2, pattern="\\s+", " ") 
                input_clean<-removeNumbers(input3) 
                clean_tail<-tail(unlist(strsplit(input_clean, " ")), 2)
                words<-paste(clean_tail[1], clean_tail[2], sep=" ")
                start_with_term<-paste("^","\\b", words,"\\b", sep="")
                find<-df_trigram[grep(start_with_term, df_trigram$terms),]
                if (nrow(find)==0) {
                        clean_tail2<-tail(unlist(strsplit(input_clean, " ")), 1)
                        start_with_term2<-paste("^","\\b", clean_tail2,"\\b", sep="")
                        find2<-df_bigram[grep(start_with_term2, df_bigram$terms),] 
                        
                        if (nrow(find2)==0){
                                uni<-df_unigram[sample(nrow(df_unigram),nrow(df_unigram)/1000,replace=FALSE,prob=NULL),]
                                uni<-head(uni)
                                term<-as.character(uni$terms)
                                return(term)
                                }
                        find2<-head(find2,10)
                        find2$terms<-as.character(find2$terms)
                        find_mat<-matrix(unlist(strsplit(find2$terms, " ")), ncol=2, byrow=TRUE)
                        find2$pred<-find_mat[,2]
                        terms<-as.character(find2$pred)
                        return(terms)
                
                }
                merge<-NULL
                find$terms<-as.character(find$terms)
                find_mat<-matrix(unlist(strsplit(find$terms, " ")), ncol=3, byrow=TRUE)
                find$pred<-find_mat[,3]
                clean_tail3<-tail(unlist(strsplit(input_clean, " ")), 2)
                words2<-paste(clean_tail3[1], clean_tail3[2], sep=" ")
                find3<-df_bigram[grep(paste("^","\\b",words2,"\\b", "$",sep=""), df_bigram$terms),]
               
                for (i in 1: nrow(find)) {
                        new_find<-data.frame("pred"=find[i,3], "pred_prob"=find[i,2]/find3[1,2])
                        merge<-rbind(merge, data.frame(new_find))
                }
                high_prob<-merge[order(-merge$pred_prob),]
                high_prob<-head(high_prob,10)
                possible_term<-as.character(high_prob$pred)
                return(possible_term)
        }}

predict_trigram("we went to new york")
predict_trigram("happi mother")
predict_trigram("a case of the")
predict_trigram("we want use")
predict_trigram("data science course")
predict_trigram("i want some milk")
predict_trigram("there is a coffee")
predict_trigram("i want some baccon and beer")





predict_quagram<-function(input){
        if (sapply(gregexpr("\\S+", input), length)<=1){
                return("please enter more than one word")
        }else {
                input1<-tolower(input)
                input2<-str_replace_all(input1, pattern="[[:punct:]]","") 
                input3<-str_replace_all(input2, pattern="\\s+", " ") 
                input_clean<-removeNumbers(input3) 
                clean_tail<-tail(unlist(strsplit(input_clean, " ")), 3)
                words<-paste(clean_tail[1], clean_tail[2],clean_tail[3], sep=" ")
                start_with_term<-paste("^","\\b",words,"\\b", sep="")
                find<-df_quagram[grep(start_with_term, df_quagram$terms),]
                if (nrow(find)==0) {
                        clean_tail2<-tail(unlist(strsplit(input_clean, " ")), 2)
                        words2<-paste(clean_tail2[1], clean_tail2[2], sep=" ")
                        start_with_term2<-paste("^","\\b", words2,"\\b", sep="")
                        find2<-df_trigram[grep(start_with_term2, df_trigram$terms),]
                        
                        if(nrow(find2)==0){
                                clean_tail3<-tail(unlist(strsplit(input_clean, " ")), 1)
                                start_with_term3<-paste("^","\\b", clean_tail3,"\\b", sep="")
                                find3<-df_bigram[grep(start_with_term3, df_bigram$terms),] 
                                 
                                if(nrow(find3)==0){
                                        uni<-df_unigram[sample(nrow(df_unigram),nrow(df_unigram)/1000,replace=FALSE,prob=NULL),]
                                        uni<-head(uni)
                                        single<-as.character(uni$terms)
                                        return(single)
                                }
                                find3<-head(find3,10)
                                
                                terms<-as.character(find3$terms)
                                return(terms)
                                
                        }
                        find2<-head(find2,10)
                       
                        term<-as.character(find2$terms)
                        return(term)
                }
                
                merge<-NULL
                find$terms<-as.character(find$terms)
                find_mat<-matrix(unlist(strsplit(find$terms, " ")), ncol=4, byrow=TRUE)
                find$pred<-find_mat[,4]
                clean_tail4<-tail(unlist(strsplit(input_clean, " ")), 3)
                words4<-paste(clean_tail4[1], clean_tail4[2],clean_tail4[3], sep=" ")
                find4<-df_trigram[grep(paste("^","\\b", words4,"\\b", "$",sep=""), df_trigram$terms),]
                if (nrow(find4)==0) {
                        
                                clean_tail2<-tail(unlist(strsplit(input_clean, " ")), 2)
                                words2<-paste(clean_tail2[1], clean_tail2[2], sep=" ")
                                start_with_term2<-paste("^","\\b", words2,"\\b", sep="")
                                find2<-df_trigram[grep(start_with_term2, df_trigram$terms),]
                                
                                if(nrow(find2)==0){
                                        clean_tail3<-tail(unlist(strsplit(input_clean, " ")), 1)
                                        start_with_term3<-paste("^","\\b", clean_tail3,"\\b", sep="")
                                        find3<-df_bigram[grep(start_with_term3, df_bigram$terms),] 
                                        
                                        if(nrow(find3)==0){
                                                uni<-df_unigram[sample(nrow(df_unigram),nrow(df_unigram)/1000,replace=FALSE,prob=NULL),]
                                                uni<-head(uni)
                                                single<-as.character(uni$terms)
                                                return(single)
                                        }
                                        find3<-head(find3,10)
                                        find_mat3<-matrix(unlist(strsplit(find3$terms, " ")), ncol=2, byrow=TRUE)
                                        find3$pred<-find_mat3[,2]
                                        terms<-as.character(find3$pred)
                                        return(terms)
                                        
                                }
                                find2<-head(find2,10)
                                find_mat2<-matrix(unlist(strsplit(find2$terms, " ")), ncol=3, byrow=TRUE)
                                find2$pred<-find_mat[,3]
                                term<-as.character(find2$pred)
                                return(term)
                        }
                
                for (i in 1: nrow(find)) {
                        new_find<-data.frame("pred"=find[i,4], "pred_prob"=find[i,2]/find4[1,2])
                        merge<-rbind(merge, data.frame(new_find))
                }
                high_prob<-merge[order(-merge$pred_prob),]
                possible_term<-as.character(high_prob$pred)
                return(possible_term)
        }}

predict_quagram("we go to see south carolina gamecock")
predict_quagram("we went to new york")
predict_quagram("how cold is your family   ")
predict_quagram("i want some baccon and beer")