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
  addMarkers(
    lng = ~Lon,
    lat = ~Lat,
    label = ~DONATARIO,
    popup = ~CAPITANIA
    
  )


mapa

# working linhas horizontais ------------------------------------------------------------------


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


# poligonos-teste ---------------------------------------------------------

for (i in 1:(length(latitudes) - 1)) {
  mapa <- mapa %>%
    addPolygons(
      lng = c(longitude[i], longitude[i+1], longitude[i+1], longitude[i]),
      lat = c(latitudes[i], latitudes[i+1], latitudes[i+1], latitudes[i]),
      color = "blue",
      fill = TRUE,
      fillOpacity = 0.5
    )
}

mapa
# desenho -----------------------------------------------------------------


mapa <- mapa %>%
  addPolygons(
    data = coordenadas,
    lng = ~Lon,
    lat = ~Lat,
    fillColor = "green",
    fillOpacity = 0.2,
    stroke = TRUE,
    color = "red",
    weight = 1
  )

mapa


# Adicionar polígonos para delimitar cada Capitania Hereditária
for (i in 1:nrow(coordenadas)) {
  if (i >= 8) {  # A partir de Itamaracá
    mapa <- mapa %>%
      addPolygons(
        data = coordenadas[i, ],
        lng = ~Lon,
        lat = ~Lat,
        fillColor = "blue",
        fillOpacity = 0.3,
        stroke = TRUE,
        color = "black",
        weight = 1
      )
  }
}

mapa
# ...
# (Código posterior)










# teste here --------------------------------------------------------------




poligono_sao_vicente2_santo_amaro <- data.frame(
  Lat = c(-25.55, -23.86, -23.71, -25.55, -25.55),
  Lon = c(-48.36, -46.13, -45.43, -48.7, -48.36)
)


mapa <- mapa %>%
  addPolygons(
    data = poligono_sao_vicente2_santo_amaro,
    lng = ~Lon,
    lat = ~Lat,
    fillColor = "blue",
    fillOpacity = 0.3,
    stroke = TRUE,
    color = "black",
    weight = 1
  )






# testes ------------------------------------------------------------------


poligono_santana_sao_vicente2 <- data.frame(
  Lat = c(-25.55, -23.86, -23.86, -25.55, -25.55),
  Lon = c(-48.36, -46.13, -48.7, -48.7, -48.36)
)



mapa <- mapa %>%
  addPolygons(
    data = poligono_santana_sao_vicente2,
    lng = ~Lon,
    lat = ~Lat,
    fillColor = "blue",
    fillOpacity = 0.3,
    stroke = TRUE,
    color = "black",
    weight = 1
  )

mapa



















# stop here ---------------------------------------------------------------
poligono_limite_sul_santana <- data.frame(
  Lat = c(-28.33, -25.55, -25.55, -28.33),
  Lon = c(-48.7, -48.36, -48.7, -48.7)
)

# Adicionar polígono ao mapa
mapa <- mapa %>%
  addPolygons(
    data = poligono_limite_sul_santana,
    lng = ~Lon,
    lat = ~Lat,
    fillColor = "blue",
    fillOpacity = 0.3,
    stroke = TRUE,
    color = "black",
    weight = 1
  )

mapa
# ...
# (Código posterior)



lati <-c(-28.33,-25.55,-25.55,-28.3) 
longi <- c(-48.7,-48.36,-48.7,-48.7)

tri <- data.frame(lati,longi)
plot(tri)



