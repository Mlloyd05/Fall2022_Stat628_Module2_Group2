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
  
  output$calculated_bodyfat <- renderText(paste(c(round(-40.47 - .31*input$Weight + .91 * input$Abdomen,2)),"%"))
  
  output$general_scatter <-  renderPlot({ 
    ggplot(body_fat,aes(input$stat_dropdown,BODYFAT)) + 
      labs(x = input$stat_dropdown, y = "Body Fat", title = "Body Fat Scatterplot") +
      geom_jitter(aes(x = input$stat_dropdown,y = BODYFAT, color = input$stat_dropdown, size = BODYFAT))
  })
}