library(shiny)
library(shinydashboard)

library(ggplot2)
library(plotly)
# library(ggthemes)
library(dplyr)
library(caTools)
library(hrbrthemes)
library(stringi)

# Load data from rds

setwd("~/EST/LP/Stage/Projet")

# Data is loaded along with overview parameters in dashboard_overview.R

source("./dashboard_overview.R")

server <- function(input, output) {

  # Global overview
  # Value Boxes outputs
  
  # Cars counts valuebox
  
  output$valuebox_cars_count <- renderValueBox({
    valueBox(cars_count, color = "aqua", "Cars", icon = icon("car"))
  })
  
  # Manufacturers counts valuebox
  
  output$valuebox_manufacturers_count <- renderValueBox({
    valueBox(manufacturers_count, color = "light-blue", "Manufacturers", icon = icon("copyright"))
  })
  
  # States counts valuebox
  
  output$valuebox_states_count <- renderValueBox({
    valueBox(states_count, color = "blue", "States", icon = icon("flag-usa"))
  })
  
  # Car types counts valuebox
  
  output$valuebox_cars_types_count <- renderValueBox({
    valueBox(cars_types_count, color = "blue", "cars types", icon = icon("car-side"))
  })
  
  # Total odometer valuebox
  
  output$valuebox_total_odometer <- renderValueBox({
    valueBox(total_odometer, color = "light-blue", "Total odometer", icon = icon("tachometer-alt"))
  })
  
  # Price range valuebox
  
  output$valuebox_price_range <- renderValueBox({
    valueBox(price_range, color = "aqua", "Price range", icon = icon("money-bill-wave"))
  })
  
  
  
  
  # Plots section
  # Plot outputs
  
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
      geom_segment(alpha = 0.02, colour = "black", aes(x = year, xend = year, y = price, yend = 0)) +
      geom_point(size = 1, aes(colour = year)) +
      theme_ipsum() +
      theme(legend.position = "none") +
      labs(x = "", y = "")
    
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
      labs(x = "", y = "")
    
    ggplotly(vehicles_nbr_manufacturer_plot)
    
  })
  
  # Vehicles prices by year
  
  output$plot_vehicles_prices_year <- renderPlotly({
    
    vehicles_prices_plot <- used_cars_data %>%
      tail(input$vehicles_demo_nbr_slider_input) %>%
      ggplot( aes(x = year, y = price, size = odometer, color = size)) +
      geom_point(alpha = 0.5) +
      # theme_minimal() +
      theme_ipsum() +
      labs(x = "Years", y = "")
    
    ggplotly(vehicles_prices_plot)
    
  })
  
  # Vehicles count by fuel
  
  output$plot_vehicles_fuel_count <- renderPlotly({
    
    fuel_count_plot <- used_cars_data %>%
      filter(price > input$fuel_price_range_slider_input[1]) %>%
      filter(price < input$fuel_price_range_slider_input[2]) %>%
      count(fuel) %>%
      ggplot(aes(x = reorder(fuel, -n, desc), y = n, colour = fuel)) +
      geom_point(size = 4, alpha = 0.7) +
      geom_segment(alpha = 0.5, size = 1.5, aes(x = fuel, xend = fuel, y = n, yend = 0)) +
      scale_x_discrete() +
      coord_flip() +
      theme(legend.position = "none") +
      labs(x = "", y = "") +
      theme_bw()
    
    ggplotly(fuel_count_plot)
    
  })
  
  # Vehicles prices by state
  
  output$plot_vehicles_count_state <- renderPlotly({
    
    price_state_plot <- used_cars_data %>%
      filter(price > input$state_price_range_slider_input[1]) %>%
      filter(price < input$state_price_range_slider_input[2]) %>%
      count(state) %>%
      mutate(state = stri_trans_toupper(state)) %>%
      ggplot(aes(x = reorder(state, -n, desc), y = n, colour = state)) +
      geom_point(alpha = 0.7, size = 5) +
      geom_segment(alpha = 0.5, size = 3, aes(x = state, xend = state, y = n, yend = 0)) +
      coord_flip() +
      theme_bw() +
      theme(legend.position = "right") +
      labs(x = "", y = "")
    
    ggplotly(price_state_plot)
    
  })
  
  # Vehicles prices by state
  
  output$plot_vehicles_condition_type <- renderPlotly({
    
    condition_price_plot <- used_cars_data %>%
      head(input$vehicles_demo_nbr_condition_slider_input) %>%
      ggplot( aes(x = condition, y = price)) +
      geom_boxplot(alpha = 0.7) +
      geom_point(alpha = 0.5, aes(colour = drive))+
      theme_bw()
    
    ggplotly(condition_price_plot)
    
  })
  
  
  
  
  
}