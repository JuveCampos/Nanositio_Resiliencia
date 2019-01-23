# Librerias

library(dplyr)
library(sf)
library(leaflet)

# Funciones
# Funciones personales
# Correccion! Funciones que crei que serian buena idea pero nooooo!
mapas_juve <- function(data, var_interes, paleta, label, popup = NULL, capa = NULL, identificador_poligono = NULL, 
                       providerTile = "CartoDB.Positron"){
  leaflet::leaflet(data) %>%
    addProviderTiles(providerTile) %>%
    addPolygons(weight = 1, 
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 0.5,
                fillColor = paleta(var_interes),
                color = "#444444",
                popup = popup,
                layerId = identificador_poligono,
                highlightOptions = highlightOptions(color = "white", weight = 2,
                                                    bringToFront = TRUE),
                label = label,
                labelOptions = labelOptions(direction = "auto"),
                group = capa) 
}

add_poligono_juve <- function(map, data, var_interes, paleta, label, popup = NULL, capa = NULL, identificador_poligono = NULL){
  addPolygons(map = map,
              data  = data, 
              weight = 1, 
              smoothFactor = 0.5,
              opacity = 1.0,
              fillOpacity = 0.5,
              fillColor = paleta(var_interes),
              color = "#444444",
              popup = popup,
              layerId = identificador_poligono,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE),
              label = label,
              labelOptions = labelOptions(direction = "auto"),
              group = capa
  ) 
}

# Info Util
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", 
           "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")

# Division Politica
root <- "www/geojsons/"
zmvm <- st_read("https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/ZMVM_shell.geojson", quiet = TRUE)
zmvm_muni <- st_read("https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EdosZM.geojson", quiet = TRUE)
zmvm_edos <- st_read("https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EstadosZMVM.geojson", quiet = TRUE)

# Info Hidrologia st_read(paste0(root, "Hidrologia/.geojson"), quiet = TRUE)
Acuiferos      <- st_read(paste0(root, "Hidrologia/Acuiferos.geojson"),            quiet = TRUE)
Cuenca         <- st_read(paste0(root, "Hidrologia/Cuenca.geojson"),               quiet = TRUE)
RH             <- st_read(paste0(root, "Hidrologia/RegionesHidrologicas.geojson"), quiet = TRUE)
CuerposAgua    <- st_read(paste0(root, "Hidrologia/RH26_CuerposAgua.geojson"),     quiet = TRUE)
RiosGrandes    <- st_read(paste0(root, "Hidrologia/RiosGrandes.geojson"),          quiet = TRUE)

# Informacion #
info_hidrologica <- c("Cuencas", "Acuiferos", "Region Hidrológica", 
                      "Principales Rios", "Climas", "Tipos de Suelo")

info_infraestructura <- c("Acceso al agua", "Estaciones de Medición", 
                          "Presas", "Distritos de Riego Agrícolas", 
                          "Instalaciones Sistema Cutzamala", "Pozos Sacmex")

info_hidrometeorologica <- c("Precipitación Mensual", "Temperatura", "Riesgo por Granizo", 
                             "Riesgo por tormentas", "Riesgo por sequía")

# %>%
  # addPolygons(data = zmvm_muni, color="black", fillColor = "gray", weight = 1, dashArray ="3,3") %>%
  # addPolygons(data = zmvm, color="black", weight = 2, fill = F) %>%
  # addPolygons(data = zmvm_edos, color="black", weight = 2, fill = F)


base <- leaflet %>% addProviderTiles("CartoDB.Positron")




