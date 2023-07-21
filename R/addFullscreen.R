#' Full screen button for Leaflet
#'
#' Plugin for Leaflet that shows a button to show the map on the full screen
#'
#' @param map                a Leaflet for R map object
#'
#' @return
#' The modified map object
#'
#' @details
#' No frills, no options. This function displays a full screen button under the + and - buttons,
#' and fills the screen with your map when the user clicks it.
#'
#' This code is an R wrapper for JavaScript package Leaflet.fullscreen, and this package
#' includes the .js, .css, and .jvg files from \url{https://github.com/runette/Leaflet.fullscreen}.
#' Leaflet.fullscreen is Licensed under ISC.
#'
#' @section Author:
#' Bradley W. Compton <bcompton@@umass.edu>
#' @export
#' @import leaflet
#' @importFrom htmltools htmlDependency
#' @importFrom htmlwidgets onRender
#'
#' @examples
#' require(leaflet.lagniappe)
#' require(leaflet)
#' leaflet() |>
#' addTiles() |>
#' addFullscreen()
#'
# B. Compton, 19-21 Jul 2023



'addFullscreen' <- function(map) {

   # Point to Full screen plugin
   addFullscreenPlugin <- htmltools::htmlDependency('Leaflet-fullscreen', '1.0.3',
                                                    src = system.file(package = 'leaflet.lagniappe'),
                                                    script = 'Leaflet.fullscreen.js',
                                                    stylesheet = 'Leaflet.fullscreen.css'
   )

   # Register JS plugin
   registerPlugin <- function(map, plugin) {
      map$dependencies <- c(map$dependencies, list(plugin))
      map
   }

   # call JS plugin
   registerPlugin(map, addFullscreenPlugin) |>
      htmlwidgets::onRender(paste0('function(el, x) {var options = {\n',
                                   'fullscreenControl: true\n',
                                   '};\n',
                                   'var map = this;\n',
                                   'var fullScreen = new L.Control.Fullscreen();\n',
                                   'map.addControl(fullScreen);\n',
                                   '}'))
}
