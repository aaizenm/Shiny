library(shiny)

shinyUI(
        pageWithSidebar(
                # Price of Diamonds per Carat prediction
                headerPanel("Price of Diamonds per Carat prediction"),
                
                sidebarPanel(
                        numericInput('carat', 'Enter the weight in carats', 0.1 , min = .01, max = 2.0, step = 0.01),
                        submitButton('Submit')
                ),
                mainPanel(
                        h3('Results of the prediction'),
                        h4('You entered the following carats'),
                        verbatimTextOutput("inputValue"),
                        h4('Which will cost you (in $US)'),
                        verbatimTextOutput("prediction")
                )
        )
)