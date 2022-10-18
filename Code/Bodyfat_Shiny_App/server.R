body_fat <- read.csv('Shiny_Data/adjusted_bodyfat.csv')

server <- function(input, output) { 
  
  observeEvent(input$Weight,{
    if(input$Weight < 0 || isTRUE(is.na(input$Weight)) ){ 
      x <- 0}
    else{
      x <- input$Weight
    }
    updateNumericInput(getDefaultReactiveDomain(), "Weight", value = round(x,digits = 2))})
  
  observeEvent(input$Abdomen,{
    if(input$Abdomen < 0 || isTRUE(is.na(input$Abdomen)) ){ 
      y <- 0}
    else{
      y <- input$Abdomen
    }
    updateNumericInput(getDefaultReactiveDomain(), "Abdomen", value = round(y,digits = 2))})
  
  output$calculated_bodyfat <- renderText({
    percentage <- round(-40.47 - .31*input$Weight + .91 * input$Abdomen,2)
    
    if ((percentage >= 0) & (percentage <= 100)){paste(c(round(-40.47 - .31*input$Weight + .91 * input$Abdomen,2),"%"))}
    else if(percentage > 100){paste(">100%")}
    else if(percentage < 0) {paste("<0%")}
    
    })
  output$dataset_placement <- renderText({
    place <- 1 - length(body_fat$BODYFAT[body_fat$BODYFAT > round(-40.47 - .31*input$Weight + .91 * input$Abdomen,2)])/ length(body_fat$BODYFAT)
    
    if(place < 0){
      place <- 0
    }
    if(place > 1){
      place <- 1
    }
    
    paste(c(place * 100 ,"%"))
  })
  
}