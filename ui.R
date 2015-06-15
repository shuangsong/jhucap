library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme = shinytheme("cerulean"),
        navbarPage("JHU Capstone project shiny app-NLP in R",inverse = FALSE, collapsible = FALSE,
                   tabPanel("N-gram prediction",
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
                   
                   tabPanel("Instruction",
                            sidebarLayout(
                                    sidebarPanel(
                                            helpText(h5("What is on this page?")),
                                            hr(),
                                            helpText("N-gram and its background information", style="color:#BF3EFF"),
                                            helpText("How does this app works?", style="color:#BF3EFF"),
                                            helpText("References", style="color:#BF3EFF")),
                                    mainPanel(
                                            tabsetPanel(
                                                    tabPanel("Background",
                                                             h3("What is n-gram?"),
                                                             hr(),
                                                             p("An n-gram model is a type of probabilistic language model for 
                                                                           predicting the next item in such a sequence in the form of a (n − 1)–order Markov model.
                                                                           In the fields of computational linguistics and probability, an n-gram is a contiguous sequence 
                                                                           of n items from a given sequence of text or speech. The items can be phonemes, syllables, letters, 
                                                                           words or base pairs according to the application. The n-grams typically are collected from a text 
                                                                           or speech corpus. When the items are words, n-grams may also be called shingles."),
                                                             h3("Types of n-gram:"),
                                                             hr(),
                                                             p("An n-gram of size 1 is referred to as a", code("unigram"), "; size 2 is a", code("bigram"), " (or, less commonly, a 
                                                                           ", code("digram"), "; size 3 is a", code("trigram"), ". Larger sizes are sometimes referred to by the value of n, e.g., 
                                                                           ", code("four-gram"), code("five-gram"),  "and so on.")
                                                             ),
                                                    tabPanel("Algorithm",
                                                             h3("Procedure of prediction"),
                                                             hr(),
                                                             p("Read in twitts, news and blogs data and randomly select 20000 lines of each data."),
                                                             p("Make corpus, clean the corpus, tokenized corpus, then create termdocumentmatrix for (unigram, bigram, trigram, and 4-gram(quagram))"),
                                                             p("Convert tdm to data frame for each gram type(the data frame contains term names, count, and probability that it ocours in the data frame)"),
                                                             p("Create function that do the prediction and return terms that mostly will be the next word")),
                                                    tabPanel("References",
                                                             h3("Reference links"),
                                                             hr(),
                                                             p(a("Handling and processing strings in R", href="http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf"),
                                                               "How to handle string in R"),
                                                             p(a("CRAN NLP", href="http://cran.r-project.org/web/views/NaturalLanguageProcessing.html"), "CRAN NLP")
                                                             )
                                                    )
                                            ))))))
                                   
                                            
                                            
                                            

                                                                      
                                                                   