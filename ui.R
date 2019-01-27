#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

suppressWarnings(library(shiny))

shinyUI(fluidPage(# Application title
  h1(
    strong("Data Science Capstone Final Project")
  ),
  br(),
  
  # Sidebar layout
  sidebarLayout(
    sidebarPanel(
      textInput("sentence", "Type your sentence here below", value = "Donald"),
      
      sliderInput(
        "obs",
        "Maximum predicted words to return",
        min = 0,
        max = 30,
        value = 10
      )
    ),
    
    mainPanel(tabsetPanel(
      tabPanel(
        "Analysis",
        
        h4("The phrase that was provided:"),
        verbatimTextOutput("text"),
        
        h4("The words predicted based on the phrase provided:"),
        verbatimTextOutput("prediction"),
        
        br(),
        dataTableOutput("output_dataset")
      ),
      
      tabPanel(
        "Documentation",
        h4("Project Requirements"),
        p(
          "The goal of this exercise is to create a product to highlight the prediction
          algorithm that you have built and to provide an interface that can be accessed
          by others. For this project you must submit:"
        ),
        p(
          "1. A Shiny app that takes as input a phrase (multiple words) in a text box
          input and outputs a prediction of the next word."
        ),
        p(
          "2. A slide deck consisting of no more than 5 slides created with R Studio Presenter
          pitching your algorithm and app as if you were presenting to your boss or an investor."
        ),
        p(
          "A key point here is that the predictive model must be small enough to load onto the Shiny
          server. So we have to pay attention to model size when creating and uploading your model."
        ),
        br(),
        
        h4("Application Functionality"),
        p(
          "This app uses a ngram backoff model to predict the next word in a sentence. It is based
          on a subset of data prepared in advance of blogs, news and tweets. The sampled data represents
          ngrams of several depth level (from 1 to 6) with their frequencies, as a basis for the cascading
          model below. The prediction model below simplistically ranks higher predictions coming from
          higher rank ngrams. The model was validated against unseen date with slight above average results.
          Further methods to improve the prediction include extending the sampling size (currently 20%),
          extend the source dataset, implement generative n-gram language model (Katz backoff with discounting)
          and revalidate the model against new datasets."
        ),
        br()
        
        )
        ))
        )))
