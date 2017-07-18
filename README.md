# SkyWiseNetCDFR
NetCDF wrapper for reading and interrogating SkyWise NetCDF files

```r

> # extract the netcdf file attribute and variable names
> fileInfo <- GetFileInfo(fileName)
> fileInfo
$variables
 [1] "latitude"                                           
 [2] "longitude"                                          
 [3] "Latitude_Longitude"                                 
 [4] "forecast_reference_time"                            
 [5] "time"                                               
 [6] "temperature"                                        
 [7] "dewpoint"                                           
 [8] "u10"                                                
 [9] "v10"                                                
[10] "total_cloud_cover"                                  
[11] "surface_pressure"                                   
[12] "mslp"                                               
[13] "visibility"                                         
[14] "accumulated_precipitation_estimate_1hr"             
[15] "accumulated_liquid_equivalent_snowfall_estimate_1hr"
[16] "solar_radiation"                                    
[17] "strd"                                               
[18] "ssr"                                                
[19] "str"                                                
[20] "et_rate_short"                                      
[21] "et_rate_tall"                                       

$attributes
$attributes$Conventions
[1] "CF-1.6"

$attributes$comment
[1] "skywise_tools 0.3.4"

$attributes$dlat
[1] 0.0625

$attributes$dlon
[1] 0.0625

$attributes$dx
[1] 0.0625

$attributes$dy
[1] 0.0625

$attributes$grid_mapping_name
[1] "latitude_longitude"

$attributes$institution
[1] "Weather Decision Technologies, Inc."

$attributes$llcrnrlat
[1] -90

$attributes$llcrnrlon
[1] -179.9688

$attributes$nx
[1] 5760

$attributes$ny
[1] 2881

$attributes$urcrnrlat
[1] 90

$attributes$urcrnrlon
[1] 179.9688


# extract the temperature grid
> grid <- ExtractGrid(fileName, "temperature")

# find the data value at a certain lat / lon
> val <- GetValueAtPoint(35, -97, grid)
> val
[1] 306.375

# get the values for a cut out of the bottom left section of the grid
> x <-
  mapply(GetValueAtPoint,
         seq(grid$attributes$llcrnrlat, grid$attributes$llcrnrlat + 20),
         seq(grid$attributes$llcrnrlon, grid$attributes$llcrnrlon + 20),
         MoreArgs = list(grid))

> x
 [1] 235.2500 218.3750 222.0625 230.3125 236.3750 239.8125 230.5625 237.4375 220.0000 221.0625
[11] 220.9375 221.3125 228.8125 234.0625 236.6875 238.8750 240.3750 241.6875 245.8125 247.6250
[21] 251.2500

```
