# Preparing environnement

# Loading libraries

library(shiny)
library(shinydashboard)
library(shinymaterial)

library(ggplot2)
library(plotly)
# library(ggthemes)
library(dplyr)
library(caTools)
library(hrbrthemes)

# ui <- fluidPage(
#   plotlyOutput("plot_price_increase_years"),
#   div("Hello world"),
#   plotOutput("test_plot")
# )

# Creating pages 

ui_test <- dashboardPage(

  # Skin Theme of dashboard
  skin = "blue",

  # Header of dashboard container
  dashboardHeader(

    # Disable header of dashboard
    disable = FALSE,

    # Title of Dashboard
    title = "Used-Cars",

    # Drop Down menu to show progress
    dropdownMenu(
      type = "tasks",
      badgeStatus = "success",

      taskItem(value = 60, color = "green",
        "Documentation"
      ),
      taskItem(value = 17, color = "aqua",
        "Project X"
      ),
      taskItem(value = 0, color = "yellow",
        "Server deployment"
      ),
      taskItem(value = 30, color = "red",
        "Overall project"
      )
    )
  ),

  # Side bar of dashboard
  dashboardSidebar(

    # Side bar Menu
    sidebarMenu(

      # Side bar Menu elements
      # Home tab
      menuItem("Home", tabName = "home", icon = icon("home")),

      # Dashboard tab
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),

      # Price Prediction tab
      menuItem("Price Prediction", tabName = "prediction", icon = icon("th"))
    )
  ),
  dashboardBody(

    # Link External Scripts / Stylesheets

    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap"),
    ),

    tabItems(

      # Home tab content
      tabItem(
        tabName = "home",
        div(
          style = "height : 86vh ",
          htmlTemplate("./www/Components/Showcase/Showcase.html", title = "Used-Cars")
        )
      ),

      # Dashboard tab content
      tabItem(
        tabName = "dashboard",
        
        # Price Increase section
        fluidRow(
          fluidRow(
            column(
              width = 12,
              htmlTemplate("./www/Components/section_header.html", title = "Price increase by years")
            ),
            
            column(
              style = "padding-left : 50px",
              width = 12,
              sliderInput(
                "price_increase_range_slider_input", 
                "Years range of price increase displayed :", 
                min = 1960, max = 2025, value = c(1995, 2015)
              )  
            ),
            
            column(
              style = "padding: 30px; padding-top : 0px",
              width = 12,
              plotlyOutput("plot_price_increase_years")
            )
          )
        ),
        
        # Top manufacturers section
        fluidRow(
          fluidRow(
            column(
              width = 12,
              htmlTemplate("./www/Components/section_header.html", title = "Top manufacturers by vehicles count")
            ),
            
            column(
              style = "padding-left : 50px",
              width = 12,
              sliderInput(
                "manufacturer_vehicles_slider_input", 
                "Number of displayed manufacturers : ", 
                min = 2, max = 40, value = 10
              )  
            ),
            
            column(
              style = "padding: 30px; padding-top : 0px",
              width = 12,
              plotlyOutput("plot_manufacturer_vehicles")
            )
          )
        ),
        
        # Top manufacturers section
        fluidRow(
          fluidRow(
            column(
              width = 12,
              htmlTemplate("./www/Components/section_header.html", title = "Vehicles prices over the years")
            ),
            
            column(
              style = "padding-left : 50px",
              width = 12,
              sliderInput(
                "vehicles_demo_nbr_slider_input", 
                "Number of vehicles demo : ", 
                min = 20, max = 500, value = 200, step = 10
              )  
            ),
            
            column(
              style = "padding: 30px; padding-top : 0px",
              width = 12,
              plotlyOutput("plot_vehicles_prices_year")
            )
          )
        )
      ),

      # Price Prediction tab content
      tabItem(
        tabName = "prediction",
        h2("Price Prediction tab content")
      )
    )
  )
)

# Working directory
# setwd("~/EST/LP/Stage/Projet")