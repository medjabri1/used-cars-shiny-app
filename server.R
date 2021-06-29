library(shiny)
library(shinydashboard)

library(ggplot2)
library(plotly)
# library(ggthemes)
library(dplyr)
library(caTools)
library(hrbrthemes)

# Load data from rds

setwd("~/EST/LP/Stage/Projet")

used_cars_data <- readRDS("data/my_data.rds")

server <- function(input, output) {

  # Plot outputs
  
  output$test_plot <- renderPlot({
    Temperature <- airquality$Temp
    hist(Temperature)
  })
  
  # Price Increase by years plot
  
  output$plot_price_increase_years <- renderPlotly({
    
    myplot <- used_cars_data %>%
      head(200) %>%
      filter(year > input$price_increase_range_slider_input[1]) %>%
      filter(year < input$price_increase_range_slider_input[2]) %>%
      group_by(year) %>%
      mutate(price = mean(price)) %>%
      ggplot(aes(x = year, y = price)) +
      geom_line(alpha = 0.2, colour = "black") +
      geom_segment(alpha = 0.2, colour = "black", aes(x = year, xend = year, y = price, yend = 0)) +
      geom_point(size = 1, aes(colour = year)) +
      theme_ipsum() +
      theme(legend.position = "none")
    
    ggplotly(myplot)
    
  })
  
  # Top manufacturers by vehicles count
  
  output$plot_manufacturer_vehicles <- renderPlotly({
    
    vehicles_nbr_manufacturer_plot <- used_cars_data %>%
      count(manufacturer) %>%
      arrange(desc(n)) %>%
      top_n(input$manufacturer_vehicles_slider_input) %>%
      ggplot(aes(x = reorder(manufacturer, -n, desc), y = n, colour = manufacturer)) +
      geom_point(size = 2, alpha = 0.7) +
      geom_segment(alpha = 0.7, size = 0.5, aes(x = manufacturer, xend = manufacturer, y = n, yend = 0)) +
      coord_flip() +
      theme_bw() +
      theme(legend.position = "none") +
      labs(x = "", y = "Number of vehicles")
    
    ggplotly(vehicles_nbr_manufacturer_plot)
    
  })
  
  # Vehicles prices by year
  
  output$plot_vehicles_prices_year <- renderPlotly({
    
    vehicles_prices_plot <- used_cars_data %>%
      sample_n(input$vehicles_demo_nbr_slider_input) %>%
      ggplot( aes(x = year, y = price, size = odometer, color = size)) +
      geom_point(alpha = 0.5) +
      # theme_minimal() +
      theme_ipsum()
    
    ggplotly(vehicles_prices_plot)
    
  })
  
}