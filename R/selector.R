#' @export
`[.cpcinema` <- function(x, ...) {
  x <- NextMethod()
  new_palette(unclass(x), length(x), "discrete")
}

#' @export
`[[.cpcinema` <- function(x, ...) {
  x <- NextMethod()
  vec_cast(x, character())
}
