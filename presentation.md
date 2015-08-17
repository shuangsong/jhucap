JHU Capstone project-NLP project
========================================================
author: Stephanie
date: 08/17/2015
transition: rotate


This project is using own knowledge of data science and basic knowledge of NLP(natural language processing) in R to build an app that can predict next word with given sentences. The resource link is : www.corpora.heliohost.org.
App use: on mobile phone.


Procedure of project: 
========================================================

-Read in data and Basic analysis:Read in twitts, news and blogs data and randomly select 2000 lines of each data(my laptop RAM is very limited).

-Make corpus, clean the corpus, tokenized corpus, then create termdocumentmatrix for (unigram, bigram, trigram, and 4-gram(quagram))

-Convert tdm to data frame for each gram type(the data frame contains term names, count, and probability that it ocours in the data frame)

-Create function that do the prediction and return terms that mostly will be the next word.

About this shiny app:
========================================================


![alt text] (s.jpg)

How to use this app?
========================================================

If you type nothing in the input text, then on the main panel it returns "error". Type a sentence and select which type of ngram prediction you would like to do with, then click "Update" button to see if there shows a list of predicted words on the main panel..

The output(if can predict, it will return a string of words--from the most likely words to the least likely words that appear in the data I read in. (for example: input: "we went to new york","a case of", "the last"--you can try it yourself!)


Algorithm for this app: 
========================================================
It basically use Markov chain rule to do the prediction: Bigram: takes last one word and search through bigram data frame and find the possible terms; same with trigram(take last two words) and quagram (take last three words)prediction methods.

Improve in the future:

It can predict next word if the input within the data frame(readin some sources data twitts, blogs, news)if it doesn't meet, it will return no prediction(that is defect). Future improvement should be done that it can predict a long distance sentence and use sophisticated Katz back off model.
Click here for a try: http://shuangsong.shinyapps.io/final2
