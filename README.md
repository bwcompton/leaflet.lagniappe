# leaflet.lagniappe
Additional Leaflet plugins for R that work under Shiny

Leaflet for R has support for several of the many available Leaflet plugins, but implementing others in R is non-trivial. Additional plugins in this package are tested under Shiny, both locally and on shinyapps.io, so you can use these in Shiny-based web pages. I'll continue to add plugins-here as I develop them. The goal is for plugins to require a simple call, e.g.,

```
devtools::install_github('bwcompton/leaflet.lagniappe')   # install from GitHub

library(leaflet)
library(leaflet.lagniappe)

leaflet() |>
addTiles() |>
osmGeocoder()
```

Included plugins:
1. `osmGeocoder`. Provides a window on a Leaflet map for a user to enter an address or place name. The map will zoom and center to the entered location.
