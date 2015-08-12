library(shiny)
library(tm)
library(stringr)
library(RWeka)
library(wordcloud) # for wordcloud
library(tm)
library(NLP)
library(ngram) # for n-grams model
library(qdap) # count word
library(caroline) # plot text only plot


df_unigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/data/uni.csv")
df_bigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/data/bi.csv")
df_trigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/data/tri.csv")
df_quagram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/data/qua.csv")
#df_unigram<-load('C:/Users/stephanie song/Desktop/final/en_US/data/uni.Rdata',.GlobalEnv)
#df_bigram<-load('C:/Users/stephanie song/Desktop/final/en_US/data/bi.Rdata',.GlobalEnv)
#df_trigram<-load('C:/Users/stephanie song/Desktop/final/en_US/data/tri.Rdata',.GlobalEnv)
#df_quagram<-load('C:/Users/stephanie song/Desktop/final/en_US/data/qua.Rdata',.GlobalEnv)

# add prediction function : (bigram, trigram, and quagram)

source(paste(path, "/model_wordcloud.R", sep=""))
#create a funtion that can use to identify radiobutton while do the prediction: 


nextword<-function(radiobutton, inputText,input){
        if (input$radiobutton=="bi"){
                predict_bi(input$text)
        }else if(input$radiobutton=="tri"){
                predict_tri(input$text)
        }else if(input$radiobutton=="qua"){
                predict_qua(input$text)
        }
}


shinyServer(function(input, output,session) {
        radiobutton<-reactive({input$radiobutton})
        inputText<-reactive({input$text})
        
        #terms<-reactive({
                #isolate({
                        #withProgress({
                                #setProgress(message="Processing corpus...")
                                
                        #})
                #})
        #})
        
        output$textout<-renderTable({
                predictions<-nextword(radiobutton(),inputText,input)
                df<-as.data.frame(predictions)
                #msg<-NULL
                #for (i in 1:nrow(df)) {
                        #prediction<-paste("Top#", i, "is:" ,df[i,1])
                        #msg<-rbind(msg, data.frame(prediction))
                        
                        
                #}
                return(df)
        })
        
        
        #wordcloud_rep <- repeatable(wordcloud)
        #output$wordcloud <- renderPlot({
                #word<-nextword(radiobutton(),inputText,input)
                #df<-data.frame(word)
                #df$order<-c(nrow(df):1)
                #tb<-table(df$string)
                #d<-data.frame(word=df$word, freq=df$order)
                #wordcloud_rep(d$word, d$freq, max.words=30,scale=c(4,0.2),colors=brewer.pal(5,"Set1"))
                
                
        #})
})