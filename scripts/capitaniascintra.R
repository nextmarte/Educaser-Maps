library(leaflet)
library(sf)

coordenadas <- data.frame(
  n = c(
    "1 A",
    "2A",
    "3",
    "4",
    "1 B",
    "2B",
    "12A",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11A",
    "12B",
    "11B",
    "12C",
    "",
    ""
  ),
  CAPITANIA = c(
    "Maranhao 1",
    "Maranhao 2",
    "Piaui",
    "Ceara",
    "Rio Grande do Norte 1",
    "Rio Grande do Norte 2",
    "Itamaraca",
    "Pernanbuco",
    "Bahia",
    "Ilheus",
    "Porto Seguro",
    "Espirito Santo",
    "Sao Tome",
    "Sao Vicente 1",
    "Santo Amaro",
    "Sao Vicente 2",
    "Santana",
    "Limite sul 28 e 1/3",
    "Linha de Tordesilhas"
  ),
  DONATARIO = c(
    "Aires da Cunha",
    "Joao de Barros",
    "Fernando Alvares de Andrade",
    "Antonio Cardoso de Barros",
    "Aires da Cunha",
    "Joao de Barros",
    "Pero Lopes de Sousa",
    "Duarte Coelho [Pereira]",
    "Francisco Pereira Coutinho",
    "Jorge de Figueiredo Correia",
    "Pedro do Campo Tourinho",
    "Vasco Fernandes Coutinho",
    "Pero de Gois [da Silveira]",
    "Martim Afonso de Sousa",
    "Pero Lopes de Sousa",
    "Martim Afonso de Sousa",
    "Pero Lopes de Sousa",
    "Limite sul 28 e 1/3",
    "Linha de Tordesilhas"
  ),
  LIMITE = c(
    "Rio Turiacu",
    "Ponto intermediario",
    "Ilha de Santana (oeste)",
    "Camocim",
    "Mucuripe",
    "Ponto intermediario",
    "Baia da Traicao",
    "Sul da I. de Itamaraca",
    "Rio de Sao Francisco",
    "Sul da Baia de TS",
    "Rio Pardo",
    "Rio Mucuri",
    "Rio Itapemirim",
    "Rio Macae",
    "Rio Juquiriquere",
    "Barra da Bertioga",
    "Barra sul de Paranagua",
    "48.70",
    "48.70"
  ),
  Lon = c(
    45.25,
    44.36,
    43.75,
    40.85,
    38.46,
    36.66,
    34.93,
    34.85,
    36.40,
    38.81,
    38.95,
    39.56,
    40.81,
    41.78,
    45.43,
    46.13,
    48.36,
    48.70,
    48.70
  ),
  Lat = c(
    1.64,
    2.33,
    2.36,
    2.87,
    3.72,
    5.08,
    6.68,
    7.81,
    10.50,
    13.14,
    15.65,
    18.09,
    21.00,
    22.38,
    23.71,
    23.86,
    25.55,
    28.33,
    0
  )
)

 rio::export(coordenadas,"tabela-cintra","csv")


#temos que multiplicar por -1
coordenadas$Lon <- -1*coordenadas$Lon
coordenadas$Lat <- -1*coordenadas$Lat


latitudes <- unique(coordenadas$Lat)
longitude <- unique(coordenadas$Lon)
# Criar um mapa com base nos dados das Capitanias Hereditárias
mapa <- leaflet(coordenadas) %>%
  addTiles() %>%
  setView(lng = -45, lat = -15, zoom = 4)  # Configurar a visualização inicial do mapa

# Adicionar marcadores para cada Capitania Hereditária
mapa <- mapa %>%
  addMarkers(
    lng = ~Lon,
    lat = ~Lat,
    label = ~DONATARIO,
    popup = ~CAPITANIA
    
  )


mapa

# Adicionar linhas latitudinais
# for (lat in latitudes) {
#   for(lng in longitude){
#   mapa <- mapa %>%
#     addPolylines(
#       data = NULL,
#       lng = c(-48.7,lng),  # Longitude para traçar a linha latitudinal
#       lat = c(lat,lat),  # Latitudes para traçar a linha latitudinal
#       color = "red",
#       weight = 2
#     )
# }
# }
# mapa
# Exibir o mapa



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



