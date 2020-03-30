
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
extract these hex codes using `extract_cpc_pal()`.

``` r
library(cpcinema)

img_path <- "https://scontent-lga3-1.cdninstagram.com/v/t51.2885-15/e35/88916975_231750381202013_35436369220443926_n.jpg?_nc_ht=scontent-lga3-1.cdninstagram.com&_nc_cat=105&_nc_ohc=cVqcSi58uZ4AX_hJXfm&oh=e56453cf87265c2cd2079f4c8fedacb0&oe=5EAC0A60"

extract_cpc_pal(img_path)
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

`color_palette()` has three argu ments `pal`, `n`, and `type`. `pal`
expects a character vector of hexcodes. `n` we specify how many colors
from the palette should be selected. If `n` is omitted, it is the same
number of values as in the palette. If it is larger than the length of
`pal`, you will be prompted to change the `type` argument. There are two
different arguments for `type`. These are `discrete` (the
default)`and`continuous`. When`type = “continuous”\` we are indicating
that interpolation of the colors needs to be performed.

For example, we can take the palette from above and interpolate 7 more
colors by setting `n = 10` and `type = "continuous"`.

``` r
colors_10 <- color_palette(colors, n = 10, "continuous")
```

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

Morover, if you’d prefer to select them manually, you can do that as
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

``` r
available_pals
#> $delicatessen
#> <cpcinema[10]>
#>     #2B0C09 
#>     #4E2009 
#>     #76401C 
#>     #C06419 
#>     #CB9F3C 
#>     #FFD861 
#>     #CDC057 
#>     #4F4917 
#>     #7B1812 
#>     #C33E1F 
#> 
#> $joker
#> <cpcinema[10]>
#>     #012233 
#>     #006075 
#>     #009496 
#>     #94D2BD 
#>     #E9D9A6 
#>     #EC9B01 
#>     #C96600 
#>     #BB3F01 
#>     #AE2012 
#>     #72151D 
#> 
#> $`once-upon-a-time-in-america`
#> <cpcinema[10]>
#>     #1C1012 
#>     #34211D 
#>     #452824 
#>     #604228 
#>     #856C4E 
#>     #927C71 
#>     #746B66 
#>     #A3A1AE 
#>     #A1A7C9 
#>     #E8EAFF 
#> 
#> $`blade-runner-2049`
#> <cpcinema[10]>
#>     #1E1206 
#>     #552C00 
#>     #823A00 
#>     #9E6400 
#>     #C07F01 
#>     #B58E33 
#>     #E4C67D 
#>     #5B5823 
#>     #383718 
#>     #2B3115 
#> 
#> $midsommar
#> <cpcinema[10]>
#>     #003F2E 
#>     #347A58 
#>     #BE9A5C 
#>     #DAA190 
#>     #D99800 
#>     #D34E03 
#>     #B70002 
#>     #AA2366 
#>     #9F9DAA 
#>     #3F5D91 
#> 
#> $`jojo-rabbit`
#> <cpcinema[10]>
#>     #020806 
#>     #1A2012 
#>     #842000 
#>     #B20016 
#>     #CC0045 
#>     #C84A00 
#>     #DE6900 
#>     #C47A01 
#>     #D9A201 
#>     #D9C856 
#> 
#> $`portrait-of-a-lady-on-fire`
#> <cpcinema[10]>
#>     #02432B 
#>     #24975E 
#>     #BAD3B6 
#>     #73BFB5 
#>     #26A1A6 
#>     #007880 
#>     #F8D093 
#>     #CE902D 
#>     #C03202 
#>     #2B140C 
#> 
#> $ran
#> <cpcinema[10]>
#>     #090F0F 
#>     #2C3E3E 
#>     #3E453E 
#>     #727057 
#>     #939482 
#>     #DEDDC8 
#>     #FECF5B 
#>     #CF9D2A 
#>     #C74F10 
#>     #B8141B 
#> 
#> $`moonrise-kingdom`
#> <cpcinema[10]>
#>     #1C1D17 
#>     #403A24 
#>     #625A43 
#>     #6B7155 
#>     #84814A 
#>     #A5A57F 
#>     #8A5708 
#>     #4C2F11 
#>     #820000 
#>     #22442C 
#> 
#> $`nuovo-cinema-paradiso`
#> <cpcinema[10]>
#>     #030E20 
#>     #0C1F49 
#>     #024673 
#>     #00F9FB 
#>     #FEA7DA 
#>     #F8D545 
#>     #00D883 
#>     #004B44 
#>     #734D1E 
#>     #52252C 
#> 
#> $atonement
#> <cpcinema[10]>
#>     #071A20 
#>     #053027 
#>     #015158 
#>     #739A9F 
#>     #B9B295 
#>     #EACA97 
#>     #D7AC8C 
#>     #9B919C 
#>     #59788C 
#>     #1C4769 
#> 
#> $jarhead
#> <cpcinema[10]>
#>     #050102 
#>     #361F0F 
#>     #56320E 
#>     #583B1D 
#>     #632E02 
#>     #964003 
#>     #D47403 
#>     #EC9102 
#>     #F1A95F 
#>     #FEC68D
```

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
