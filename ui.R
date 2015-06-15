library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme = shinytheme("cerulean"),
        navbarPage("JHU Capstone project shiny app-NLP in R",inverse = FALSE, collapsible = FALSE,
                   tabPanel("page1-ngram prediction",(includeScript("look.js")),
                            sidebarLayout(
                                    sidebarPanel(
                                            
                                            textInput("text", label=h3("Text input:"),value = ""),
                                            helpText("Input a sentence and click update button"),
                                            radioButtons("radiobutton", label=h3("ngram-prediction:"),
                                                         choice=list("Bigram prediction"="bi",
                                                                     "Trigram prediction"="tri",
                                                                     "Quadgram prediction"="qua")),
                                            br(),
                                            submitButton("Update"),
                                            helpText(h5("Note:")),
                                            helpText("1, Input a sentence", style="color:#BF3EFF"),
                                            helpText("2, Select n-gram method for predicting",style="color:#BF3EFF"),
                                            helpText("3, Click" ,code("Update"), " button",style="color:#BF3EFF"),
                                            helpText("4, Wait for predictions and check results on the right of your screen.",style="color:#BF3EFF"),
                                            hr(),
                                            helpText(h5("Input example:")),
                                            helpText(code("want some milk"), code("went to new york"), code("little potato"),"etc...")
                                            ),
                                    
                                    mainPanel(
                                            column(5,
                                                   h4("Next word cloud prediction:"),
                                                   hr(),
                                                   plotOutput("plot")
                                                  ),
                                            column(5,
                                                   h4("Next word text output:"),
                                                   hr(),
                                                   verbatimTextOutput("textout"),
                                                   lapply(1:nrow(word), function(i) {
                                                           uiOutput(paste0('b', i))
                                                   })
                                            
                                                  )
                                             )
                                      )
                            ),
                   
                   tabPanel("page2-Background of NLP and references", HTML('
                                                                           <h3>What is n-gram? </h3>
                                                                           <p>An n-gram model is a type of probabilistic language model for 
                                                                           predicting the next item in such a sequence in the form of a (n − 1)–order Markov model.
                                                                           In the fields of computational linguistics and probability, an n-gram is a contiguous sequence 
                                                                           of n items from a given sequence of text or speech. The items can be phonemes, syllables, letters, 
                                                                           words or base pairs according to the application. The n-grams typically are collected from a text 
                                                                           or speech corpus. When the items are words, n-grams may also be called shingles.</p>
                                                                           <h3>Types of n-gram? </h3>
                                                                           <p>An n-gram of size 1 is referred to as a "unigram"; size 2 is a "bigram" (or, less commonly, a 
                                                                           "digram"); size 3 is a "trigram". Larger sizes are sometimes referred to by the value of n, e.g., 
                                                                           "four-gram", "five-gram", and so on.</p>
                                                                           
                                                                           <h3>Reference links </h3>
                                                                           <ol>
                                                                           <li><a href="http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf">handling string in R</a></li>
                                                                           <li><a href="http://cran.r-project.org/web/views/NaturalLanguageProcessing.html">http://CRAN NLP</a></li>                             
                                                                           </ol>
                                                                           ')),
                   tabPanel("page3-Instruction & visualization", HTML('
                                                                      <h3>Procedure of prediction </h3>
                                                                      <ul>
                                                                      <li>Read in twitts, news and blogs data and randomly select 80000 lines of each data.</li>
                                                                      <li>Make corpus, clean the corpus, tokenized corpus, then create termdocumentmatrix for (unigram, bigram, trigram, and 4-gram(quagram))</li>
                                                                      <li>Convert tdm to data frame for each gram type(the data frame contains term names, count, and probability that it ocours in the data frame)</li>
                                                                      <li>Create function that do the prediction and return terms that mostly will be the next word</li>
                                                                      </ul>
                                                                      <h3>How to predict with this shiny app?</h3>
                                                                      <p>If you type nothing in the input text, then on the main panel it returns a sentence.
                                                                      Type a sentence and select which type of ngram prediction you would like to do with, then click
                                                                      "Update" button to see if there shows the predicted words on the main panel.
                                                                      What you entered must be more than one word, if you entered just one word or nothing, 
                                                                      it will returns "please enter some words". If it has no prediction on the sentence, it will returns"
                                                                      no prediction" .</p>
                                                                      
                                                                      
                                                                      
                                                                      ')))))