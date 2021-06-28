library(shiny)
library(shinydashboard)

server <- function(input, output, session) {}

# server <- function(input, output) {
#   output$progressBox <- renderInfoBox({
#     infoBox(
#       "Progress", paste0(input$slider, "%"), icon = icon("list"),
#       color = "purple"
#     )
#   })
#   output$approvalBox <- renderInfoBox({
#     # Icon provided from glyphicon
#     infoBox(
#       "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
#       color = "yellow"
#     )
#   })
#   
#   # Same as above, but with fill=TRUE
#   output$progressBox2 <- renderInfoBox({
#     infoBox(
#       "Progress", paste0(input$slider, "%"), icon = icon("list"),
#       color = "purple", fill = TRUE
#     )
#   })
#   output$approvalBox2 <- renderInfoBox({
#     # Icon provided from font awesome by default
#     infoBox(
#       "Approval", "80%", icon = icon("thumbs-up"),
#       color = "yellow", fill = TRUE
#     )
#   })
# }