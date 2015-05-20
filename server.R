library(shiny)
library(tm)
library(stringr)
library(RWeka)
library(wordcloud) # for wordcloud
library(tm)
library(NLP)
library(ngram) # for n-grams model
library(qdap) # count word

df_unigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/csv/unigram.csv")
df_bigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/csv/bigram.csv")
df_trigram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/csv/trigram.csv")
df_quagram<-read.csv("C:/Users/stephanie song/Desktop/final/en_US/csv/quagram.csv")
# add prediction function : (bigram, trigra, and quagram)
source("C:/Users/stephanie song/jhucap/model.R")

#create a funtion that can use to identify radiobutton while do the prediction: 
nextword<-function(radiobutton, inputText,input){
        if (input$radiobutton=="bi"){
                predict_bigram(input$text)
        }else if(input$radiobutton=="tri"){
                predict_trigram(input$text)
        }else if(input$radiobutton=="qua"){
                predict_quagram(input$text)
        }}

shinyServer(function(input, output,session) {
        radiobutton<-reactive({input$radiobutton})
        inputText<-reactive({input$text})
        output$textoutput<-renderPrint({
                word<-nextword(radiobutton(),inputText,input)
                word
                })
        wordcloud_rep <- repeatable(wordcloud)
        output$plot <- renderPlot({
                string<-nextword(radiobutton(),inputText,input)
                df<-data.frame(string)
                df$order<-c(nrow(df):1)
                tb<-table(df$string)
                d<-data.frame(word=names(tb), freq=df$order)
                wordcloud_rep(d$word, d$freq, colors=brewer.pal(5,"Set1"),random.order=FALSE)
                
        

                
        })
})