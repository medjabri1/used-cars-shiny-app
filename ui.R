# Preparing environnement

# Loading libraries

library(shiny)
library(shinydashboard)
library(shinymaterial)

# Creating pages 

home_page <- htmlTemplate("./www/Components/Showcase/Showcase.html", title = "Used-Cars")


# Creating UI Object for server to render

# ui <- fluidPage(
#   title = "USA Used-Cars",
#   home_page,
# )

ui <- dashboardPage(

  # Skin Theme of dashboard
  skin = "green",
  
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
          home_page
        )
      ),
      
      # Dashboard tab content
      tabItem(
        tabName = "dashboard",
        fluidRow(
          box(plotOutput("plot1", height = 250)),
          
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
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






# ------------------------------------------------------

# customDiv <- function() {
#   div(class = "div", "Hello world") 
# }
# 
# ui <- dashboardPage(
#   
#   # Header of dashboard container
#   dashboardHeader(
#     # Title of Dashboard
#     title = "Cars Dashboard"
#   ),
#   
#   # Side bar of dashboard
#   dashboardSidebar(
#     
#     # Side bar Menu
#     sidebarMenu(
#       
#       # Side bar Menu elements
#       # Dashboard tab
#       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
#       
#       # Price Prediction tab 
#       menuItem("Price Prediction", tabName = "prediction", icon = icon("th"))
#     )
#   ),
#   dashboardBody(
#     tabItems(
#       
#       # Dashboard tab content
#       tabItem(tabName = "dashboard",
#               fluidRow(
#                 box(plotOutput("plot1", height = 250)),
#                 
#                 box(
#                   title = "Controls",
#                   sliderInput("slider", "Number of observations:", 1, 100, input$sliderValue)
#                 )
#               )
#       ),
#       
#       # Price Prediction tab content
#       tabItem(tabName = "prediction",
#               h2("Price Prediction tab content")
#       )
#     ), 
#     
#     
#     # Custom div 
#     customDiv()
#   )
# )

# Cards / Tabs

# body <- dashboardBody(
#   fluidRow(
#     tabBox(
#       title = "First tabBox",
#       # The id lets us use input$tabset1 on the server to find the current tab
#       id = "tabset1", height = "250px",
#       tabPanel("Tab1", "First tab content"),
#       tabPanel("Tab2", "Tab content 2")
#     ),
#     tabBox(
#       side = "right", height = "250px",
#       selected = "Tab3",
#       tabPanel("Tab1", "Tab content 1"),
#       tabPanel("Tab2", "Tab content 2"),
#       tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
#     )
#   ),
#   fluidRow(
#     tabBox(
#       # Title can include an icon
#       title = tagList(shiny::icon("gear"), "tabBox status"),
#       tabPanel("Tab1",
#                "Currently selected tab from first box:",
#                verbatimTextOutput("tabset1Selected")
#       ),
#       tabPanel("Tab2", "Tab content 2")
#     )
#   )
# )
# 
# ui <- dashboardPage (
#   dashboardHeader(title = "tabBoxes"),
#   dashboardSidebar(),
#   body
# )

# Dashboard try

# ui <- dashboardPage(
#   dashboardHeader(title = "Info boxes"),
#   dashboardSidebar(),
#   dashboardBody(
#     # infoBoxes with fill=FALSE
#     fluidRow(
#       # A static infoBox
#       infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
#       # Dynamic infoBoxes
#       infoBoxOutput("progressBox"),
#       infoBoxOutput("approvalBox")
#     ),
#     
#     # infoBoxes with fill=TRUE
#     fluidRow(
#       infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
#       infoBoxOutput("progressBox2"),
#       infoBoxOutput("approvalBox2")
#     ),
#     
#     fluidRow(
#       # Clicking this will increment the progress amount
#       box(width = 4, height = 150, actionButton("count", "Increment progress")),
#       box( 
#         width = 8,
#         height = 150,
#         title = "Controls",
#         sliderInput("slider", "Number of observations:", 2, 100, 50, 2)
#       )
#     )
#   )
# )
