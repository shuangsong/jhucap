library(shiny)
library(shinythemes)


shinyUI(fluidPage(theme = shinytheme("cerulean"),
        navbarPage("JHU Capstone project shiny app-NLP in R",inverse = FALSE, collapsible = FALSE,
                   tabPanel("N-gram prediction",
                            sidebarLayout(
                                    sidebarPanel(
                                            img(src="log2.png", height = 100, width = 250),
                                            textInput("text", label=h3("Text input:"),value = "a case of"),
                                            helpText("Input a sentence, select a method and click update button"),
                                            radioButtons("radiobutton", label=h3("ngram-prediction:"),
                                                         choice=list("Bigram prediction"="bi",
                                                                     "Trigram prediction"="tri",
                                                                     "Quadgram prediction"="qua")),
                                            br(),
                                            actionButton("update", "Update"),
                                            helpText(h5("Note:")),
                                            helpText("1, Input a sentence", style="color:#BF3EFF"),
                                            helpText("2, Select n-gram method for predicting",style="color:#BF3EFF"),
                                            helpText("3, Click" ,code("Update"), " button",style="color:#BF3EFF"),
                                            helpText("4, Wait for predictions and check results on the right of your screen.",style="color:#BF3EFF"),
                                            hr(),
                                            helpText(h5("Input example:")),
                                            helpText(code("want some milk"), code("went to new york"), code("little potato"),code("merry"), "etc...")
                                            ),
                                    
                                    mainPanel(#column(5,
                                                     #h3("Next word cloud prediction:"),
                                                     #hr(),
                                                     #plotOutput("wordcloud"),
                                                     #br()
                                                     #),
                                           
                                            column(5,
                                                   h3("Next word text output:"),
                                                   hr(),
                                                   #verbatimTextOutput("textout"),
                                                   #lapply(1:nrow(df), function(i) {
                                                           #uiOutput(paste0('b', i))
                                                   #}),
                                                   tableOutput("textout"),
                                                   hr(),
                                                   helpText("This part shows you a list of predicted next possible words.")
                                            
                                                  )
                                             )
                                      )
                            ),
                   
                   tabPanel("Instruction",
                            sidebarLayout(
                                    sidebarPanel(
                                            helpText(h5("What is on this page?")),
                                            hr(),
                                            helpText("A. NLP and its background information"),
                                            helpText("B. Algorithm in this app"),
                                            helpText("C. References"),
                                            hr(),
                                            helpText(h5("About this app:")),
                                            
                                            helpText("This app is built for mobile phone users."),
                                            hr(),
                                            helpText(h5("Tips:")),
                                            helpText("Wait about 1 to 2 minutes to see predictions."),
                                            img(src="swi.png", height=200, width=250)),
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
                                                                           ", code("four-gram"), code("five-gram"),  "and so on."),
                                                             h3("What is Katz's back-off model?"),
                                                             hr(),
                                                             p("Katz back-off is a generative n-gram language model that estimates the conditional probability of a word given its history in the n-gram. It accomplishes this estimation by ", code("backing-off"), " to models with smaller histories under certain conditions. By doing so, the model with the most reliable information about a given history is used to provide the better results."),
                                                             img(src="katz.jpg", height=570, width=600)
                                                             
                                                             ),
                                                    tabPanel("Algorithm",
                                                             h3("Prediction model"),
                                                             hr(),
                                                             p("Read in twitts, news and blogs data and randomly select 20000 lines of each data, paste them together."),
                                                             p("Create corpus, clean the corpus, use tokenization method, then create termdocumentmatrix for (unigram, bigram, trigram, and quadgram)."),
                                                             p("Convert tdm to data frame by each gram type(those data frames contain term names and their counts)"),
                                                             p("Create function that take the input and returns possible terms"),
                                                             hr(),
                                                             img(src="work.jpg", height = 670, width =800)),
                                            
                                                    tabPanel("References",
                                                             h3("Reference links"),
                                                             hr(),
                                                             p(a("Handling and processing strings in R", href="http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf"),
                                                               "How to handle string in R"),
                                                             p(a("CRAN NLP", href="http://cran.r-project.org/web/views/NaturalLanguageProcessing.html"), "CRAN NLP")
                                                             
                                                             )
                                                    )
                                            ))))))
                                   
                                            
                                            
                                            

                                                                      
                                                                   