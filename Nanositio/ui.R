
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Propuesta Nanositio"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(

      radioButtons("rbOp1", "Seleccione Información:",
                   c("División Política" = "divPol",
                     "Hidrometeorológica" = "hm",
                     "Hidrología" = "hid",
                    # "Sísmica" = "sis",
                    # "Otros Riesgos" = "or",
                     "Infraestructura" = "inf")),
      # divPol, hm, hid, sis, or, inf
      
      htmlOutput("opciones_Hidrologia"),
      conditionalPanel(
        condition = "input.rbOp1 == 'hid'",
        radioButtons("rbHid", "Seleccione Capa:", info_hidrologica)
      ),
      conditionalPanel(
        condition = "input.rbOp1 == 'sis'",
        radioButtons("rbSis", "Seleccione Capa:", info_sismica)
      ),
      conditionalPanel(
        condition = "input.rbOp1 == 'hm'",
        radioButtons("rbHm", "Seleccione Capa:", info_hidrometeorologica)
      ),
      
                   htmlOutput("selMes"),
                   htmlOutput("opciones_Infraestructura")
      #, 
    #               textOutput("text"),
    #               textOutput("text2")
    ), # NOTA: ya despues descubri que Conditional panel y el HTMLOutput es lo mismo... 
    
    # Panel principal 
    mainPanel(
      shinycssloaders::withSpinner(leafletOutput("mapa", height = 500))
    )
  )
  # , 
  # br(), 
  # shiny::wellPanel(
  #   #textOutput("outputText")
  #   h2("Capa Seleccionada: "),
  #   h3(textOutput("outputText"))
  #   
  #)
))
