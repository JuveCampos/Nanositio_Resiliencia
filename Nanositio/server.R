#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
########
# MAPA #
########  
    
  output$Mapa <- renderLeaflet({

    # print(input$rbHid)
    # base <- leaflet() %>% addProviderTiles(input$SP)
    
    if (input$rbOp1 == "divPol") {
      base %>% addPolygons(data = zmvm_muni, color="black", fillColor = "gray", weight = 1, dashArray ="3,3", 
                           label = paste0(zmvm_muni$NOM_MUN, ", ", zmvm_muni$ESTADO.C.31)) %>%
        addPolygons(data = zmvm, color="black", weight = 2, fill = F) %>%
        addPolygons(data = zmvm_edos, color="black", weight = 2, fill = F)
    } else if(input$rbOp1 == "divPol") {
      base 
    } else if(input$rbOp1 == "hm") {
      base 
    } else if(input$rbOp1 == "sis") {
      base 
    } else if (!is.null(input$rbHid) & input$rbHid == "Acuiferos") {
      var_interes <- Acuiferos$SOBREXP14
      pal <- colorFactor(palette = "RdYlBu", domain = var_interes, reverse = F)
      popup <- paste0("<b>Nombre del acuífero: </b>", Acuiferos$ACUÍFERO, "<br/>",
                      "<b>Entidad: </b>", Acuiferos$NOM_EDO, "<br/>",
                      "<b>Volúmen de recarga: </b>", Acuiferos$RECARGA, " Hm<sup>3</sup><br/>",
                      "<b>Volumen de Déficit: </b>", Acuiferos$DÉFICITJUN, " Hm<sup>3</sup><br/>",
                      "<b>Año de ultima medicion: </b> 2014" , "<br/>")
      base %>% add_poligono_juve(data = Acuiferos, popup = popup, var_interes = var_interes, paleta = pal, label = Acuiferos$ACUÍFERO) %>%
        addLegend(position = "bottomright", pal = pal, values = var_interes, title = "<b>Condición de</br> Explotación</b>")
       
    } 

  }) 
  
  ############
  # OPCIONES #
  ############
    output$opciones_Hidrologia <- renderUI({
    if (input$rbOp1 == "hid") {
      radioButtons("rbHid", "Seleccione Capa:", info_hidrologica)
    }
  })
    
    output$opciones_HidroMeteo <- renderUI({
      if (input$rbOp1 == "hm") {
        radioButtons("rbHm", "Seleccione Capa:", info_hidrometeorologica)
      }
    })
    
    output$opciones_Infraestructura <- renderUI({
      if (input$rbOp1 == "inf") {
        radioButtons("rbinf", "Seleccione Capa:", info_infraestructura)
      }
    })
    
  
})
