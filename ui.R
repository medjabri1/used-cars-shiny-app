library(shiny)
library(shinydashboard)

ui <- fluidPage(
  
  htmlTemplate("./www/Components/Showcase/Showcase.html"),
  

  
  
  
)











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
