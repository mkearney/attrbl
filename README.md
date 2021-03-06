attrbl
================

A tibble-like package for working with attributes and data frames.

***Warning: this package is in early development***

Install
-------

Install the dev version from Github

``` r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("mkearney/attrbl")
```

Use case
--------

Let's say you have a list of two data frames. And each data frame contains a data frame attribute "users" with around 100 observations.

``` r
## tweets data with users data attribute
rts <- list(
  rtweet::search_tweets("statistics", verbose = FALSE),
  rtweet::search_tweets("data science", verbose = FALSE))

## each object contains "users" data attribute with around 100 rows
rts %>%
  lapply(rtweet::users_data) %>%
  lapply(nrow)
```

    #> [[1]]
    #> [1] 100
    #> 
    #> [[2]]
    #> [1] 90

When you bind the data frames using `do.call(..., rbind)`, it returns a "users" attribute. But it only has around 100 rows (it should be closer to 200). It completely **drops** the second "users" attribute!

``` r
## base R's method
rts %>%
  do.call("rbind", .) %>%
  attr("users") %>%
  nrow()
```

    #> [1] 100

When you bind the data frames using `dplyr::bind_rows(...)`, it **doesn't return** a "users" attribute at all!

``` r
## dplyr's bind_rows method
rts %>%
  dplyr::bind_rows() %>%
  attr("users")
```

    #> NULL

But when you bind the data frames using `attrbl::do_call_rbind(...)`, it not only **keeps** all "users" attributes. It binds them together for you!

``` r
## attrbl's do_call_rbind method
rts %>%
  lapply(as_attrbl) %>%
  do_call_rbind() %>%
  attr("users") %>%
  nrow()
```

    #> [1] 190

Usage
-----

### Bind data frames without losing attributes

When a `data.frame` is merged with `dplyr::bind_rows(...)`, it **loses** its attribute(s).

``` r
## list of data frames
mtcars2 <- list(mtcars, mtcars)

## dplyr method
mtcars2 %>%
  dplyr::bind_rows() %>%
  attr("row.names")
```

    #>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
    #> [24] 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
    #> [47] 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64

When an `attrbl` is merged with `attrbl::do_call_rbind`, it **keeps** its attribute(s).

``` r
## attrbl method
mtcars2 %>%
  lapply(as_attrbl) %>%
  do_call_rbind() %>%
  attr("row.names")
```

    #>  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    #>  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    #>  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    #> [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    #> [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    #> [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    #> [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    #> [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    #> [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    #> [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    #> [31] "Maserati Bora"       "Volvo 142E"          "Mazda RX4"          
    #> [34] "Mazda RX4 Wag"       "Datsun 710"          "Hornet 4 Drive"     
    #> [37] "Hornet Sportabout"   "Valiant"             "Duster 360"         
    #> [40] "Merc 240D"           "Merc 230"            "Merc 280"           
    #> [43] "Merc 280C"           "Merc 450SE"          "Merc 450SL"         
    #> [46] "Merc 450SLC"         "Cadillac Fleetwood"  "Lincoln Continental"
    #> [49] "Chrysler Imperial"   "Fiat 128"            "Honda Civic"        
    #> [52] "Toyota Corolla"      "Toyota Corona"       "Dodge Challenger"   
    #> [55] "AMC Javelin"         "Camaro Z28"          "Pontiac Firebird"   
    #> [58] "Fiat X1-9"           "Porsche 914-2"       "Lotus Europa"       
    #> [61] "Ford Pantera L"      "Ferrari Dino"        "Maserati Bora"      
    #> [64] "Volvo 142E"

### Select attributes with `atselect`

Use `atselect` to select attributes the tidy way (no quotes required).

``` r
atselect(mtcars, row.names, class)
```

    #> $row.names
    #>  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    #>  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    #>  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    #> [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    #> [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    #> [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    #> [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    #> [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    #> [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    #> [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    #> [31] "Maserati Bora"       "Volvo 142E"         
    #> 
    #> $class
    #> [1] "data.frame"

### Add attributes with `add_attr`

Use `add_attr` to add one or more attributes to a data frame.

``` r
mtcars %>%
  add_attr(seed = quote(set.seed(1234)), timestamp = Sys.time()) %>%
  attributes()
```

    #> $names
    #>  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
    #> [11] "carb"
    #> 
    #> $row.names
    #>  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    #>  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    #>  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    #> [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    #> [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    #> [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    #> [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    #> [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    #> [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    #> [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    #> [31] "Maserati Bora"       "Volvo 142E"         
    #> 
    #> $class
    #> [1] "attrbl"     "tbl_df"     "data.frame"
    #> 
    #> $seed
    #> set.seed(1234)
    #> 
    #> $timestamp
    #> [1] "2018-02-21 18:05:55 CST"

<!--
## Tidy evaluation reading materials

+ [Slides: Tidy Eval Hygienic FEXPRS](https://www.r-project.org/dsc/2017/slides/tidyeval-hygienic-fexprs.pdf)
+ [Thesis](https://web.wpi.edu/Pubs/ETD/Available/etd-090110-124904/unrestricted/jshutt.pdf)
+ [Blog post](http://www.onceupondata.com/2017/08/12/my-first-steps-into-the-world-of-tidyeval/)

-->
