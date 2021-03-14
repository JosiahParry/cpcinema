#' Extract Palettes from an Instagram post
#' 
#' Provide a \@colorpalette.cinema Instagram post url and extract the color paletts from the posts.
#' 
#' @param post_url The url of the instagram post. 
#'
#' @export
#' @examples 
#' pal_from_post("https://www.instagram.com/p/CMC26FaHbqP/")
pal_from_post  <- function(post_url) {
  res <- httr::POST("https://igram.io/api/",
              body = list(url = post_url,
                          lang_code = "en",
                          vers = "2"),
              encode  = "form") %>% 
    httr::content()
  
  imgs <- res%>% 
    rvest::html_nodes(".py-2 img") %>% 
    rvest::html_attr("src") %>% 
    unique() 
  
  img_paths <- imgs[2:length(imgs)]
  
  purrr::map(img_paths, extract_cpc_pal)
  
}
