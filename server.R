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


path<-getwd()
df_unigram<-read.csv(paste(path, "/uni.csv", sep=""))
df_bigram <-read.csv(paste(path, "/bi.csv",  sep=""))
df_trigram<-read.csv(paste(path, "/tri.csv", sep=""))
df_quagram<-read.csv(paste(path, "/qua.csv", sep=""))
# add prediction function : (bigram, trigram, and quagram)
#source(paste(path, "/model.R", sep=""))
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
        
        terms<-reactive({
                isolate({
                        withProgress({
                                setProgress(message="Processing corpus...")
                                
                        })
                })
        })
        
        output$textout<-renderPrint({
                word<-nextword(radiobutton(),inputText,input)
                word<-as.data.frame(word)
                msg<-NULL
                for (i in 1:nrow(word)) {
                        line<-paste("Top#", i, "is:" ,word[i,])
                        line<-as.data.frame(line)
                        msg<-rbind(msg, data.frame(line))
                        return(msg)
                }
                #lapply(1:nrow(word), function(i) {
                        #output[[paste0('b', i)]] <- renderUI({
                                #strong(paste0('Top#', i))
                        #})
        })

        
        wordcloud_rep <- repeatable(wordcloud)
        output$plot <- renderPlot({
                string<-nextword(radiobutton(),inputText,input)
                df<-data.frame(string)
                #if (df[1,]=="error"){
                       # par(mar=c(1,1,1,1))
                        #layout(rbind(c(1,1,1),c(2,3,4), c(5,6,7)),
                         #      widths=c(5, 10,10) , heights=c(5, 10,10))
                       # textplot('please enter one or more than one word', cex=2)
               # } else {
                        df$order<-c(nrow(df):1)
                        tb<-table(df$string)
                        d<-data.frame(word=names(tb), freq=df$order)
                        wordcloud_rep(d$word, d$freq, scale=c(4,0.2),colors=brewer.pal(5,"Set1"),random.order=TRUE,max.words=30)
                        
                #}
                
        })
})