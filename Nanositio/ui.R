
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Propuesta Nanositio"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
# selectInput("SP","Select Provider", 
#             choices = unlist(leaflet::providers) %>% 
#               as.character(), selected = "CartoDB.Positron"),
      
      radioButtons("rbOp1", "Seleccione Información:",
                   c("División Política" = "divPol",
                     "Hidrometeorológica" = "hm",
                     "Hidrología" = "hid",
                     "Sísmica" = "sis",
                     "Otros Riesgos" = "or",
                     "Infraestructura" = "inf")),
                   htmlOutput("opciones_Hidrologia"),
                   htmlOutput("opciones_HidroMeteo"),
                   htmlOutput("opciones_Infraestructura")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      shinycssloaders::withSpinner(leafletOutput("Mapa", height = 500))
    )
  )
))
