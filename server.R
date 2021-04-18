## server.R ##
library("shiny")
library("googleVis")
library("rio")
library("tidyverse")
library("dplyr")
library("shinydashboard")

#Read Data
#Income
TableA1 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA1.xlsx", skip = 3)
TableA2 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA2.xlsx", skip = 3)
TableC1 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableC1.xlsx", skip = 3)

#Income Inequality
TableA3 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA3.xlsx", skip = 3)
TableA4 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA4.xlsx", skip = 3)
TableA5 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA5.xlsx", skip = 3)

#Earnings
TableA6 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA6.xlsx", skip = 3)
TableA7 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableA7.xlsx", skip = 3)

#Poverty
PovertyThresholds <- import("https://www2.census.gov/programs-surveys/cps/tables/time-series/historical-poverty-thresholds/thresh19.xls", skip = 3)
TableB1 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-1.xlsx", skip = 4)
TableB2 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-2.xls", skip = 4)
TableB3 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-3.xls", skip = 4)
TableB4 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-4.xls", skip = 4)
TableB5 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-5.xls", skip = 4)
TableB6 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-6.xls", skip = 4)
TableB7 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/tableB-7.xls", skip = 4)
SharedHouseholds2020 <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/SharedHousehold2020.xlsx", skip = 4)
ImpactPoverty <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/Impact_Poverty.xlsx", skip = 4)
StatePoverty <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/state.xlsx", skip = 3)
StateGrid <- import("https://www2.census.gov/programs-surveys/demo/tables/p60/270/stategrid.xls", skip = 3)

