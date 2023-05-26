
# nao usar ----------------------------------------------------------------



library(leaflet)
library(leaflet.extras2)
library(htmltools)
library(dplyr)
library(sf)

# 
# # Cria o data frame com os dados do trajeto -------------------------------


dados_trajeto <- data.frame(
  data = c("9 de março"),
  descricao = c("Partiu Pindorama"),
  foto = c(
    "https://gifdb.com/images/file/intense-sinking-ship-6umyix3jg0hqpj6l.gif"
  ),
  fonte = c("https://br.pinterest.com/pin/723038915162158193/")
)



# # Define o GIF da caravela para os marcadores do trajeto ------------------


icone_caravela <-
  makeIcon(iconUrl = "https://www.animatedimages.org/data/media/271/animated-ship-image-0031.gif",
           iconWidth = 50,
           iconHeight = 50)


# 
# # Cria o mapa -------------------------------------------------------------
# 
# 
# mapa <- leaflet() %>%
#   addProviderTiles("Stamen.Watercolor") %>% #adiciona um mapa especifico de topogrtafia link:https://leaflet-extras.github.io/leaflet-providers
#   addProviderTiles("Stamen.TonerLabels") %>% # adiciona as legendas para localidade
#   setView(lng = -9.1, lat = 38.7, zoom = 12) %>%  # Centralize o mapa no oceano
#   addHistory()
# 
# 
# # # Adiciona a linha do trajeto da esquadra -------------------------------
# 
# 
# mapa <- mapa %>%
#   addPolylines(
#     lng = sapply(trajeto_cabral, `[`, 2),
#     lat = sapply(trajeto_cabral, `[`, 1),
#     color = "blue",
#     weight = 2
#   )
# 


# moving marker -----------------------------------------------------
popup_content <- paste(
  "<br><b>Destino:</b> ",
  dados_trajeto$descricao,
  "<br><img src='",
  dados_trajeto$foto,
  "' alt='Foto' style='max-width: 200px'>"
)

latitude = c(38.7, 28.1, 15.1, 4.64, -7.8, -13.13, -16.42, -16.44)
longitude = c(-9.1, -20.4, -27.6, -29.42, -32.4, -34.58, -38.80, -39.07)


mapa_move <-  leaflet()  %>%
  addTiles() %>%
  addPolylines(lng = longitude, lat = latitude,
               group = "rota") %>%
  addMovingMarker(
    group = "Frota",
    lng = longitude,
    lat = latitude,
    movingOptions = movingMarkerOptions(autostart = TRUE, loop = TRUE, pauseOnZoom = TRUE),#moving com leafletextra
    label = "Proxima parada: 'ÍNDIAS'!",
    icon = icone_caravela,
    popup = popup_content,
    duration = 28000
  ) %>%
  addProviderTiles("Stamen.Watercolor") 
  



mapa_move <- mapa_move %>% 
  addLayersControl(overlayGroups = c("rota","Frota")) %>% 
  hideGroup(c("rota"))
  
  


