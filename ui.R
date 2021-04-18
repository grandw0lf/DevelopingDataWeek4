## ui.R ##
library("shiny")
library("googleVis")
library("rio")
library("tidyverse")
library("dplyr")
library("shinydashboard")



#Shiny Dashboard page
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Intro", tabName = "Intro", icon = icon("th-list", lib= "glyphicon")),
      menuItem("Income", tabName = "Income", icon = icon("th-list", lib= "glyphicon")),
      menuItem("Income Inequality", tabName = "Inequality", icon = icon("th-list", lib= "glyphicon")),
      menuItem("Earnings", tabName = "Earnings", icon = icon("th-list", lib= "glyphicon")),
      menuItem("Poverty", tabName = "Poverty", icon = icon("th-list", lib= "glyphicon"))
    )
  ),
dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "Intro",
            h2("Income and Poverty in the United States: 2019"),
            h4("Source:https://www.census.gov/data/tables/2020/demo/income-poverty/p60-270.html"),
            h4("Original Report by: JESSICA SEMEGA, MELISSA KOLLAR, EMILY A. SHRIDER, AND JOHN CREAMER"),
            h4("App by: George Farmer"),
            h6("To begin, select a item from the sidebar and choose a radio button to view various data from the Census website on Income data and Poverty levels")
     ),
    tabItem(tabName = "Income",
          box(
            radioButtons('IncomeInput', 
                         label = "Select Data: ",
                         choices = list(
                           "Table A-1. Income Summary Measures by Selected Characteristics: 2018 and 2019" = 'TableA1',
                           "Table A-2. Households by Total Money Income, Race, and Hispanic Origin of Householder: 1967 to 2019" = 'TableA2',
                           "Table C-1. Historical Median Income Using Alternative Price Indices: 1967 to 2019" = 'TableC1'
                           ),
                         selected = 'TableA1')
          ),
          tabBox(
            id = "tabset1",
            tabPanel("Summary", verbatimTextOutput("summary1")),
            tabPanel("Structure", verbatimTextOutput("structure1")),
            tabPanel("Data", tableOutput("displayData1")),
            tabPanel("Plot", plotOutput("graph1"))
          ),
     ),
    tabItem(tabName = "Inequality",
            box(
              radioButtons('InequalityInput', 
                           label = "Select Data: ",
                           choices = list(
                             "Table A-3. Income Distribution Measures Using Money Income and Equivalence-Adjusted Income: 2018 and 2019" = 'TableA3',
                             "Table A-4. Selected Measures of Household Income Dispersion: 1967 to 2019" = 'TableA4',
                             "Table A-5. Selected Measures of Equivalence-Adjusted Income Dispersion: 1967 to 2019" = 'TableA5'
                           ),
                           selected = 'TableA3')
            ),
            tabBox(
              id = "tabset2",
              tabPanel("Summary", verbatimTextOutput("summary2")),
              tabPanel("Structure", verbatimTextOutput("structure2")),
              tabPanel("Data", tableOutput("displayData2")),
              tabPanel("Plot", plotOutput("graph2"))
            ),
    ),
    tabItem(tabName = "Earnings",
            box(
              radioButtons('EarningsInput', 
                           label = "Select Data: ",
                           choices = list(
                             "Table A-6. Earnings Summary Measures by Selected Characteristics: 2018 and 2019" = 'TableA6',
                             "Table A-7. Number and Real Median Earnings of Total Workers and Full-Time, Year-Round Workers by Sex and Female-to-Male Earnings Ratio: 1960 to 2019" = 'TableA7'
                           ),
                           selected = 'TableA6')
            ),
            tabBox(
              id = "tabset3",
              tabPanel("Summary", textOutput("summary3")),
              tabPanel("Structure", textOutput("structure3")),
              tabPanel("Data", tableOutput("displayData3")),
              tabPanel("Plot", plotOutput("graph3"))
            ),
    ),
   tabItem(tabName = "Poverty",
           box(
             radioButtons('PovertyInput', 
                          label = "Select Data: ",
                          choices = list(
                            "Poverty Thresholds: 2019" = 'PovertyThresholds',
                            "Table B-1. People in Poverty by Selected Characteristics: 2018 and 2019" = 'TableB1',
                            "Table B-2. Families and People in Poverty by Type of Family: 2018 and 2019" = 'TableB2',
                            "Table B-3. People With Income Below Specified Ratios of Their Poverty Thresholds by Selected Characteristics: 2019" = 'TableB3',
                            "Table B-4. Income Deficit or Surplus of Families and Unrelated Individuals by Poverty Status: 2019" = 'TableB4',
                            "Table B-5. Poverty Status of People by Family Relationship, Race, and Hispanic Origin: 1959 to 2019" = 'TableB5',
                            "Table B-6. Poverty Status of People by Age, Race, and Hispanic Origin: 1959 to 2019" = 'TableB6',
                            "Table B-7. Poverty Status of Families by Type of Family: 1959 to 2019" = 'TableB7',
                            "Number and Percent of Shared Households, and Number and Percent of Adults aged 18 and older, in Shared Households: 2018 and 2019" = 'SharedHouseholds2020',
                            "Impact on Poverty of Alternative Resource Measures by Age: 1981 to 2019" = 'ImpactPoverty',
                            "Percentage of People in Poverty by State Using 2- and 3-Year Averages: 2016-2017 and 2018-2019" = 'StatePoverty',
                            "Interrelationships of 3-Year Average State Poverty Rates: 2017 - 2019" = 'StateGrid'
                          ),
                          selected = 'TableB1')
           ),
           tabBox(
             id = "tabset4",
             tabPanel("Summary", renderTable("summary4")),
             tabPanel("Structure", verbatimTextOutput("structure4")),
             tabPanel("Data", tableOutput("displayData4")),
             tabPanel("Plot", plotOutput("graph4"))
           ),
   )
  )
 )
)



shinyApp(ui, server)