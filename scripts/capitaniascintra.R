library(leaflet)
library(sf)
library(tidyverse)

coordenadas <- read.csv("https://raw.githubusercontent.com/nextmarte/Educaser-Maps/main/dados/tabela_cintra.csv")

 #rio::export(coordenadas,"tabela-cintra","csv")


#temos que multiplicar por -1
coordenadas$Lon <- -1*coordenadas$Lon
coordenadas$Lat <- -1*coordenadas$Lat


latitudes <- unique(coordenadas$Lat)
longitude <- unique(coordenadas$Lon)
# Criar um mapa com base nos dados das Capitanias Hereditárias
mapa <- leaflet(coordenadas) %>%
  addTiles() %>%
  setView(lng = -45, lat = -15, zoom = 4)  # Configurar a visualização inicial do mapa

mapa

# Adicionar marcadores para cada Capitania Hereditária
mapa <- mapa %>%
  addCircleMarkers(
    lng = ~Lon,
    lat = ~Lat,
    label = ~DONATARIO,
    popup = ~CAPITANIA
    
  )


mapa

# done linhas horizontais ------------------------------------------------------------------


for (i in 17:7) {
  mapa <- mapa %>%
    addPolylines(
      lng = c(coordenadas$Lon[i], min(longitude)),
      lat = c(coordenadas$Lat[i], latitudes[i]),
      color = "red",
      weight = 2,
      label = paste0("latitude: ",coordenadas$Lat[i])
    )
}

mapa


#done linhas verticais --------------------------------------------------------

for (i in 1:7) {
  mapa <- mapa %>%
    addPolylines(
      lat = c(coordenadas$Lat[i], coordenadas$Lat[7]),
      lng = c(coordenadas$Lon[i], coordenadas$Lon[i]),
      color = "red",
      weight = 2,
      label = paste0("longitude: ",coordenadas$Lon[i])
    )
}

mapa



# costa brasileira em desenvolvimento--------------------------------------------------------



Brasil <- geobr::read_country(year = 2010)




Brasil_df <- as.data.frame(st_coordinates(Brasil)) %>% 
  select(1:2) 

  colnames(Brasil_df) <- c("lon","lat")

Brasil_df_filter <- Brasil_df %>% 
  filter(lon>=-48.7)


plot(Brasil_df_filter)


mapa %>% 
  addPolylines(lng = Brasil_df_filter$lon,
               lat = Brasil_df_filter$lat)

# costa -------------------------------------------------------------------

# costa <- read.csv("dados/coordenadas_costa_Brasil.csv",sep = ";")
# 
# mapa %>% 
#   addPolylines(lng = costa$lon,
#                lat = costa$lat)

# desenho do contorno -----------------------------------------------------------------


mapa <- mapa %>%
  addPolygons(
    data = coordenadas,
    lng = ~Lon,
    lat = ~Lat,
    fillOpacity = 0.0,
    stroke = TRUE,
    weight = 1
  )

mapa









# teste here --------------------------------------------------------------


# 
# 
# poligono_sao_vicente2_santo_amaro <- data.frame(
#   Lat = c(-25.55, -23.86, -23.71, -25.55),
#   Lon = c(-48.36, -46.13, -45.43, -48.7)
# )
# 
# 
# mapa <- mapa %>%
#   addPolygons(
#     data = poligono_sao_vicente2_santo_amaro,
#     lng = ~Lon,
#     lat = ~Lat,
#     fillColor = "blue",
#     fillOpacity = 0.3,
#     stroke = TRUE,
#     color = "black",
#     weight = 1
#   )
# 
# 
# 
# 
# 
# 
# # testes ------------------------------------------------------------------
# 
# 
# poligono_santana_sao_vicente2 <- data.frame(
#   Lat = c(-25.55, -23.86, -23.86, -25.55, -25.55),
#   Lon = c(-48.36, -46.13, -48.7, -48.7, -48.36)
# )
# 
# 
# 
# mapa <- mapa %>%
#   addPolygons(
#     data = poligono_santana_sao_vicente2,
#     lng = ~Lon,
#     lat = ~Lat,
#     fillColor = "blue",
#     fillOpacity = 0.3,
#     stroke = TRUE,
#     color = "black",
#     weight = 1
#   )
# 
# mapa
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # stop here ---------------------------------------------------------------
# poligono_limite_sul_santana <- data.frame(
#   Lat = c(-28.33, -25.55, -25.55, -28.33),
#   Lon = c(-48.7, -48.36, -48.7, -48.7)
# )
# 
# # Adicionar polígono ao mapa
# mapa <- mapa %>%
#   addPolygons(
#     data = poligono_limite_sul_santana,
#     lng = ~Lon,
#     lat = ~Lat,
#     fillColor = "blue",
#     fillOpacity = 0.3,
#     stroke = TRUE,
#     color = "black",
#     weight = 1
#   )
# 
# mapa
# # ...
# # (Código posterior)
# 
# 
# 
# lati <-c(-28.33,-25.55,-25.55,-28.3) 
# longi <- c(-48.7,-48.36,-48.7,-48.7)
# 
# tri <- data.frame(lati,longi)
# plot(tri)
# 
# 
# 
