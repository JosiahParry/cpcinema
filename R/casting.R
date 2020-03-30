
# following along https://vctrs.r-lib.org/articles/s3-vector.html
# Declaring prototypes ----------


#' @method vec_ptype2 cpcinema
#' @export
#' @export vec_ptype2.cpcinema
#' @rdname vctrs-cpcinema
vec_ptype2.cpcinema <- function(x, y, ...) {
  UseMethod("vec_ptype2.cpcinema", y)
}


# Coersion 
#' @method vec_ptype2.cpcinema default
#' @export
vec_ptype2.cpcinema.default <- function(x, y, 
                                             x_arg = "x",
                                             y_arg = "y", 
                                             ...) {
  vctrs::vec_default_ptype2(x, y, x_arg = "x_arg", y_arg = "y_arg")
  
}

# convert cpcinema to cpcinema
#' @method vec_ptype2.cpcinema cpcinema
#' @export
vec_ptype2.cpcinema.cpcinema <- function(x, y, ...) new_palette()

# convert cpcinema to character
#' @method vec_ptype2.cpcinema character
#' @export
vec_ptype2.cpcinema.character <- function(x, y, ...) new_palette()

#' @method vec_ptype2.character cpcinema
#' @export
vec_ptype2.character.cpcinema <- function(x, y, ...) character()


# Casting -----------

# double dispatch format
# function.to.from 

#' @method vec_cast cpcinema
#' @export
#' @export vec_cast.cpcinema
#' @rdname vctrs-cpcinema
vec_cast.cpcinema <- function(x, to, ...) UseMethod("vec_cast.cpcinema")

#' @method vec_cast.cpcinema default
#' @export
vec_cast.cpcinema.default <- function(x, to, ...) vctrs::vec_default_cast(x, to)

#' @method vec_cast.cpcinema cpcinema
#' @export
vec_cast.cpcinema.cpcinema <- function(x, to, ...) x

#' @method vec_cast.cpcinema character
#' @export
vec_cast.cpcinema.character <- function(x, to, ...) color_palette(x)


#' @method vec_cast.character cpcinema
#' @export
vec_cast.character.cpcinema <- function(x, to, ...) as.character(vctrs::vec_data(x))