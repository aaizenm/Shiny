---
title: "Shiny-Diamonds"
author: "Abraham Aizenman"
date: "Thursday, November 06, 2014"
output: html_document
---
## How much cost a Diamond?

For this assignment, I did prepared a Shiny application in which the user will input the Carats of a Diamond stone and it will get its price based on the statistical data.

### Loading of the packages

The first part is the declaration of the package which will be used. 


```r
library(shiny)
library(UsingR)
```
### Reading of the Data

We began by reading in the data.

The data is in SIN$ but the final results will be in US$ (at a change rate based on the date at Nov. 7 2014 of: USD/SGD = 0.77134)


```r
data(diamond)
```


### Feeting the Model
I created a novel prediction algorithm to predict the cost in US$dollars for each 
diamond stone.


```r
fit= lm(price ~ carat, data = diamond)
```
A quick look at the data :



```r
 plot(diamond$carat, diamond$price, xlab = "Weight (carats)", ylab = "Price (SIN $)", bg = "blue", col = "red", cex = 1.1, pch = 21)
abline(fit, lwd = 2)
```

![plot of chunk scatterplot](figure/scatterplot.png) 

## Here it is the application Diamond Price Calculation

#### Please click the following Link: 

##### <a href="https://aaizenm.shinyapps.io/Shiny-Diamond/" target="_blank">Shiny-Diamonds</a>.


or Here:

##### https://aaizenm.shinyapps.io/Shiny-Diamond/




The following is the source used to create the application: 

### The Interactive Application using the Shiny package

A shiny project is a directory containing at least two parts
One named ui.R (for user interface) controls how it looks.
One named server.R that controls what it does.

Here are the files:

### ui.R

```r
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
```

### server.r


```r
library(shiny)
library(UsingR)
data(diamond)

fit= lm(price ~ carat, data = diamond)
slope<-coef(fit)[2]
names(slope)<- "US$ Dollars"

CaratPrice <- function(carat) {0.77134*(carat*slope + coef(fit)[1])}

shinyServer(
        function(input, output) {
                output$inputValue <- renderPrint({input$carat})
                output$prediction <- renderPrint({CaratPrice(input$carat)})
        }
)
```
