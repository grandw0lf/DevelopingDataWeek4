## ui.R ##
library("shiny")
library("googleVis")
library("dplyr")
library("shinydashboard")




#Shiny Dashboard page
ui <- dashboardPage(
    dashboardHeader(),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Intro", tabName = "Intro", icon = icon("th-list", lib= "glyphicon")),
            menuItem("Old Faithful", tabName = "Faithful", icon = icon("th-list", lib= "glyphicon"))
        )
    ),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "Intro",
                    h2("Old Faithful Waiting times"),
                    h5("App by George Farmer"),
                    h6("Select the Faithful tab on the side and use the slider to
               determine when Old Faithful will erupt.")
            ),
            tabItem(tabName = "Faithful",
                    box(
                        # Input: Slider for the number of bins ----
                        sliderInput(inputId = "bins",
                                    label = "Number of bins:",
                                    min = 5,
                                    max = 50,
                                    value = 30)
                        
                    ),
                    
                    box(
                        ##Histogram Plot
                        plotOutput(outputId = "distPlot")
                        
                    )
            )
        )
    )
)
