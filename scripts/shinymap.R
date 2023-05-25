library(shiny)
library(leaflet)

# Define the marker locations
marker_data <- data.frame(
  name = c("Marker 1", "Marker 2", "Marker 3"),
  lat = c(41.9425557, 41.95044877, 41.95534325),
  lng = c(26.41389781, 26.41472289, 26.40887547)
)

# UI
ui <- fluidPage(
  leafletOutput("map"),
  actionButton("nextBtn", "Next Marker")
)

# Server
server <- function(input, output) {
  # Initialize counter
  counter <- reactiveVal(1)
  
  # Create the leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(lng = 26.41389781, lat = 41.9425557, zoom = 4) %>%
      addTiles() %>%
      addMarkers(
        data = marker_data,
        lng = ~lng, lat = ~lat,
        popup = ~name
      )
  })
  
  # Button click event
  observeEvent(input$nextBtn, {
    # Get the current counter value
    current_counter <- counter()
    
    # Increment the counter
    current_counter <- current_counter + 1
    
    # Reset counter if it exceeds the number of markers
    if (current_counter > nrow(marker_data)) {
      current_counter <- 1
    }
    
    # Update the map view
    leafletProxy("map") %>%
      flyTo(lng = marker_data$lng[current_counter],
              lat = marker_data$lat[current_counter],
              zoom = 13)
    
    # Update the counter value
    counter(current_counter)
  })
}

# Run the app
shinyApp(ui, server)
