atble
================

A tibble-like package for data frames with attributes worth preserving.

Install
-------

Install the dev version from Github

``` r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("mkearney/atbl")
```

Usage
-----

A data frame with attribute(s)

``` r
## data
x <- mtcars

## attribute
attr(x, "test") <- rnorm(10)
```

When `data.frames` are merged with [`dplyr::bind_rows`](https://github.com/tidyverse/dplyr), they lose their attribute(s).

``` r
bind_rows(x, x) %>% 
  attr("test")
## NULL
```

When `atbl`s are merged with `bind_rows`, they keep their attribute(s).

``` r
x <- as_atbl(x)
bind_rows(x, x) %>%
  attr("test")
##  [1] -0.67225454  1.47760845  0.29545359  0.30437368 -0.01931117
##  [6] -0.29369958  0.38569401 -0.60030117 -0.91705550 -0.20773602
## [11] -0.67225454  1.47760845  0.29545359  0.30437368 -0.01931117
## [16] -0.29369958  0.38569401 -0.60030117 -0.91705550 -0.20773602
```

Also, select attributes using non-standard evaluation

``` r
atselect(x, test)
## $test
##  [1] -0.67225454  1.47760845  0.29545359  0.30437368 -0.01931117
##  [6] -0.29369958  0.38569401 -0.60030117 -0.91705550 -0.20773602
```

<!--
## Tidy evaluation reading materials

+ [Slides: Tidy Eval Hygienic FEXPRS](https://www.r-project.org/dsc/2017/slides/tidyeval-hygienic-fexprs.pdf)
+ [Thesis](https://web.wpi.edu/Pubs/ETD/Available/etd-090110-124904/unrestricted/jshutt.pdf)
+ [Blog post](http://www.onceupondata.com/2017/08/12/my-first-steps-into-the-world-of-tidyeval/)

-->
