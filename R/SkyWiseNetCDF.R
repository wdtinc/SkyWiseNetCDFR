library(ncdf4)
#' ExtractGrid
#'
#' Extracts a parameter from the netcdf as well as the netcdf attributes
#' @param fileName the netcdf filename you want to extract a variable from
#' @param var the name of the variable you want to extract from the netcdf file
#'
#' @return a named list containing the variable and the file attributes
#' @export
#'
#' @examples
#' \dontrun{ grid <- ExtractGrid("file.nc", "temperature") }

ExtractGrid <- function(fileName, var) {
  nc <- ncdf4::nc_open(fileName)

  variable <- ncdf4::ncvar_get(nc, var)
  attributes <- ncdf4::ncatt_get(nc, 0)

  ncdf4::nc_close(nc)
  list(variable = variable, attributes = attributes)
}

#' GetValueAtPoint
#'
#' Returns the value of a grid at a given lat/lon
#' @param search_lat the latitude to find
#' @param search_lon the longitude to find
#' @param grid the grid containing the variable retrieved from the ExtractGrid call
#'
#' @return the value contained in the grid at the closest lat/lon matching point
#' @export
#'
#' @examples
#' \dontrun{ val <- GetValueAtPoint(35, -97, grid) }

GetValueAtPoint <-
  function(search_lat, search_lon, grid) {
    if (search_lat < grid$attributes$llcrnrlat) {
      warning(
        paste(
          search_lat,
          "lat is beyond llcrnrlat, moving to",
          grid$attributes$llcrnrlat
        )
      )
      search_lat = grid$attributes$llcrnrlat
    }
    if (search_lat > grid$attributes$urcrnrlat) {
      warning(
        paste(
          search_lat,
          "lat is beyond urcrnrlat, moving to",
          grid$attributes$urcrnrlat
        )
      )
      search_lat = grid$attributes$urcrnrlat
    }
    if (search_lon < grid$attributes$llcrnrlon) {
      warning(
        paste(
          search_lon,
          "lon is beyond llcrnrlon, moving to",
          grid$attributes$llcrnrlon
        )
      )
      search_lon = grid$attributes$llcrnrlon
    }
    if (search_lon > grid$attributes$urcrnrlon) {
      warning(
        paste(
          search_lon,
          "lon is beyond urcrnrlon, moving to",
          grid$attributes$urcrnrlon
        )
      )
      search_lon = grid$attributes$urcrnrlon
    }

    y <-
      round((search_lat - grid$attributes$llcrnrlat) / grid$attributes$dy)
    y <- y + 1
    x <-
      round((search_lon - grid$attributes$llcrnrlon) / grid$attributes$dx)
    x <- x + 1

    grid$variable[x, y]
  }


#' Title
#'
#' @param fileName The name of the file to inspect
#'
#' @return A list containing the netcdf variable names and attributes
#' @export
#'
#' @examples
#' \dontrun{ fileInfo <- GetFileInfo(fileName) }

GetFileInfo <- function(fileName) {
  nc <- ncdf4::nc_open(fileName)

  variables <- names(nc$var)
  attributes <- ncdf4::ncatt_get(nc, 0)

  ncdf4::nc_close(nc)
  list(variables = variables, attributes = attributes)

}
