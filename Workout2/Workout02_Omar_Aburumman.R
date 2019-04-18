library(shiny)
library(ggplot2)
ui <- fluidPage(
  
  # Application title
  titlePanel("Investing Modalities"),
  
  fluidRow(
    column(4, 
           sliderInput("Amount", 
                       "Initial amount",
                       min = 0, 
                       max = 100000, 
                       value = 1000,
                       pre = "$",
                       step = 500)),
    column(4, 
           sliderInput("Return",
                       "Return rate (in %)",
                       min = 0,
                       max = 20,
                       value = 5,
                       step = 0.1)),
    column(4, 
           sliderInput("Time",
                       "years",
                       min = 0,
                       max = 50,
                       value = 20,
                       step = 1))
  ),
  fluidRow(
    column(4, 
           sliderInput("Contrib", 
                       "Annual Contribution",
                       min = 0, 
                       max = 50000,  
                       value = 2000,
                       pre = "$",
                       step = 500)),
    column(4,
           sliderInput("Growth",
                       "Growth Rate (in %)",
                       min = 0,
                       max = 20,
                       value = 2,
                       step = 0.1)),
    column(4, 
           selectInput(inputId = "Binary", 
                       label = "Facet?",
                       choices = c("No", "Yes")
           )
    )
  ),

    # Show a plot of the generated distribution
    mainPanel(
      hr(),
      h4("Timelines"),
      plotOutput(outputId = "line_graph"),
      h4("Balances"),
      verbatimTextOutput("Balances"),
      verbatimTextOutput("table")

))
   
    
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  moda <- reactive({
    future_value <- function(amount, rate, years){
      fv <- amount*((1+rate)^{years})
      return(fv)
    }
    
    annuity <- function(contrib, rate, years){
      fva <- contrib*(((1+rate)^{years}) - 1)/(rate)
      return(fva)
    }
    
    growing_annuity <- function(contrib, rate, growth, years){
      fvga <- contrib*((((1+rate)^{years}) - ((1+growth)^{years}))/(rate- growth))
      return(fvga)
    }
  fv <- rep(0,input$Time)
  new_fva <- rep(0,input$Time)
  new_fvga <- rep(0,input$Time)
  
  for (years in 0:input$Time){
    fv_wo = future_value(input$Amount, input$Return/100, years)
    fv[years+1] = fv_wo
  }
  fv
  
  for (years in 0:input$Time){
    fva_wo = future_value(input$Amount, input$Return/100, years) + annuity(input$Contrib, input$Return/100, years)
    new_fva[years+1] = fva_wo
    }
  new_fva
  
  for (years in 0:input$Time){
    fvga_wo = future_value(input$Amount, input$Return/100, years) + growing_annuity(input$Contrib, input$Return/100, input$Growth/100, years)
    new_fvga[years+1] = fvga_wo
    }
  new_fvga
  
  modalities <- data.frame("year" = c(0:input$Time), "no_contrib" = fv, "fixed_contrib" = new_fva, "growing_contrib" = new_fvga)
  modalities
  
  
  })
  

  output$line_graph <- renderPlot({
    fv <- moda()$no_contrib
    new_fva <- moda()$fixed_contrib
    new_fvga <- moda()$growing_contrib
    if (input$Binary == "Yes") {
      facet_modalities <- data.frame(
        modes = factor(rep(c("no_contrib", "fixed_contrib", "growing_contrib"), each = input$Time + 1), 
                       levels = c("no_contrib", "fixed_contrib", "growing_contrib")), 
        year = rep(0:input$Time, 3),
        value = c(fv, new_fva, new_fvga))
      ggplot(data = facet_modalities, aes(x = year, y = value, colour = modes, fill = modes)) + 
        facet_grid(.~modes) + geom_line() + geom_point() + 
        labs(title = "Three modes of investing") + 
        scale_colour_brewer(palette = "Set1", name = "variable") + 
        scale_fill_brewer(palette = "Set1", name = "variable") + geom_area(alpha = 0.3) + geom_point() + theme_bw()
    }
    else{
    ggplot(data = moda()) +         geom_line(aes(x = year, y = growing_contrib, color = "red")) +        
        geom_line(aes(x = year, y = fixed_contrib, color = "green")) + 
    geom_line(aes(x = year, y = no_contrib, color = "blue")) + 
        theme_bw() + xlab("Years") + ylab("Value") + 
        ggtitle("Three modes of investing") + xlim(0, 10) + 
        ylim(0, 30000) +
        scale_color_discrete(name = "Key", labels = c("No_Contribution", "Fixed_Contribution", "Growing_Contribution"))
    }
      })
  output$table <- renderPrint({moda()})
  
}


# Run the application 
shinyApp(ui = ui, server = server)


