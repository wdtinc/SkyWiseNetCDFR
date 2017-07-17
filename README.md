# SkyWiseNetCDFR
NetCDF wrapper for reading and interrogating SkyWise NetCDF files

```r
# extract the temperature grid
grid <- ExtractGrid(fname, "temperature")

# extract the lat/lon grids
lonGrid <- ExtractGrid(fname, "longitude")$variable
latGrid <- ExtractGrid(fname, "latitude")$variable

# find the data value at a certain lat / lon
val <- GetValueAtPoint(35, -97, grid)

# get the values for a cut out of the bottom left section of the grid
x <-
  mapply(GetValueAtPoint,
         seq(grid$attributes$llcrnrlat, grid$attributes$llcrnrlat + 20),
         seq(grid$attributes$llcrnrlon, grid$attributes$llcrnrlon + 20),
         MoreArgs = list(grid))
```
