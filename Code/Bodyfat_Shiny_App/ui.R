library(shiny)
library(shinythemes)
library(rsconnect)

ui <- 
  navbarPage("Group 2 Shiny", collapsible = TRUE, inverse = TRUE, theme = shinytheme("spacelab"),
             #             tabPanel("All Stat Scatterplots",
             #                      fluidPage(
             #                      selectInput("stat_dropdown", "Select a Stat of Interest", #choices = colnames(body_fat)[3:17], multiple = FALSE),
             #                      plotOutput("general_scatter")
             #                      )),
             tabPanel("Model Calculator",
                      sidebarLayout(sidebarPanel(numericInput("Weight", "Weight (in kg):", 0, min = 0, step = .01), numericInput("Abdomen", "Abdomen Circumference (in cm):", 0, min = 0, step = .01)),
                                    mainPanel("Calculated Body Fat percentage (Top) and Percentile Relative to the Dataset (Bottom):", verbatimTextOutput("calculated_bodyfat"),verbatimTextOutput("dataset_placement"), tags$head(tags$style("#calculated_bodyfat{color: black;
                                 font-size: 16px;
                                 }"
                                    )
                                    )),
                      )
             ),
             
             tabPanel("About", p("The model that our project decided to use was a multi-linear regression of body fat percentage on two variables: weight and abdomen circumfrence. The final equation (used in this calculator) determined for this regression was:"), 
                      em("Body Fat % = -40.47 - .31*Weight + .91 * Abdomen" )),
             
             tabPanel("Contact", p("This shiny app is maintained by Marwan Lloyd '23. For any questions, concerns, or feedback please reach out him at either of the below emails:"), tags$address("Marwan.Lloyd@Wisc.edu"), tags$address("Melloyd2@Wisc.edu"))
  )