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

# Load regression tree model from rds file ./model/tree_model.rds

tree_model <- readRDS("./model/tree_model.rds")

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
  
  # Prediction Section
  
  # regions list
  
  output$ui_input_select_region <- renderUI({
    selectInput(
      "region_select_input",
      "Select your region", 
      mutate(region_list, region = stri_trans_toupper(region))
    )
  })
  
  # year list
  
  output$ui_input_select_year <- renderUI({
    selectInput(
      "year_select_input",
      "Select model year", 
      year_list
    )
  })
  
  # manufacturers list
  
  output$ui_input_select_manufacturer <- renderUI({
    selectInput(
      "manufacturer_select_input", 
      "Select vehicle manufacturer", 
      mutate(manufacturers_list, manufacturer = stri_trans_toupper(manufacturer))
    )
  })
  
  # condition list
  
  output$ui_input_select_condition <- renderUI({
    selectInput(
      "condition_select_input", 
      "Select vehicle condition", 
      mutate(condition_list, condition = stri_trans_toupper(condition))
    )
  })
  
  # types list
  
  output$ui_input_select_type <- renderUI({
    selectInput(
      "type_select_input", 
      "Select vehicle type", 
      mutate(types_list, type = stri_trans_toupper(type))
    )
  })
  
  # status list
  
  output$ui_input_select_status <- renderUI({
    selectInput(
      "status_select_input", 
      "Select vehicle status", 
      mutate(status_list, title_status = stri_trans_toupper(title_status))
    )
  })
  
  # cylinders list
  
  output$ui_input_select_cylinders <- renderUI({
    selectInput(
      "cylinders_select_input", 
      "Select vehicle cylinders", 
      mutate(cylinders_list, cylinders = stri_trans_toupper(cylinders))
    )
  })
  
  # fuel list
  
  output$ui_input_select_fuel <- renderUI({
    selectInput(
      "fuel_select_input", 
      "Select vehicle fuel", 
      mutate(fuel_list, fuel = stri_trans_toupper(fuel))
    )
  })
  
  # transmission list
  
  output$ui_input_select_transmission <- renderUI({
    selectInput(
      "transmission_select_input", 
      "Select vehicle transmission", 
      mutate(transmission_list, transmission = stri_trans_toupper(transmission))
    )
  })
  
  # size list
  
  output$ui_input_select_size <- renderUI({
    selectInput(
      "size_select_input", 
      "Select vehicle size", 
      mutate(size_list, size = stri_trans_toupper(size))
    )
  })
  
  # drive list
  
  output$ui_input_select_drive <- renderUI({
    selectInput(
      "drive_select_input", 
      "Select vehicle drive", 
      mutate(drive_list, drive = stri_trans_toupper(drive))
    )
  })
  
  # paint list
  
  output$ui_input_select_paint <- renderUI({
    selectInput(
      "paint_select_input", 
      "Select vehicle paint", 
      mutate(paint_list, paint_color = stri_trans_toupper(paint_color))
    )
  })
  
  # state list
  
  output$ui_input_select_state <- renderUI({
    selectInput(
      "state_select_input", 
      "Select your state", 
      mutate(states_list, state = stri_trans_toupper(state))
    )
  })
  
  # Submit Action button
  
  observeEvent(input$submit_prediction_button_input, {
    
    cat("prediction started\n")
    
    item.region <- stri_trans_tolower(input$region_select_input)
    item.odometer <- input$odometer_number_input
    item.manufacturer <- stri_trans_tolower(input$manufacturer_select_input)
    item.condition <- stri_trans_tolower(input$condition_select_input) ########
    item.year <- as.numeric(input$year_select_input)
    item.type <- stri_trans_tolower(input$type_select_input) #######
    item.title_status <- stri_trans_tolower(input$status_select_input)
    item.cylinders <- stri_trans_tolower(input$cylinders_select_input)
    item.fuel <- stri_trans_tolower(input$fuel_select_input)
    item.transmission <- stri_trans_tolower(input$transmission_select_input)
    item.size <- stri_trans_tolower(input$size_select_input)
    item.drive <- stri_trans_tolower(input$drive_select_input)
    item.paint_color <- stri_trans_tolower(input$paint_select_input)
    item.state <- stri_trans_tolower(input$state_select_input)
    
    pred <- predict(tree_model, item)
    
    cat("\n\n\n")
    (item)
    cat("\n\n\n")
    cat(pred[1])
    
    # output$predicted_price_output <- renderText({ paste("Predicted price :", round(pred[1], digits = 0), "$") })
    output$predicted_price_output <- renderText({ item.type })
    
    cat("prediction finished\n")
  })
  
}