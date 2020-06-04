# Packages 

# Get the list of packages.

packagelist <- c(
  "dplyr",
  "tidyverse",
  "ggplot2",
  "MASS",
  "scales",
  "sf",
  "raster",
  "lubridate",
  "shiny",
  "stats",
  "stars",
  "spatial.tools",
  "readr",
  "rmapshaper",
  "geogrid",
  "rlist"
)

# Get packages function.

get.packages <- function(plist) {
  
  #oldw <- getOption("warn") # Suppress annoying warnings.
  #options(warn = -1)
  
  for(i in 1:length(plist)) {
    name <- as.character(plist[i])
    if(!(name %in% installed.packages())) {
      install.packages(name)
      require(name, character.only=TRUE)
    } else {
      require(name, character.only=TRUE)
    }
  }
  
  #options(warn = oldw) # Turn the warnings back on.
  
}

# Get the packages.

get.packages(packagelist)

# Custom functions.

hex.draw <- function(cells = as.tibble(x=c(1), y=c(1)), dims = c(1,1), style = "coords") {
  if (style == "coords") {
    xlist = cells[,1]
    ylist = cells[,2]
    pl = list()
    
    for (i in 1:nrow(xlist)) {
      d = 1
      x = xlist[i,]
      y = ylist[i,]
      x_c <- as.numeric(c(x-d/2,x+d/2,x+d,x+d/2,x-d/2,x-d))
      y_c <- as.numeric(c(y+d*sqrt(3/4),y+d*sqrt(3/4),y,y-d*sqrt(3/4),y-d*sqrt(3/4),y))
      xyc <- cbind(x_c, y_c)
      
      p = Polygon(xyc)
      pl = list.append(pl, p)
    }
    
    ps = Polygons(pl, 1)
    sps = SpatialPolygons(list(ps))
    
  } else if (style == "grid") {
    d=1
    xl = 1:dims[1]
    yl = seq(from = 1, length = dims[2], by = 2*(sqrt(3/4))*d)
    
    xlist <- rep((6/4)*xl, each = dims[2])
    ylist <- c(matrix(rep(yl, dims[2]), nrow = dims[2]) + sqrt(3/4)*d*((col(matrix(rep(yl, dims[2]), nrow = dims[2])) %% 2) == 0))[seq(1,2*dims[2])]
    
    ratio = max(c(length(xlist)/length(ylist),length(ylist)/length(xlist)))
    if(ratio - floor(ratio) == 0 & length(xlist) >= length(ylist)) {
      centroids = tibble(x = xlist, y = rep(ylist, ratio))
    } else if(ratio - floor(ratio) == 0 & length(xlist) < length(ylist)) {
      centroids = tibble(x = rep(xlist, ratio), y = ylist, ratio)
    } else if(ratio - floor(ratio) != 0 & length(xlist) >= length(ylist)) {
      centroids = tibble(x = xlist, y = c(rep(ylist, ratio), ylist[1:dims[2]]))
    } else if(ratio - floor(ratio) != 0 & length(xlist) < length(ylist)) {
      centroids = tibble(x = c(rep(xlist, ratio), xlist[1:dims[1]]), y = ylist, ratio)
    } else {return("error")}
    
    pl = list()
    
    npolygons = nrow(centroids)
    for (i in 1:npolygons) {
      x = centroids$x[i]
      y = centroids$y[i]
      x_c <- c(x-d/2,x+d/2,x+d,x+d/2,x-d/2,x-d)
      y_c <- c(y+d*sqrt(3/4),y+d*sqrt(3/4),y,y-d*sqrt(3/4),y-d*sqrt(3/4),y)
      xyc <- cbind(x_c, y_c)
    
      p = Polygon(xyc)
      pl = list.append(pl, p)
    }
    
    ps = Polygons(pl, 1)
    sps = SpatialPolygons(list(ps))
  }
  return(sps)
}



