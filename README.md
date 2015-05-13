# capstone
JHU- data products-specificaiton project
--------------------

This project uses basic knowledge of NLP(natural language processing) in R to build an app that can predict next word with given sentences. The resource link is : www.corpora.heliohost.org. The core of this project on predicting is that with the background of Markov chain rule(n-gram prediction), and Katz back off model. As experience, trigram model is better prediction than bigram, unigram, or higher n-gram model, for the reason that it has lower perplexity.

Procedure of project: 
----------------

-Read in data and Basic analysis

-Sample data and paste into one and make corpus and do the cleaning

-Exploratory analysis

-Transfer 1,2,3,4grams to data frame

-Create prediction model with unigram, bigram, trigram and quadgram

-Smooth n-gram models that are more accurate and fast, efficient.(back off)

References and link of NLP resource: 
-----------------
1, https://class.coursera.org/nlangp-001/lecture/51

2, https://class.coursera.org/nlp/lecture

3, http://en.wikipedia.org/wiki/N-gram#n-grams_for_approximate_matching

4, http://en.wikipedia.org/wiki/Katz%27s_back-off_model

5, R pubs: http://rpubs.com/shuangsong/72194