library(shiny)
library(shinyAce)
library(CTT)



shinyServer(function(input, output) {
    
    
    check <- reactive({
        if (input$colname == 0) {
            x <- read.table(text=input$text, sep="\t")
            x <- as.matrix(x)
            
            ans <- read.delim(text=input$anskey, sep="\t", fill=TRUE, header=FALSE, stringsAsFactors=FALSE)
            ans <- as.character(ans)
            dat <- score(x, ans, output.scored=TRUE)$scored
            
        } else {
            
            x <- read.csv(text=input$text, sep="\t")
            
            ans <- read.delim(text=input$anskey, sep="\t", fill=TRUE, header=FALSE, stringsAsFactors=FALSE)
            ans <- as.character(ans)
            
            dat <- score(x, ans, output.scored=TRUE)$scored
        }
    })
    
    
    







    output$check <- renderTable({
        head(check(), n = 10)
    }, digits = 0)

    output$downloadData <- downloadHandler(
        filename = function() {
            paste('Data-', Sys.Date(), '.csv', sep='')
        },
        content = function(file) {
            write.csv(check(), file)
        }
    )

})
