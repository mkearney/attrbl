atble
================

A tibble-like package for data frames with attributes worth preserving.

Demo
----

``` r
library(atbl)

x <- mtcars
attr(x, "test") <- c(random = rnorm(10))

x <- as_atbl(x)

atselect(x, test)
```

    ## $test
    ##     random1     random2     random3     random4     random5     random6 
    ##  0.73691962  1.29557794  0.21532462 -0.08552352  0.99411714  1.19058928 
    ##     random7     random8     random9    random10 
    ## -0.10156451  0.96864195  1.88218378  0.18465373

``` r
atbl()
```

    ## named list()
    ## attr(,"row.names")
    ## integer(0)
    ## attr(,"class")
    ## [1] "atbl"

``` r
atselect(x, row.names)
```

    ## $row.names
    ##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    ##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    ##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    ## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    ## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    ## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    ## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    ## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    ## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    ## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    ## [31] "Maserati Bora"       "Volvo 142E"

``` r
bind_rows(x, x)
```

    ## # tibble [64 × 11]
    ##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
    ##  * <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ##  1  21.0  6.00   160 110    3.90  2.62  16.5  0     1.00  4.00  4.00
    ##  2  21.0  6.00   160 110    3.90  2.88  17.0  0     1.00  4.00  4.00
    ##  3  22.8  4.00   108  93.0  3.85  2.32  18.6  1.00  1.00  4.00  1.00
    ##  4  21.4  6.00   258 110    3.08  3.22  19.4  1.00  0     3.00  1.00
    ##  5  18.7  8.00   360 175    3.15  3.44  17.0  0     0     3.00  2.00
    ##  6  18.1  6.00   225 105    2.76  3.46  20.2  1.00  0     3.00  1.00
    ##  7  14.3  8.00   360 245    3.21  3.57  15.8  0     0     3.00  4.00
    ##  8  24.4  4.00   147  62.0  3.69  3.19  20.0  1.00  0     4.00  2.00
    ##  9  22.8  4.00   141  95.0  3.92  3.15  22.9  1.00  0     4.00  2.00
    ## 10  19.2  6.00   168 123    3.92  3.44  18.3  1.00  0     4.00  4.00
    ## # ... with 54 more rows

``` r
bind_rows(x, x) %>% atselect(row.names)
```

    ## $row.names
    ##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    ##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    ##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    ## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    ## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    ## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    ## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    ## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    ## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    ## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    ## [31] "Maserati Bora"       "Volvo 142E"          "Mazda RX4"          
    ## [34] "Mazda RX4 Wag"       "Datsun 710"          "Hornet 4 Drive"     
    ## [37] "Hornet Sportabout"   "Valiant"             "Duster 360"         
    ## [40] "Merc 240D"           "Merc 230"            "Merc 280"           
    ## [43] "Merc 280C"           "Merc 450SE"          "Merc 450SL"         
    ## [46] "Merc 450SLC"         "Cadillac Fleetwood"  "Lincoln Continental"
    ## [49] "Chrysler Imperial"   "Fiat 128"            "Honda Civic"        
    ## [52] "Toyota Corolla"      "Toyota Corona"       "Dodge Challenger"   
    ## [55] "AMC Javelin"         "Camaro Z28"          "Pontiac Firebird"   
    ## [58] "Fiat X1-9"           "Porsche 914-2"       "Lotus Europa"       
    ## [61] "Ford Pantera L"      "Ferrari Dino"        "Maserati Bora"      
    ## [64] "Volvo 142E"

Tidy evaluation
---------------

-   [Slides: Tidy Eval Hygienic FEXPRS](https://www.r-project.org/dsc/2017/slides/tidyeval-hygienic-fexprs.pdf)
-   [Thesis](https://web.wpi.edu/Pubs/ETD/Available/etd-090110-124904/unrestricted/jshutt.pdf)
-   [Blog post](http://www.onceupondata.com/2017/08/12/my-first-steps-into-the-world-of-tidyeval/)
