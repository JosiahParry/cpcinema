#' Extract color palette from @colorpalette.cinema image
#' 
#' @param fp The path to a @colorpalette.cinema image 
#' 
#' @importFrom jpeg readJPEG
#' @importFrom purrr map_chr
#' 
#' @export
extract_cpc_pal<- function(fp) {
  tmp <- tempfile()
  download.file(fp, tmp, mode="wb")
  pic <- jpeg::readJPEG(tmp)
  file.remove(tmp)
  
  img_dims <- dim(pic)
  
  
  # identify height position of each color
  col_y_pos <- img_dims[1] * .95
  
  # grab a horizontal position of each color in palette
  col_x_pos <- seq(20, img_dims[2], by = img_dims[2]/10)
  
  # convert rgb to hex
  colors <- purrr::map_chr(col_x_pos, ~{
    rgb_vals <- pic[col_y_pos, .x,]
    rgb(rgb_vals[1], rgb_vals[2], rgb_vals[3])
  })
  
  new_palette(colors, length(colors), "discrete")
  
}


