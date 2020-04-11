library(ggplot2)
library(wesanderson)

ggplot(wesanderson::heatmap, aes(x = X2, y = X1, fill = value)) +
  geom_tile() + 
  scale_fill_gradientn(colours = color_palette(colors, n = 100, "continuous")) + 
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  coord_equal() 





as.data.frame(volcano) %>% 
  mutate(id = row_number()) %>% 
  tidyr::gather(y, z, -id) %>% 
  as_tibble() %>% 
  ggplot(aes(id, y, fill = z)) + 
  geom_tile()