#Clean Data
#TableA1
names(TableA1)[names(TableA1) == "2018"] <- "2018_Thousands"
names(TableA1)[names(TableA1) == "...3"] <- "2018_MedianEstimate"
names(TableA1)[names(TableA1) == "...4"] <- "2018_MarginOfError"
names(TableA1)[names(TableA1) == "2019"] <- "2019_Thousands"
names(TableA1)[names(TableA1) == "...6"] <- "2019_MedianEstimate"
names(TableA1)[names(TableA1) == "...7"] <- "2019_MarginOfError"
names(TableA1)[names(TableA1) == "Percent change in real median income (2019 less 2018)*"] <- "PercentageChangeEstimate"
names(TableA1)[names(TableA1) == "2018"] <- "2018_Thousands"
names(TableA1)[names(TableA1) == "...3"] <- "2018_MedianEstimate"
names(TableA1)[names(TableA1) == "...4"] <- "2018_MarginOfError"
names(TableA1)[names(TableA1) == "2019"] <- "2019_Thousands"
names(TableA1)[names(TableA1) == "...6"] <- "2019_MedianEstimate"
names(TableA1)[names(TableA1) == "...7"] <- "2019_MarginOfError"
names(TableA1)[names(TableA1) == "Percent change in
 real median income
 (2019 less 2018)*" ] <- "PercentageChangeEstimate"
names(TableA1)[names(TableA1) == "...9"] <- "Percentage_MarginOfError"
TableA1 <- TableA1[-c(1, 2, 42, 43, 44, 45, 46, 47), ]
TableA1 <- na.omit(TableA1)

#TableA2
names(TableA2)[names(TableA2) ==  "Race and Hispanic origin of householder
 and year"] <- "RaceandOrigin"
names(TableA2)[names(TableA2) == "Number (thousands)"] <- "Number(Thousands)"
names(TableA2)[names(TableA2) == "Percent distribution"] <- "Percentage(Total)"
names(TableA2)[names(TableA2) == ...4] <- "Under15k"
names(TableA2)[names(TableA2) == "...4"] <- "Under15k"
names(TableA2)[names(TableA2) == "...5"] <- "15to24.9k"
names(TableA2)[names(TableA2) == "...6"] <- "25to34.9k"
names(TableA2)[names(TableA2) == "...7"] <- "35to49.9k"
names(TableA2)[names(TableA2) == "...8"] <- "50to74.9k"
names(TableA2)[names(TableA2) == "...9"] <- "75to99.9k"
names(TableA2)[names(TableA2) == "...10"] <- "100to149.9k"
names(TableA2)[names(TableA2) == "...11"] <- "150to199.9k"
names(TableA2)[names(TableA2) == "...12"] <- "200k+"
names(TableA2)[names(TableA2) == "Median income
 (dollars)"] <- "MedianIncome"
names(TableA2)[names(TableA2) == "...14"] <- "MarginOfError"
names(TableA2)[names(TableA2) == "Mean income
 (dollars)"] <- "MeanIncomeDollars"
names(TableA2)[names(TableA2) == "...16"] <- "IncomeMarginOfError"
#Deleting NA values deletes the first two columns

#TableA3
names(TableA3)[names(TableA3) == "...3"] <- "2018_MarginofError"
names(TableA3)[names(TableA3) == "...5"] <- "2019_MarginofError"
names(TableA3)[names(TableA3) == "Percent change
 (2019 less 2018)2,*"] <- "PercentChange"
names(TableA3)[names(TableA3) == "...7"] <- "PercentChange_MarginofError"
#Deleting NA Values once again deletes the first column

#TableA4
names(TableA4)[names(TableA4) == "Measures of income dispersion"] <- "IncomeDispersal"
TableA4 <- na.omit(TableA4)

#TableA5
names(TableA5)[names(TableA5) == "Measures of income dispersion"] <- "IncomeDispersal"
TableA5 <- na.omit(TableA5)

#TableA6
names(TableA6)[names(TableA6) == "2018"] <- "2018_Thousands"
names(TableA6)[names(TableA6) == "...3"] <- "2018_MedianEstimate"
names(TableA6)[names(TableA6) == "...4"] <- "2018_MarginOfError"
names(TableA6)[names(TableA6) == "2019"] <- "2019_Thousands"
names(TableA6)[names(TableA6) == "...6"] <- "2019_MedianEstimate"
names(TableA6)[names(TableA6) == "...7"] <- "2019_MarginOfError"
names(TableA6)[names(TableA6) == "Percent change in
 real median income
 (2019 less 2018)*" ] <- "PercentageChangeEstimate"
names(TableA6)[names(TableA6) == "...9"] <- "Percentage_MarginOfError"
TableA6 <- TableA6[-c(1, 2, 3, 11, 12, 13, 14, 15), ]

#TableA7
names(TableA7)[names(TableA7) == "Total workers"] <- "Male_Workers"
names(TableA7)[names(TableA7) == "...3"] <- "Male_WorkersEarnings"
names(TableA7)[names(TableA7) == "...4"] <- "Male_WorkersMedianEarning"
names(TableA7)[names(TableA7) == "...5"] <- "Male_WorkersMarginofError"
names(TableA7)[names(TableA7) == "...6"] <- "Female_Workers"
names(TableA7)[names(TableA7) == "...7"] <- "Female_WorkersEarning"
names(TableA7)[names(TableA7) == "...8"] <- "Female_WorkersMedianEaring"
names(TableA7)[names(TableA7) == "...9"] <- "Female_WorkersMarginofError"
names(TableA7)[names(TableA7) == "Full-time, year-round workers"] <- "Male_FullTimeWorkers"
names(TableA7)[names(TableA7) == "...11"] <- "Male_FullTimeWorkersEarnings"
names(TableA7)[names(TableA7) == "...12"] <- "Male_FullTimeWorkersMedianEarnings"
names(TableA7)[names(TableA7) == "...13"] <- "Male_FullTimeWorkersMarginofError"
names(TableA7)[names(TableA7) == "...14"] <- "Female_FullTimeWorkers"
names(TableA7)[names(TableA7) == "...15"] <- "Male_FullTimeWorkersEarnings"
names(TableA7)[names(TableA7) == "...16"] <- "Male_FullTimeWorkersMedianEarnings"
names(TableA7)[names(TableA7) == "...17"] <- "Male_FullTimeWorkersMarginofError"
names(TableA7)[names(TableA7) == "...18"] <- "MaletoFemaleEarningRatio"
TableA7 <- na.omit(TableA7)

#TableB1
names(TableB1)[names(TableB1) == "...3"] <- "2018_BelowPoverty"
names(TableB1)[names(TableB1) == "...4"] <- "2018_BelowPovertyMarginofError"
names(TableB1)[names(TableB1) == "...5"] <- "2018_BelowPovertyPercent"
names(TableB1)[names(TableB1) == "...6"] <- "2018_BelowPovertyPercentMarginofError"
names(TableB1)[names(TableB1) == "...8"] <- "2018_BelowPoverty"
names(TableB1)[names(TableB1) == "...9"] <- "2018_BelowPovertyMarginofError"
names(TableB1)[names(TableB1) == "...10"] <- "2018_BelowPovertyPercent"
names(TableB1)[names(TableB1) == "...11"] <- "2018_BelowPovertyPercentMarginofError"
names(TableB1)[names(TableB1) == "Change in poverty 
  (2019 less 2018 )*"] <- "ChangeinPoverty"
names(TableB1)[names(TableB1) == "...13"] <- "ChangeinPovertyMarginofError"

#TableB2
names(TableB2)[names(TableB2) == "...3"] <- "2018_BelowPoverty"
names(TableB2)[names(TableB2) == "...4"] <- "2018_BelowPovertyMarginofError"
names(TableB2)[names(TableB2) == "...5"] <- "2018_BelowPovertyPercent"
names(TableB2)[names(TableB2) == "...6"] <- "2018_BelowPovertyPercentMarginofError"
names(TableB2)[names(TableB2) == "...8"] <- "2018_BelowPoverty"
names(TableB2)[names(TableB2) == "...9"] <- "2018_BelowPovertyMarginofError"
names(TableB2)[names(TableB2) == "...10"] <- "2018_BelowPovertyPercent"
names(TableB2)[names(TableB2) == "...11"] <- "2018_BelowPovertyPercentMarginofError"
names(TableB2)[names(TableB2) == "Change in poverty 
  (2019 less 2018 )*"] <- "ChangeinPoverty"
names(TableB2)[names(TableB2) == "...13"] <- "ChangeinPovertyMarginofError"
TableB2 <- TableB2[-c(1, 2, 3, 4, 9, 11, 12, 13, 20, 24, 28, 31, 32, 36, 37, 38, 39, 40, 41), ]
#Omiting NA deleted all the data, more work probably needed as it didn't register any data whatsoever.

#TableB3
names(TableB3)[names(TableB3) == "Income-to-poverty ratio1"] <- "Incometopovertyratio"
names(TableB3)[names(TableB3) == "...4"] <- "IncometopovertyMarginofError"
names(TableB3)[names(TableB3) == "...5"] <- "IncometopovertyPercent"
names(TableB3)[names(TableB3) == "...6"] <- "IncometopovertyPercentMarginofError"
names(TableB3)[names(TableB3) == "...7"] <- "Under1.25"
names(TableB3)[names(TableB3) == "...8"] <- "Under1.25MarginofError"
names(TableB3)[names(TableB3) == "...9"] <- "Under1.25Percent"
names(TableB3)[names(TableB3) == "...10"] <- "Under1.25PercentMarginofError"
names(TableB3)[names(TableB3) == "...11"] <- "Under1.50"
names(TableB3)[names(TableB3) == "...12"] <- "Under1.50MarginofError"
names(TableB3)[names(TableB3) == "...13"] <- "Under1.50Percent"
names(TableB3)[names(TableB3) == "...14"] <- "Under1.50PercentMarginofError"
names(TableB3)[names(TableB3) == "...15"] <- "Under2"
names(TableB3)[names(TableB3) == "...16"] <- "Under2MarginofError"
names(TableB3)[names(TableB3) == "...17"] <- "Under2Percent"
names(TableB3)[names(TableB3) == "...18"] <- "Under2PercentMarginofError"
TableB3 <- TableB3[-c(1, 2), ]
TableB3 <- na.omit(TableB3)

#TableB4
names(TableB4)[names(TableB4) == "Size of deficit or surplus"] <- "DeficitorSurplus_Under1k"
names(TableB4)[names(TableB4) == "...4"] <- "1to2.49k"
names(TableB4)[names(TableB4) == "...5"] <- "2.5to4.9k"
names(TableB4)[names(TableB4) == "...6"] <- "5to7.49k"
names(TableB4)[names(TableB4) == "...7"] <- "7.5to9.9k"
names(TableB4)[names(TableB4) == "...8"] <- "10to12.49k"
names(TableB4)[names(TableB4) == "...9"] <- "12.5to14.9k"
names(TableB4)[names(TableB4) == "...10"] <- "15k+"
names(TableB4)[names(TableB4) == "Average deficit or surplus (dollars)"] <- "AverageDeficitorSurplus"
names(TableB4)[names(TableB4) == "...12"] <- "AverageDeficitorSurplusMarginofError"
names(TableB4)[names(TableB4) == "Deficit or surplus per capita (dollars)"] <- "DeficitorSurplusperCapita"
names(TableB4)[names(TableB4) == "...14"] <- "SurplusDeficitorSurplusMarginofError"
TableB4 <- TableB4[-c(1, 2, 3, 4, 5, 6), ]
TableB4 <- na.omit(TableB4)

#TableB5
names(TableB5)[names(TableB5) == "Race, Hispanic origin, and year"] <- "RaceOriginYear"
names(TableB5)[names(TableB5) == "...3"] <- "BelowPoverty_Number"
names(TableB5)[names(TableB5) == "...4"] <- "BelowPoverty_Percent"
names(TableB5)[names(TableB5) == "People in families"] <- "FamilySize"
names(TableB5)[names(TableB5) == "...6"] <- "FamilyBelowPoverty_Number"
names(TableB5)[names(TableB5) == "...7"] <- "FamilyBelowPoverty_Percent"
names(TableB5)[names(TableB5) == "...8"] <- "SingleFemaleHouseholds"
names(TableB5)[names(TableB5) == "...9"] <- "SingleFemaleBelowPoverty_Number"
names(TableB5)[names(TableB5) == "...10"] <- "SingleFemaleBelowPoverty_Percent"
names(TableB5)[names(TableB5) == "Unrelated individuals"] <- "Unrelated"
names(TableB5)[names(TableB5) == "...12"] <- "UnrelatedBelowPoverty_Number"
names(TableB5)[names(TableB5) == "...13"] <- "UnrelatedBelowPoverty_Percent"
TableB5 <- TableB5[-c(1, 2, 3, 4), ]
TableB5 <- na.omit(TableB5)

#TableB6
names(TableB6)[names(TableB6) == "Race, Hispanic origin, and year"] <- "RaceOriginYear"
names(TableB6)[names(TableB6) == "Under 18 years"] <- "Under18"
names(TableB6)[names(TableB6) == "...3"] <- "Under18BelowPoverty_Number"
names(TableB6)[names(TableB6) == "...4"] <- "Under18BelowPoverty_Percent"
names(TableB6)[names(TableB6) == "...5"] <- "Under18Related"
names(TableB6)[names(TableB6) == "...6"] <- "Under18RelatedBelowPoverty_Number"
names(TableB6)[names(TableB6) == "...7"] <- "Under18RelatedBelowPoverty_Percent"
names(TableB6)[names(TableB6) == "18 to 64 years"] <- "Adults"
names(TableB6)[names(TableB6) == "...9"] <- "AdultsBelowPoverty_Number"
names(TableB6)[names(TableB6) == "...10"] <- "AdultsBelowPoverty_Percent"
names(TableB6)[names(TableB6) == "65 years and over"] <- "Elderly"
names(TableB6)[names(TableB6) == "...12"] <- "ElderlyBelowPoverty_Number"
names(TableB6)[names(TableB6) == "...13"] <- "ElderlyBelowPoverty_Percent"
TableB6 <- TableB6[-c(1, 2, 3, 4), ]
TableB6 <- na.omit(TableB6)

#TableB7
names(TableB7)[names(TableB7) == "All families"] <- "Families"
names(TableB7)[names(TableB7) == "...3"] <- "FamiliesBelowPoverty_Number"
names(TableB7)[names(TableB7) == "...4"] <- "FamiliesBelowPoverty_Percent"
names(TableB7)[names(TableB7) == "Married-couple families"] <- "Married"
names(TableB7)[names(TableB7) == "...6"] <- "MarriedBelowPoverty_Number"
names(TableB7)[names(TableB7) == "...7"] <- "MarriedBelowPoverty_Percent"
names(TableB7)[names(TableB7)== "Male householder,
 no spouse present"] <- "SingleMale"
names(TableB7)[names(TableB7)== "Female householder,
 no spouse present"] <- "SingleFemale"
names(TableB7)[names(TableB7) == "...9"] <- "SingleMaleBelowPoverty_Number"
names(TableB7)[names(TableB7) == "...10"] <- "SingleMaleBelowPoverty_Percent"
names(TableB7)[names(TableB7) == "...12"] <- "SingleFemaleBelowPoverty_Number"
names(TableB7)[names(TableB7) == "...13"] <- "SingleFemaleBelowPoverty_Percent"
TableB7 <- TableB7[-c(1, 2, 3), ]
TableB7 <- na.omit(TableB7)

#TableC1
names(TableC1)[names(TableC1) == "Current Dollars"] <- "CurrentDollars"
names(TableC1)[names(TableC1) == "...3"] <- "CurrentDollarsMarginofError"
names(TableC1)[names(TableC1) == "CPI-U-RS/Current Method"] <- "CPI-U-RS_Current"
names(TableC1)[names(TableC1) == "...5"] <- "CPI-U-RS_CurrentMarginofError"
names(TableC1)[names(TableC1) == "Chained CPI-U (2000-2019)"] <- "PCEPI_1967-1999"
names(TableC1)[names(TableC1) == "...7"] <- "PCEPI_1967-1999MarginofError"
names(TableC1)[names(TableC1) == "...8"] <- "CPI-U-RS_1967-1999"
names(TableC1)[names(TableC1) == "...9"] <- "CPI-U-RS_1967-1999MarginofError"
TableC1 <- TableC1[-c(1, 2), ]
TableC1 <- na.omit(TableC1)

#ImpactPoverty
names(ImpactPoverty)[names(ImpactPoverty) == "Official Poverty"] <- "OfficialPoverty"
names(ImpactPoverty)[names(ImpactPoverty) == "...3"] <- "OfficialPovertyBelowPoverty_Number"
names(ImpactPoverty)[names(ImpactPoverty) == "...4"] <- "OfficialPovertyBelowPoverty_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "Poverty Estimates with Alternative Resource Definitions"] <- "PovertyEstimates_Money-SS"
names(ImpactPoverty)[names(ImpactPoverty) == "...6"] <- "PovertyEstimates_Money-SS_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...7"] <- "PovertyEstimates_Money-Unemployment"
names(ImpactPoverty)[names(ImpactPoverty) == "...8"] <- "PovertyEstimates_Money-Unemployment_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...9"] <- "PovertyEstimates_Money+SNAP"
names(ImpactPoverty)[names(ImpactPoverty) == "...10"] <- "PovertyEstimates_Money+SNAP_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...11"] <- "PovertyEstimates_Money+EIC"
names(ImpactPoverty)[names(ImpactPoverty) == "...12"] <- "PovertyEstimates_Money+EIC_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "Impact of Alternative Resource Definitions on Poverty" ] <- "Impact_Money-SS"
names(ImpactPoverty)[names(ImpactPoverty) == "...14"] <- "Impact_Money-SS_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...15"] <- "Impact_Money-Unemployment"
names(ImpactPoverty)[names(ImpactPoverty) == "...16"] <- "Impact_Money-Unemployment_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...17"] <- "Impact_Money+SNAP"
names(ImpactPoverty)[names(ImpactPoverty) == "...18"] <- "Impact_Money+SNAP_Percent"
names(ImpactPoverty)[names(ImpactPoverty) == "...19"] <- "Impact_Money+EIC"
names(ImpactPoverty)[names(ImpactPoverty) == "...20"] <- "Impact_Money+EIC_Percent"
ImpactPoverty <- ImpactPoverty[-c(1, 2, 3, 175, 176, 177, 178, 179, 180, 181, 182), ]

#PovertyThresholds
names(PovertyThresholds)[names(PovertyThresholds) == "Size of family unit"] <- "FamilySize"
names(PovertyThresholds)[names(PovertyThresholds) == "...2"] <- "WeightedAverageThresholds"
names(PovertyThresholds)[names(PovertyThresholds) == "Related children under 18 years"] <- "Children_None"
names(PovertyThresholds)[names(PovertyThresholds) == "...4"] <- "Children_One"
names(PovertyThresholds)[names(PovertyThresholds) == "...5"] <- "Children_Two"
names(PovertyThresholds)[names(PovertyThresholds) == "...6"] <- "Children_Three"
names(PovertyThresholds)[names(PovertyThresholds) == "...7"] <- "Children_Four"
names(PovertyThresholds)[names(PovertyThresholds) == "...8"] <- "Children_Five"
names(PovertyThresholds)[names(PovertyThresholds) == "...9"] <- "Children_Six"
names(PovertyThresholds)[names(PovertyThresholds) == "...10"] <- "Children_Seven"
names(PovertyThresholds)[names(PovertyThresholds) == "...11"] <- "Children_Eight+"
PovertyThresholds <- PovertyThresholds[-c(1, 2, 3, 4, 5, 21), ]
#I don't know if it's just because I am getting tired, but seeing your entire chart disappear leads to a lot of "Never mind then, this is good enough."

#SharedHouseholds2020
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...1"] <- "Households"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "2018"] <- "2018_Number"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...3"] <- "2018_NumberMarginOfError"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...4"] <- "2018_Percent"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...5"] <- "2018_PercentMarginOfError"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "2019"] <- "2019_Number"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...7"] <- "2019_NumberMarginOfError"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...8"] <- "2019_Percent"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...9"] <- "2019_PercentMarginOfError"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "Change (2019 less 2018)*"] <- "Change_Number"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...11"] <- "Change_NumberMarginOfError"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...12"] <- "Change_Percent"
names(SharedHouseholds2020)[names(SharedHouseholds2020) == "...13"] <- "Change_PercentMarginOfError"

