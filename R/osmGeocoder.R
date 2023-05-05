#' Open Street Map Geocoding for Leaflet
#'
#' Plugin for Leaflet that allows users to enter a place name or address to geolocate a map
#'
#' @param map         a Leaflet for R map object
#' @param collapsed   whether text window is collapsed or not
#' @param position    the position of the control
#' @param text        the text of the submit button
#' @param placeholder the text of the search input placeholder
#' @param bounds      a L.LatLngBounds object to limit the results to
#' @param email       an email string with a contact to provide to Nominatim. Useful if
#'                    you are doing lots of queries
#'
#' @value
#' The modified map object
#'
#' @details
#' This plugin uses Open Street Maps' Nominatim geocoder to resolve an address and locate
#' the Leaflet map. There are several arguments to fine-tune the text box. These are JavaScript
#' arguments, so their format is different from R. Collapsed should be a text string, 'true' or
#' 'false'. The others are all text strings.
#'
#' Note: there are limits to the free Nominatim geocoder (e.g., no more than 1 query/sec)
#' See \url{https://operations.osmfoundation.org/policies/nominatim/} for details.
#'
#' This code is an R wrapper for JavaScript package leaflet-control-osm-geocoder, and this package
#' includes the .js and .css files from \url{https://github.com/k4r573n/leaflet-control-osm-geocoder}.
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
#' osmGeocoder()
#'
# B. Compton, 28 Apr 2023-5 May 2023



'osmGeocoder' <- function(map, collapsed = 'false', position = 'topright', text = 'Locate',
                          placeholder = 'Type an address...', bounds = 'null', email = '') {


   # Point to OSM Geocoder plugin
   osmGeocoderPlugin <- htmltools::htmlDependency('leaflet-control-osm-geocoder', '1.0.3',
                                                  src = system.file(package = 'leaflet.lagniappe'),
                                                  script = 'Control.OSMGeocoder.js',
                                                  stylesheet = 'Control.OSMGeocoder.css'
   )

   # Register JS plugin
   registerPlugin <- function(map, plugin) {
      map$dependencies <- c(map$dependencies, list(plugin))
      map
   }

   # call JS plugin
   registerPlugin(map, osmGeocoderPlugin) |>
      htmlwidgets::onRender(paste0('function(el, x) {var options = {\n',
                                   'collapsed: ', collapsed, ',\n',
                                   'position: "', position, '",\n',
                                   'text: "', text, '",\n',
                                   'placeholder: "', placeholder, '",\n',
                                   'bounds: ', bounds, ',\n',
                                   'email: "', email, '",\n',
                                   'callback: function (results) {\n',
                                   '     var bbox = results[0].boundingbox,\n',
                                   '     first = new L.LatLng(bbox[0], bbox[2]),\n',
                                   '     second = new L.LatLng(bbox[1], bbox[3]),\n',
                                   '     bounds = new L.LatLngBounds([first, second]);\n',
                                   '     this._map.fitBounds(bounds);\n',
                                   '   }\n',
                                   '};\n',
                                   'var map = this;\n',
                                   'var osmGeocoder = new L.Control.OSMGeocoder(options);\n',
                                   'map.addControl(osmGeocoder);\n',
                                   '}'))
}
