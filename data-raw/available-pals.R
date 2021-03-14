read_color_pal <- function(fp) {
  raw_json <- jsonlite::read_json(fp)
  jsonlite::fromJSON(raw_json[[1]]) %>% 
    purrr::map(cpcinema::color_palette, n= 10)
  
}

available_pals <- list.files("data-raw/historic-pals", full.names = TRUE) %>% 
  purrr::map(read_color_pal) %>% 
  purrr::flatten()

usethis::use_data(available_pals, overwrite = TRUE)
