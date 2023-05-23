dados_trajeto <- data.frame(
  data = c("9 de março", "14 de março", "22 de março", "29 e 30 de março", "10 de abril", "18 de abril", "22 de abril", "22 de abril de 1500"),
  descricao = c("Zarparam de Lisboa", "Passaram pelas Ilhas Canárias", "Passaram por Cabo Verde",
                "Adentraram a região de calmaria na zona equatorial", "Passaram a 210 milhas de Fernando de Noronha",
                "Estavam próximos da Baía de Todos os Santos", "Avistamento do Monte Pascoal", "Chegada em terra"),
  foto = c("https://i.pinimg.com/originals/0a/7c/79/0a7c79694cdb0bd27782bb77683e4fd3.jpg",
           "https://3.bp.blogspot.com/-dH_KC-zB5dk/UQePMarLTjI/AAAAAAAAFTw/dHHkbXB416k/s1600/DOT_Spain_II_Canary_Islands_Map.jpg",
           "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/29-10-2020-porto-santo-reserve.jpg/image1170x530cropped.jpg",
           "https://enauti.com/wp-content/uploads/2021/11/7wkqu9cige541.jpg",
           "https://t2.gstatic.com/licensed-image?q=tbn:ANd9GcSpKIVLoqlj8l5d4ttNxK8IDQeXnCJ9U1BParE5YwH-tymmHqvI8_aeojjt6_CeGN3q",
           "https://www.historia-brasil.com/bahia/mapas-historicos/mapa/mapa-luis-teixeira.jpg",
           "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Monte_P%C3%A1scoal.jpg/1920px-Monte_P%C3%A1scoal.jpg",
           "https://blogdoaftm.com.br/wp-content/uploads/2021/04/4036.jpg"),
  fonte = c("FAPESP",
            "https://www.megatimes.com.br/2018/03/Canarias-Espanha.html",
            "ONU", "enauti", "gstatic", "historia-brasil.com", "wikipedia", "https://blogdoaftm.com.br")
)

# Define as coordenadas aproximadas do trajeto da esquadra de Cabral no mar
trajeto_cabral <- list(
  c(38.7, -9.1),        # Lisboa
  c(28.1, -20.4),       # Ilhas Canárias
  c(15.1, -27.6),       # Cabo Verde
  c(4.640688, -29.428979),              # Região de calmaria na zona equatorial
  c(-7.8, -32.4),       # Passagem a 210 milhas de Fernando de Noronha
  c(-13.139056, -34.585574),      # Próximos da Baía de Todos os Santos
  c(-16.420312, -38.809950),    # Avistamento do Monte Pascoal
  c(-16.443798, -39.065201 )# Chegada em terra
)

# Define o ícone da caravela para os marcadores do trajeto
icone_caravela <- makeIcon(iconUrl = "https://i.pinimg.com/originals/4c/d8/c7/4cd8c7ddefa587f5a948ed6b9f4f1287.png", iconWidth = 30, iconHeight = 30)
icone_montanha <- makeIcon(iconUrl = "https://i.pinimg.com/originals/06/9d/1c/069d1c3863288113ee152e8c664704c7.png", iconWidth = 30, iconHeight = 30)

# Cria o mapa
mapa <- leaflet() %>%
  addProviderTiles("Stamen.Watercolor") %>%#adiciona um mapa especifico de topogrtafia link:https://leaflet-extras.github.io/leaflet-providers
  addProviderTiles("Stamen.TonerLabels") %>% # adiciona as legendas para localidade
  setView(lng = -9.1, lat = 38.7, zoom = 12)  # Centralize o mapa no oceano

# Adiciona a linha do trajeto da esquadra
mapa <- mapa %>%
  addPolylines(lng = sapply(trajeto_cabral, `[`, 2), lat = sapply(trajeto_cabral, `[`, 1),
               color = "blue", weight = 2)

# Adicione os marcadores ao longo do trajeto
for (i in 1:length(trajeto_cabral)) {
  # Obtem os dados do local atual
  data <- dados_trajeto$data[i]
  descricao <- dados_trajeto$descricao[i]
  foto <- dados_trajeto$foto[i]
  fonte <- dados_trajeto$fonte[i]
  
  # Cria um conteúdo do pop-up com a data, descrição, foto e fonte
  popup_content <- paste("<b>Data:</b> ", data,
                         "<br><b>Descrição:</b> ", descricao,
                         "<br><img src='", foto, "' alt='Foto' style='max-width: 200px'>",
                         "<br><b>Fonte:</b> <a href='", fonte, "' target='_blank'>", fonte, "</a>")
  
  # Adiciona o marcador ao mapa
  if (i == length(trajeto_cabral)) {
    # Último marcador com ícone de montanha
    mapa <- mapa %>%
      addMarkers(lng = trajeto_cabral[[i]][2], lat = trajeto_cabral[[i]][1],
                 icon = icone_montanha, popup = popup_content)
  } else {
    # Marcadores intermediários com ícone da caravela
    mapa <- mapa %>%
      addMarkers(lng = trajeto_cabral[[i]][2], lat = trajeto_cabral[[i]][1],
                 icon = icone_caravela, popup = popup_content)
  }
}

# Exibe o mapa
mapa