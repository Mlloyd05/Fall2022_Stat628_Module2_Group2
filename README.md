# Stat 628 Module 2 Group2 BodyFat Calculator
## Group 2: Marwan Lloyd, Shuwei Liu, David Gao
This is a project aiming to build a simple, robust, and accurate model for determining the body fat percentage of users. After using PCA, PCA stepwise selection, and simple linear regression, we found that body fat is highly correlated to weight and abdomen and developed a Multi-Linear model using these variables in order to optimize the trade-off between simplicity and accuracy.

Link to our Shiny App: [Calculator](https://mlloyd05.shinyapps.io/bodyfat_shiny_app/)
# Code
- preprocessing.R is the code we used to clean the BodyFat.csv data.
- Bodyfat_Analysis.Rmd is the overall code for our study, including model selection, model visualization and Shiny App.
- For running the code of Bodyfat_Analysis, all code can be run in chronological chunks down the file. No other special considerations are required. 
# Data
- BodyFat.csv is the original data that contains 252 observations and 16 varibles(excluding the id number).
- adjusted_bodyfat.csv is the data we used after data cleaning, two body fat outliers were removed and one observation's height was corrected.
# Images
This folder contains all the visualizations we used in our study, including the images used in executive summary and Powerpoint Slides.
#Module 2 Starter Materials and Misc
These folders are not tied to module 2 submission 
#Bodyfat Group2.pptx
Our powerpoint presentation for Module 2
#Module2Stat628Group2.pdf
Our 2 page executive summary for Module 2
