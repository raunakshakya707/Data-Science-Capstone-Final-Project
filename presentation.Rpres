Data Science Project: Text Prediction Shiny Application
========================================================
author: Raunak Shakya
date: February, 2019
autosize: true

http://rpubs.com/raunakshakya707/final-app-presentation


Introduction
========================================================

The goal of this project is to create a Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word. A key point here is that the predictive model must be small enough to load onto the Shiny server.

The working predictive text model built for this project is using the data provided from a corpus called HC Corpora, and can be downloaded from the Coursera website https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip


Algorithm used to make the prediction
========================================================

The process steps for developing the predictive model using the Classic N-Gram model:

1. Getting and cleaning data.
2. Create, clean and sample the Corpora.
3. Tokenize the Corpora and build frequency tables for N-grams based on the processed Corpora (2-grams, 3-grams, 4-grams and 5-grams).
4. For each N-gram tables, split the n-gram column into two columns containing: First N-1 words (previous to the Last word) in the 1st column and Last word in the 2nd column.
5. The app takes the last N-grams words entered in the input text (first trying with 4-Gram, then 3, 2, 1) and searches in the N+1-gram table its most frequent following words.


How the app works (The Usage Of The Application)
========================================================

Step 1 Provide a word/phrase to be analyzed in the input box and press Enter.

Step 2 You may also select the maximum number of results to return.

Step 3 Keep typing or selecting your ideal words or phrase for testing the prediction algorithm.

Output: The original user word/phrase, the filtered words that the algorithm analyzes, and a table showing predicted words.


Link to the deployed application
========================================================

Milestone Report:
http://rpubs.com/raunakshakya707/week2-milestone-report

The application is deployed on shinyapp.io and here is the link to the application:
https://raunakshakya707.shinyapps.io/Data-Science-Capstone-Final-Project/
