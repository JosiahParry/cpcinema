
#' Color palette constructor and validator
#' 
#' Creates a new color_palette object. `new_palette()` is much more strict than `color_palette()` and is intended for use in development.
#' 
#' @importFrom vctrs new_vctr
#' @export
new_palette <- function(pal, n, type = c("discrete", "continuous"), ...) {
  
  # if n is less than length grab first, the last, and some in the middle
  index <- seq(1, length(pal), by = length(pal)/n)
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[index])
  
  # make printing style
  styles <- purrr::map(out, crayon::make_style, bg = TRUE)
  
  vctrs::new_vctr(out,
                  style = styles,
                  class = "cpcinema",
                  inherit_base_type = TRUE, 
                  ...)
  
}


# create new object  
# colors <- c("#100B07", "#163339", "#492310", "#FFC26F")
# test_pal <- new_palette(colors, 4, "discrete")
 

#------------------------------------------------------------------------------#
#                                    Checks                                    #
#------------------------------------------------------------------------------#
#------------------------------ test color input ------------------------------#

check_palette <- function(pal) {
  
  vctrs::vec_assert(pal, ptype = character())
  
  if (any(rlang::are_na(pal))) stop(call. = FALSE, "Cannot have missing colors in palette")
  
  # probably needs a check for valid hex code
}


#--------------------------- test number of colors ----------------------------#

check_n_colors <- function(pal, n, type) {
  
  if (missing(n)) {
    rlang::inform(glue::glue("`n` is missing. Defaulting to palette length: {length(pal)}."))
    n <- length(pal)
  }
  
  # check the n against length of paletee
  if (type == "discrete" && n > length(pal)) {
    stop(call. = FALSE, 'Number of requested colors greater than what palette can offer.\nDo you want `type = "continuous"`?')
  }
  
  n
}


#------------------------------------------------------------------------------#
#                              Helper Constructor                              #
#------------------------------------------------------------------------------#
#' Construct a new color palette
#' 
#' @param pal A character vector of color hex codes.
#' @param n (optional) number to indicate how many values to include in the color palette.
#' 
#' @note If `type` is set to `"discrete"`, `n` cannot be greater than the number of unique values in `pal`. `n` can be greater than number of unqiue values in `pal` when `type = "continuous"`. In the latter case, colors are interpolated with `grDevices::colorRampPalette()`.
#' 
#' 
#' @export
color_palette <- function(pal, n, type = c("discrete", "continuous")) {
  
  # checks
  check_palette(pal)                   # palette
  type <- rlang::arg_match(type)       #type
  n <- check_n_colors(pal, n, type)    # n 
  
  # construct
  new_palette(pal, n, type)
  
}

# color_palette(colors, 10, "continuous")

#------------------------------------------------------------------------------#
#                                Class helpers                                 #
#------------------------------------------------------------------------------#
# class check
#' @rdname color_palette
#' @export
is_color_palette <- function(pal) inherits(pal, "cpcinema")

# style grabber
#' importFrom purrr attr_getter
#' @export
palette_style <- purrr::attr_getter("style")


#------------------------------------------------------------------------------#
#                                 print method                                 #
#------------------------------------------------------------------------------#

# need to cut off printing at 10
#' @method obj_print_data cpcinema
#' @importFrom vctrs obj_print_data
#' @importFrom purrr walk2
#' @export
#' @export obj_print_data.cpcinema
obj_print_data.cpcinema <- function(pal, ...) {
  UseMethod("obj_print_data.cpcinema", pal)
}

#' @method obj_print_data.cpcinema default
#' @export
obj_print_data.cpcinema.default <- function(pal, ...) {
  styles <- palette_style(pal)
  purrr::walk2(vctrs::vec_data(pal), styles, ~cat("", .y("  "), .x, "\n"))
}









