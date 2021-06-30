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
    title = "Used-Cars"

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

    tags$script(
      HTML("document.querySelector('body').classList.add('fixed');")
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

        # Global overview

        fluidRow(
          style = "margin-bottom: 50px",
          column(
            width = 12, 
            htmlTemplate("./www/Components/section_header.html", title = "Global Overview", bgcolor = "#588059"),
          ),
          div(
            style = "padding: 20px 10px;",
            
            # Number of cars valueBox
            valueBoxOutput("valuebox_cars_count"),

            # Number of manufacturers valueBox
            valueBoxOutput("valuebox_manufacturers_count"),

            # Number of states valueBox
            valueBoxOutput("valuebox_states_count"),

            # Number of cars types valueBox
            valueBoxOutput("valuebox_cars_types_count"),

            # Total odometer valueBox
            valueBoxOutput("valuebox_total_odometer"),

            # Price range valueBox
            valueBoxOutput("valuebox_price_range")
          )
        ),

        # Plots Sections
    
        fluidRow(
          fluidRow(

            # Price increase section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Price increase by years", bgcolor = "#6887c9"),
              
              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "price_increase_range_slider_input", 
                  "Years range of price increase displayed :", 
                  min = 1960, max = 2025, value = c(2005, 2025),
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_price_increase_years")
                )
              ),

            ),

            # Top manufacturers section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Top manufacturers by vehicles number", bgcolor = "#588059"),

              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "manufacturer_vehicles_slider_input", 
                  "Number of displayed manufacturers : ", 
                  min = 2, max = 40, value = 10,
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_manufacturer_vehicles")
                )
              ),

            ),

            # Price over year section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Vehicles prices over the years", bgcolor = "#588059"),

              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "vehicles_demo_nbr_slider_input", 
                  "Number of vehicles demo : ", 
                  min = 20, max = 500, value = 200, step = 10,
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_vehicles_prices_year")
                )
              ),
            ),

            # Vehciles count by fuel section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Vehicles count by fuel type", bgcolor = "#6887c9"),

              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "fuel_price_range_slider_input", 
                  "Price range of vehicles : ", 
                  min = 500, max = 300000, value = c(10000, 200000), step = 500,
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_vehicles_fuel_count")
                )
              ),
            ),

            # Vehciles count by state section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Vehicles counts by state", bgcolor = "#6887c9"),

              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "state_price_range_slider_input", 
                  "Price range of vehicles : ", 
                  min = 500, max = 300000, value = c(10000, 200000), step = 500,
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_vehicles_count_state")
                )
              ),
            ),

            # Vehciles count by state section
            column(
              width = 6,
              htmlTemplate("./www/Components/section_header.html", title = "Price by condition and vehicles type", bgcolor = "#588059"),

              div(
                style = "padding : 20px; width : 100%; padding-top : 0px",
                sliderInput(
                  "vehicles_demo_nbr_condition_slider_input", 
                  "Number of vehicles demo : ", 
                  min = 20, max = 500, value = 200, step = 10,
                  width = "100%"
                ),

                div(
                  style = "border-radius : 10px; overflow : hidden; margin-bottom : 50px",
                  plotlyOutput("plot_vehicles_condition_type")
                )
              ),
            )
          )
        ),
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