#StateGrid
#Perfect, except for the bottom two rows which I am pretty sure will delete the first column...

#StatePoverty
#A mess, why couldn't you be like your brother StateGrid?
names(StatePoverty)[names(StatePoverty) == "...2"] <- "2017-2019Average_Percentage"
names(StatePoverty)[names(StatePoverty) == "...3"] <- "2017-2019Average_MarginOfError"
names(StatePoverty)[names(StatePoverty) == "2-year average"] <- "2016-2017Average_Percentage"
names(StatePoverty)[names(StatePoverty) == "...5"] <- "2016-2017Average_MarginofError"
names(StatePoverty)[names(StatePoverty) == "...6"] <- "2018-2019Average_Percentage"
names(StatePoverty)[names(StatePoverty) == "...7"] <- "2018-2019Average_MarginOfError"
names(StatePoverty)[names(StatePoverty) == "Change in percentage points (2018-2019 average less 2016-2017 average)"] <- "ChangeinPercentage"
names(StatePoverty)[names(StatePoverty) == "...9"] <- "ChangeinPercentage_MarginOfError"
StatePoverty <- StatePoverty[-c(1, 2, 3, 4, 5, 7, 18, 29, 40, 63, 64, 65, 66, 67), ]

dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)

server = function(input, output) {
    incomeData <- reactive({
    
    if(input$IncomeInput=='TableA1'){
      incomeData <- TableA1
    }
    if(input$IncomeInput=='TableA2'){
      incomeData <- TableA2
    }
    if(input$IncomeInput=='TableC1'){
      incomeData <- TableC1
    }
  })
  
  inequalityData <- reactive({
    
    if(input$InequalityInput=='TableA3'){
      inequalityData <- TableA3
    }
    if(input$InequalityInput=='TableA2'){
      inequalityData <- TableA4
    }
    if(input$InequalityInput=='TableC1'){
      inequalityData <- TableA5
    }
  })
  
  earningsData <- reactive({
    
    if(input$EarningsInput=='TableA6'){
      earningsData <- TableA6
    }
    if(input$EarningsInput=='TableA7'){
      earningData <- TableA7
    }
  })
  
  povertyData <- reactive({
    if(input$EarningsInput== 'TableB1'){
      povertyData <- TableB1
    }
    if(input$EarningsInput== 'TableB2'){
      povertyData <- TableB2
    }
    if(input$EarningsInput== 'TableB3'){
      povertyData <- TableB3
    }
    if(input$EarningsInput== 'TableB4'){
      povertyData <- TableB4
    }
    if(input$EarningsInput== 'TableB5'){
      povertyData <- TableB5
    }
    if(input$EarningsInput== 'TableB6'){
      povertyData <- TableB6
    }
    if(input$EarningsInput== 'TableB7'){
      povertyData <- TableB7
    }
    if(input$EarningsInput== 'ImpactPoverty'){
      povertyData <- ImpactPoverty
    }
    if(input$EarningsInput== 'PovertyThresholds'){
      povertyData <- PovertyThresholds
    }
    if(input$EarningsInput== 'SharedHouseholds2020'){
      povertyData <- SharedHouseholds2020
    }
    if(input$EarningsInput== 'StateGrid'){
      povertyData <- StateGrid
    }
    if(input$EarningsInput== 'StatePoverty'){
      povertyData <- StatePoverty
    }
  })
  
  #Prepare Display Data
  output$displayData1 <- renderTable({ incomeData() })
  output$displayData2 <- renderTable({ inequalityData() })
  output$displayData3 <- renderTable({ earningsData() })
  output$displayData4 <- renderTable({ povertyData() })
  
  # Prepare Structure Tab
  renderstr1 <- reactive({ str(incomeData()) })
  renderstr2 <- reactive({ str(inequalityData()) })
  renderstr3 <- reactive({ str(earningsData()) })
  renderstr4 <- reactive({ str(povertyData()) })
  
  output$structure1 <- renderPrint({ renderstr1() })
  output$structure2 <- renderPrint({ renderstr2() })
  output$structure3 <- renderPrint({ renderstr3() })
  output$structure4 <- renderPrint({ renderstr4() })
  
  # Prepare Summary Tab
  rendersummary1 <- reactive({ summary(incomeData()) })
  rendersummary2 <- reactive({ summary(inequalityData()) })
  rendersummary3 <- reactive({ summary(earningsData()) })
  rendersummary4 <- reactive({ summary(povertyData()) })
  
  output$summary1 <- renderPrint({ rendersummary1() })
  output$summary2 <- renderPrint({ rendersummary2() })
  output$summary3 <- renderPrint({ rendersummary3() })
  output$summary4 <- renderPrint({ rendersummary4() })
  
  # Prepare Plot Tab
  output$graph1 <- renderPlot({
              Table <- gvisTable(incomeData(), 
                       formats=list(Value="#,###"))
              plot(Table)
  })
  output$graph1 <- renderPlot({
    Table <- gvisTable(inequalityData(), 
                       formats=list(Value="#,###"))
    plot(Table)
  })
  output$graph1 <- renderPlot({
    Table <- gvisTable(earningsData(), 
                       formats=list(Value="#,###"))
    plot(Table)
  })
  output$graph1 <- renderPlot({
    Table <- gvisTable(povertyData(), 
                       formats=list(Value="#,###"))
    plot(Table)
  })
}  
