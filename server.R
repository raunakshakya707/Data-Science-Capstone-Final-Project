#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# clean start
suppressWarnings(library(shiny))
suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(data.table))
suppressWarnings(library(ggplot2))

# load large data structures that are not reactive
# load("around_20th_corpus.Rdata")
load("20th_corpus_freq.Rdata")


#
# predict function
# simple back-off algorithm working its way from large 6-grams to tri/bi/unigrams
#
pred_words <- function(sentence, n = 10) {
  # follow a similar preparation path as the large corpus
  sentence <- removeNumbers(sentence)
  sentence <- removePunctuation(sentence)
  sentence <- tolower(sentence)
  
  # split into words
  words <- unlist(strsplit(sentence, split = " "))
  
  # only focus on last 5 words
  words <- tail(words, 5)
  
  word1 <- words[1]
  word2 <- words[2]
  word3 <- words[3]
  word4 <- words[4]
  word5 <- words[5]
  
  datasub <- data.table()
  
  if (nrow(datasub) == 0 & !is.na(word5)) {
    if (nrow(datasub) == 0)
      datasub <- subset(ngram6, w1 == word1 & w2 == word2 & w3 == word3 & w4 == word4 & w5 == word5)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram5, w1 == word2 & w2 == word3 & w3 == word4 & w4 == word5)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram4, w1 == word3 & w2 == word4 & w3 == word5)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram3, w1 == word4 & w2 == word5)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram2, w1 == word5)
  }
  
  if (nrow(datasub) == 0 & !is.na(word4)) {
    if (nrow(datasub) == 0)
      datasub <-
        subset(ngram5, w1 == word1 & w2 == word2 & w3 == word3 & w4 == word4)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram4, w1 == word2 & w2 == word3 & w3 == word4)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram3, w1 == word3 & w2 == word4)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram2, w1 == word4)
  }
  
  if (nrow(datasub) == 0 & !is.na(word3)) {
    if (nrow(datasub) == 0)
      datasub <-
        subset(ngram4, w1 == word1 & w2 == word2 & w3 == word3)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram3, w1 == word2 & w2 == word3)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram2, w1 == word3)
  }
  
  if (nrow(datasub) == 0 & !is.na(word2)) {
    if (nrow(datasub) == 0)
      datasub <- subset(ngram3, w1 == word1 & w2 == word2)
    if (nrow(datasub) == 0)
      datasub <- subset(ngram2, w1 == word2)
  }
  
  if (nrow(datasub) == 0 & !is.na(word1)) {
    if (nrow(datasub) == 0)
      datasub <- subset(ngram2, w1 == word1)
    if (nrow(datasub) == 0)
      datasub <- head(ngram1)
  }
  
  if (nrow(datasub) > 0) {
    datasub$freq <- datasub$count / sum(datasub$count)
    as.data.frame(head(datasub[order(-freq)], min(n, nrow(datasub))))
  }
  
}


# Define server logic for the Word Prediction application
shinyServer(function(input, output) {
  data_prediction <- reactive({
    pred_words(input$sentence, input$obs)
  })
  
  output$prediction <- renderPrint({
    ds <- data_prediction()
    if (nrow(ds) > 0) {
      #head(subset(ds, freq==max(ds$freq))[,ncol(ds)-1],3) # just the best prediction
      cat(paste(head(ds[, ncol(ds) - 1]), collapse = ', '))  # top 1
    }
  })
  
  output$ngram_source <- reactivePlot(function() {
    # retrieve reactive prediction (just once, optimal)
    ds <- data_prediction()
    max(grep('w', names(ds) , value = T))
  })
  
  output$text <- renderText({
    input$sentence
  })
  
  # Show the table behind predictions
  output$output_dataset <- renderDataTable({
    data_prediction()
  })
  
  output$table <- renderDataTable({
    (ngram_stats)
  })
  
})
