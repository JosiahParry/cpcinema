library(tidyverse)


cpc <- jsonlite::fromJSON("https://www.instagram.com/colorpalette.cinema/?__a=1")



cpc$graphql$user$edge_owner_to_timeline_media$edges %>%
  pluck(1) -> x

captions <- x$edge_media_to_caption %>%
  unlist() %>%
  str_replace_all('“|”', '"')


lookup <- c(":\n" = "title: ",
            '"' = "",
            "Directed by" = "director:")

make_meta <- function(x) {
  tibble(info = x) %>%
    separate(info, into = c("var", "val"), sep = ": ") %>%
    pivot_wider(names_from = "var", values_from = "val") %>%
    janitor::clean_names()
}

post_captions <- captions %>%
  str_split("\n•") %>%
  map(str_replace_all, lookup)  %>%
  map_dfr(make_meta) %>%
  mutate(img_url = x$display_url)

fp <- post_captions$img_url[[1]]



recent_pals <- post_captions %>%
  mutate(pals = map(img_url, cpcinema::extract_cpc_pal)) %>% 
  nest(meta = -c(title, pals))


pals_raw <- pull(recent_pals, pals) 
pals <- map(pals_raw, cpcinema::color_palette, 10)
titles <- pull(recent_pals, title) %>% 
  str_squish() %>% 
  str_sub(1, -9) %>% 
  tolower() %>% 
  str_replace_all("[:blank:]+", "-")


available_pals <- set_names(pals, titles)



usethis::use_data(available_pals)
