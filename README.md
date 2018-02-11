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

When data frames are merged with [`dplyr::bind_rows`](https://github.com/tidyverse/dplyr), they lose their attribute(s).

``` r
bind_rows(x, x) %>% 
  attr("test")
## NULL
```

When `atbl` data frames are merged with `bind_rows`, they preserve their attribute(s)

``` r
x <- as_atbl(x)
bind_rows(x, x) %>%
  attr("test")
##  [1]  0.3300858  1.0674592  0.3531334  0.9764582  1.6623383 -1.9361612
##  [7] -1.5835125 -0.4925910 -0.3398126 -0.2792944  0.3300858  1.0674592
## [13]  0.3531334  0.9764582  1.6623383 -1.9361612 -1.5835125 -0.4925910
## [19] -0.3398126 -0.2792944
```

Also, select attributes using non-standard evaluation

``` r
atselect(x, test)
## $test
##  [1]  0.3300858  1.0674592  0.3531334  0.9764582  1.6623383 -1.9361612
##  [7] -1.5835125 -0.4925910 -0.3398126 -0.2792944
```

<!--
## Tidy evaluation reading materials

+ [Slides: Tidy Eval Hygienic FEXPRS](https://www.r-project.org/dsc/2017/slides/tidyeval-hygienic-fexprs.pdf)
+ [Thesis](https://web.wpi.edu/Pubs/ETD/Available/etd-090110-124904/unrestricted/jshutt.pdf)
+ [Blog post](http://www.onceupondata.com/2017/08/12/my-first-steps-into-the-world-of-tidyeval/)

-->
