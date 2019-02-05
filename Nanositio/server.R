#

# Define server logic required to draw a histogram
shinyServer(function(input, output, server) {
  
########
# MAPA #
########  

  a <- reactive({
    if (input$rbOp1 == opts1[2]){
      a <- input$rbHm   
    } else if (input$rbOp1 == opts1[3]){
      a <- input$rbHid    
    } else if (input$rbOp1 == opts1[6]){
      a <- input$rbInf
    } else if (input$rbOp1 == opts1[4]){
      a <- input$rbSis
    } else if (input$rbOp1 == 'divPol'){
      a <- input$rbOp1
    }
  })
  
  output$text <- renderText({
    paste0("Usted seleccionó ", a())
  })
  
  output$outputText <- renderText({
    a()
  })  
  
  output$mapa <- renderLeaflet({
#### D I V I S I O N   P O L I T I C A ########################################################################      
    if (input$rbOp1 == "divPol"){
          base %>% addPolygons(data = zmvm_muni, color="black", fillColor = "gray", weight = 1, dashArray ="3,3",
                               label = paste0(zmvm_muni$NOM_MUN, ", ", zmvm_muni$ESTADO.C.31)) %>%
            addPolygons(data = zmvm, color="black", weight = 2, fill = F) %>%
            addPolygons(data = zmvm_edos, color="black", weight = 2, fill = F)
#### H I D R O L O G I A ######################################################################################      
    } else if (a() == "Cuencas") {
      mapa <- readRDS("www/rds/Cuencas2.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Acuiferos") {
          var_interes <- Acuiferos$SOBREXP14
          pal <- colorFactor(palette = "RdYlBu", domain = var_interes, reverse = F)
          popup <- paste0("<b>Nombre del acuífero: </b>", Acuiferos$ACUÍFERO, "<br/>",
                          "<b>Entidad: </b>", Acuiferos$NOM_EDO, "<br/>",
                          "<b>Volúmen de recarga: </b>", Acuiferos$RECARGA, " Hm<sup>3</sup><br/>",
                          "<b>Volumen de Déficit: </b>", Acuiferos$DÉFICITJUN, " Hm<sup>3</sup><br/>",
                          "<b>Año de ultima medicion: </b> 2014" , "<br/>")
          base %>% add_poligono_juve(data = Acuiferos, popup = popup, var_interes = var_interes, paleta = pal, label = Acuiferos$ACUÍFERO) %>%
            addLegend(position = "bottomright", pal = pal, values = var_interes, title = "<b>Condición de</br> Explotación</b>")
    } else if (a() == "Region Hidrológica") {
            mapas_juve(data = RH, 
                       var_interes = RH$CLAVE, 
                       paleta = colorFactor("viridis", domain = RH$CLAVE), 
                       label = paste0("Region Hidrológica: ", RH$CLAVE, " ", RH$NOMBRE)) 
    } else if (a() == "Principales Rios") {
      base %>% addPolylines(data = RiosGrandes, weight = 1.0, color = 'blue')
#### H I D R O M E T E O R O L O G I C O S ########################################################################      
    } else if (a() == "Peligro por Tormenta y granizo") {
      mapa <- readRDS("www/rds/mapaPeligroTormentas.rds") %>% addProviderTiles("CartoDB.Positron")      
    } else if (a() == "Riesgo por sequía") {  
      mapa <- readRDS("www/rds/mapaPeligroSequias.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Riesgo por Bajas Temperaturas") {      
      mapa <- readRDS("www/rds/mapaBajasTemperaturas.rds")  %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Riesgo por Nevadas") {        
      mapa <- readRDS("www/rds/mapaNevadas.rds")  %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Riesgo por Inundaciones") {       
      mapa <- readRDS("www/rds/mapaPeligroInundaciones.rds")  %>% addProviderTiles("CartoDB.Positron")
      mapa
#### S I S M I C O S ########################################################################      
    } else if (a() == "Zonas Sismicas") {         
      mapa <- readRDS("www/rds/iese.rds") 
      mapa 
#### I N F R A E S T R U C T U R A ################################################################################      
    } else if (a() == "Instalaciones Sistema Cutzamala") {
      mapa <- readRDS("www/rds/ElementosCutzamala.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Centros Operativos y de investigación") {
      mapa <- readRDS("www/rds/CentrosEduc.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Distritos de Riego Agrícolas") {
      mapa <- readRDS("www/rds/Mapa_DR.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Estaciones de monitoreo de Calidad del Aire") {
      mapa <- readRDS("www/rds/Mapa_estaciones.rds") %>% addProviderTiles("CartoDB.Positron")
      mapa
    } else if (a() == "Pozos Sacmex") {
      mapa <- readRDS("www/rds/PozosSacMex.rds") %>% addProviderTiles("CartoDB.Positron")
    }  
})
  
############
# Opciones #
###########
    output$selMes <- renderUI({
      if (a() == 'Precipitación Mensual' | a() == "Temperatura Mensual"){
        selectInput("selTemp", "Seleccione mes", choices = meses, selected = meses[1])
      }
    })

    output$opciones_HidroMeteo <- renderUI({
      if (input$rbOp1 == "hm") {
        radioButtons("rbHm", "Seleccione Capa:", info_hidrometeorologica)
      }
    })
    
    output$opciones_Infraestructura <- renderUI({
      if (input$rbOp1 == "inf") {
        radioButtons("rbInf", "Seleccione Capa:", info_infraestructura)
      }
    })
    
})
