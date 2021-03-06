#' Wrapper to create TRMM stack with time dimension
#' 
#' @details At the moment this function will only work for single layer datasets (there is a subset option in mirador in order to get only the desired layer)
#' 
#' @param x character. dir containing the files to be stacked or character list (the files). IN the former case, it is recommended to use the \code{pattern} argument
#' @param pattern See \code{\link{list.files}}
#' @param ... Arguments to be passed to \link{writeRaster}. If specifying a filename, it is strongly recommended to also set a datatype.
#' @author Loic Dutrieux
#' 
#' @import raster
#' 
#' @export


timeStackTRMM <- function(x, pattern=NULL, ...) {
    if(!is.character(x)){
        stop('x must be a character (directory) or a list of characters')
    }
    if (length(x) == 1){
        x <- list.files(x, pattern=pattern, full.names=TRUE)
    }
    
    s <- stack(x)
    
    time <- trmm2date(x)
    s <- setZ(x=s, z=time)
    
    if(hasArg(filename)) {
        out <- writeRaster(s, ...)
        return(out)
    }
    return(s)
    
}