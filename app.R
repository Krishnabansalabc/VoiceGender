#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(readr)
voice = read.csv("voice.csv")
voice$label = as.factor(voice$label)
library(shiny)

# Define UI for application that draws a histogram
ui = fluidPage(

    # Application title
    titlePanel("Data Exploratory Analysis"),
    fluidRow(
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        #headerPanel("Univeriate Analysis"),
        sidebarPanel(
           selectInput("xcol","X-variable",choices = names(voice))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
    ),
    fluidRow(
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
            #headerPanel("Univeriate Analysis"),
            sidebarPanel(
                selectInput("x","X-variable",choices = names(voice)),
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("distPlot1")
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({

        # draw the histogram with the specified number of bins
        hist(voice[,input$xcol], col = 'darkgray',main = "Univariate Analysis",xlab = input$xcol)
        
    })
    output$distPlot1 <- renderPlot({
        
        # draw the histogram with the specified number of bins
        barplot(table(voice$label),voice[,input$x], col = c('red','blue'),main = "Bivariate Analysis",xlab = input$x)
        
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
