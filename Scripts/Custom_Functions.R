#--------------------------------------#
# Custom functions file
#--------------------------------------#

#---------------------------------------------------------------------------#
# Get the hex grid function.
# Input: (x,y) dimensions of a grid  #
# Output: A shapefile taking the form of a x by y dimensional hexagonal grid.
#---------------------------------------------------------------------------#

hex.draw.grid <- function(x = 1, y = 1) {
  
  dims = c(x, y)
  
  if (x < 1 | is.numeric(x) == FALSE) {stop("Invalid value for x.")}
  if (y < 1 | is.numeric(y) == FALSE) {stop("Invalid value for y.")}  
  
  d = 1
  
  if(x > 1) {
    xl = 1:dims[1]
    xlist <- rep((6/4)*xl, each = dims[2])    
    if(y != 1) {
      yl = seq(from = 1, length = dims[2], by = 2*(sqrt(3/4))*d)
      ylist <- c(matrix(rep(yl, dims[2]), nrow = dims[2]) + 
                   sqrt(3/4)*d*((col(matrix(rep(yl, dims[2]), nrow = dims[2])) %% 2) == 0))[seq(1,2*dims[2])]
    } else if (y == 1) {
      #yl = c(1, 2*(sqrt(3/4))*d)
      #ylist <- c(matrix(rep(yl, dims[2]), nrow = dims[2]) + 
      #             sqrt(3/4)*d*((col(matrix(rep(yl, dims[2]), nrow = dims[2])) %% 2) == 0))[seq(1,2*dims[2])]
      stop("Unable to handle case y = 1 for now")
    }
  } else if (x == 1) {
    #xl = 1
    #xlist <- c(1)
    stop("Unable to handle case x = 1 for now")
    if(y != 1) {
      yl = seq(from = 1, length = dims[2], by = 2*(sqrt(3/4))*d)
      ylist <- yl
    } else if (y == 1) {
      #yl = c(1, 2*(sqrt(3/4))*d)
      #ylist <- yl
      stop("Unable to handle case y = 1 for now")
    }
  }


  ratio = max(c(length(xlist)/length(ylist),length(ylist)/length(xlist)))
  if(ratio - floor(ratio) == 0 & length(xlist) >= length(ylist)) {
    centroids = tibble(x = xlist, y = rep(ylist, ratio))
  } else if(ratio - floor(ratio) == 0 & length(xlist) < length(ylist)) {
    centroids = tibble(x = rep(xlist, ratio), y = ylist, ratio)
  } else if(ratio - floor(ratio) != 0 & length(xlist) >= length(ylist)) {
    centroids = tibble(x = xlist, y = c(rep(ylist, ratio), ylist[1:dims[2]]))
  } else if(ratio - floor(ratio) != 0 & length(xlist) < length(ylist)) {
    centroids = tibble(x = c(rep(xlist, ratio), xlist[1:dims[1]]), y = ylist, ratio)
  } else {stop("There was an error in calculating the grid co-ordinates.")}
  
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
  
  pss = Polygons(pl, 1)
  spss = SpatialPolygons(list(pss))
  
  return(spss)
}

#---------------------------------------------------------------------------#
# Get the hex grid function.
# Input: (x,y) coordinates for a hexagon map grid #
# Output: A shapefile of specific polygons to plot in a larger grid.
#---------------------------------------------------------------------------#

hex.draw.coord <- function(xindex = c(1), yindex = c(1)) {
  
  dims = c(max(xindex), max(yindex))
  ncells = length(xindex)
  
  if (sum(xindex < 1) > 0 | sum(is.numeric(xindex) == FALSE) > 0) {stop("Invalid value for x.")}
  if (sum(yindex < 1) > 0 | sum(is.numeric(yindex) == FALSE) > 0) {stop("Invalid value for y.")}  
  if (length(xindex) != length(yindex)) {stop("xindex and yindex must have same length.")}
  
  d = 1
  
  xl = 1:dims[1]
  xmat <- tibble(xindex,
                 xlist = seq(from = 6/4, length = dims[1], by = 6/4)[xindex])
  
  yl = seq(from = 1, length = dims[2], by = 2*(sqrt(3/4))*d)
  ymat <- tibble(yindex,
                 ylist = (c(matrix(rep(yl, dims[2]), nrow = dims[2]) + 
                 sqrt(3/4)*d*((col(matrix(rep(yl, dims[2]), nrow = dims[2])) %% 2) == 0)))[yindex])

  mat <- tibble(cbind(xmat, ymat)) %>%
    mutate(xodd = xindex %% 2 == 1,
           ylist = if_else(xodd,
                           sqrt(3/4)*d + ylist,
                           ylist)) %>%
    dplyr::select(-xodd)
  
  ratio = max(c(length(mat$xlist)/length(mat$ylist),length(mat$ylist)/length(mat$xlist)))
  if(ratio - floor(ratio) == 0) {
    centroids = tibble(x = mat$xlist, y = rep(mat$ylist, ratio))
  } else if(ratio - floor(ratio) != 0) {
    centroids = tibble(x = mat$xlist, y = c(rep(mat$ylist, ratio), ylist[1:dims[2]]))
  } else {stop("There was an error in calculating the grid co-ordinates.")}
  
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
  
  pss = Polygons(pl, 1)
  spss = SpatialPolygons(list(pss))
  
  return(spss)
}



