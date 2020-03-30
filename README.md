
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cpcinema

<!-- badges: start -->

<!-- badges: end -->

cpcinema is intended to extract color palettes from the images posted by
the Instagram account
[@colorpalette.cinema](https://www.instagram.com/colorpalette.cinema/).
@colorpalette.cinema takes stills from beautiful filmed and edited
cinema pieces and creates a color palette containing 10 colors from the
still. `cpcinema` extracts the hexcodes from one of their posts (or any
image with 10 equally spaced out colors at the bottom).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("JosiahParry/cpcinema")
```

## extracting and crafting color palettes

<img src="https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/88916975_231750381202013_35436369220443926_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=105&_nc_ohc=cVqcSi58uZ4AX_hJXfm&oh=e56453cf87265c2cd2079f4c8fedacb0&oe=5EAC0A60" width="100%" />
This still from the Joker (2019) contains a beautiful palette which
seems like it may be suitable as a diverging color palette. We can
extract these hex codes using `extract_cpc_pal()`. Note that the print
method is not effectively displayed in the README.

``` r
library(cpcinema)

img_path <- "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/88916975_231750381202013_35436369220443926_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=105&_nc_ohc=cVqcSi58uZ4AX_hJXfm&oh=e56453cf87265c2cd2079f4c8fedacb0&oe=5EAC0A60"

(joker <- extract_cpc_pal(img_path))
#> <cpcinema[10]>
#>     #001832 
#>     #004C76 
#>     #007291 
#>     #00B5BC 
#>     #B2CEB7 
#>     #DEAD75 
#>     #B28077 
#>     #DA5C07 
#>     #A12106 
#>     #49234A
```

Moreover, we are able to actually generate color palettes with more or
less values than is available in our palette with the `color_palette()`
function.

``` r
colors <- c("#842000", "#EC9B01", "#3F5D91")
color_palette(colors, n = 3)
#> <cpcinema[3]>
#>     #842000 
#>     #EC9B01 
#>     #3F5D91
```

`color_palette()` has three arguments `pal`, `n`, and `type`. `pal`
expects a character vector of hexcodes. `n` we specify how many colors
from the palette should be selected. If `n` is omitted, it is the same
number of values as in the palette. If it is larger than the length of
`pal`, you will be prompted to change the `type` argument. There are two
different arguments for `type`. These are `discrete` (the default) and
`continuous`. When `type = "continuous"` we are indicating that
interpolation of the colors needs to be performed.

For example, we can take the palette from above and interpolate 7 more
colors by setting `n = 10` and `type = "continuous"`.

``` r
colors_10 <- color_palette(colors, n = 10, "continuous")
```

``` r
ggplot(wesanderson::heatmap, aes(x = X2, y = X1, fill = value)) +
  geom_tile() + 
  scale_fill_gradientn(colours = color_palette(joker, n = 100, "continuous")) + 
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  coord_equal() +
  labs(x = "", y = "") 
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Pretty cool, huh? We can take those 10 colors and extract only 5 of them
by setting `n = 5`.

``` r
color_palette(colors_10, 5)
#> <cpcinema[5]>
#>     #842000 
#>     #B25600 
#>     #E08D00 
#>     #B28630 
#>     #656A70
```

Moreover, if you’d prefer to select them manually, you can do that as
well using bracket `[` indexing.

``` r
colors_10[c(1, 3, 6, 9)]
#> <cpcinema[4]>
#>     #842000 
#>     #B25600 
#>     #D89411 
#>     #656A70
```

## available palettes

There are also 12 available palettes for you right away. These are
acessible through the list object `available_pals`.

## notes

This package implements an S3 `cpcinema` class using `vctrs`. The class
`cpcinema` contains a `Crayon` style in the attributes for each
color—this is what enables the fun printing. `cpcinema` objects will
be coerced to character vectors when needed. Otherwise you can cast them
explicitly with `as.character()`. To extract the `crayon` styles use
`palette_style()`.

``` r
pal <- color_palette(colors)
#> `n` is missing. Defaulting to palette length: 3.

palette_style(pal)
#> [[1]]
#> Crayon style function, #842000: example output.
#> 
#> [[2]]
#> Crayon style function, #EC9B01: example output.
#> 
#> [[3]]
#> Crayon style function, #3F5D91: example output.
```

### acknowledgments

This package was inspired by [@karthik’s](https://github.com/karthik/)
[`wesanderson`](https://github.com/karthik/wesanderson) package.
Additionally, [@jesseadler’s](https://github.com/jessesadler/)
[`debvectrs`](https://github.com/jessesadler/debvctrs) presentation at
rstudio::conf(2020L) and repository helped tremendously in getting the
footing for the `vctrs` classes.
