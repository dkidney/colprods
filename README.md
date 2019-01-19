19 Jan 2019

<!-- README.md is generated from README.Rmd. Please edit that file -->

# colprods

![Travis build
status](https://travis-ci.org/dkidney/colprods.svg?branch=master)

The goal of colprods is to provide a simple example of how to
incorporate Rcpp and RcppArmadillo functions into a package. It does
this using various implementations of a function to calculate the column
products of a numeric matrix.

## Installation

You can install the released version of colprods from
[Github](https://www.github.com/dkidney/colprods) with:

``` r
devtools::install_github("dkidney/colprods")
```

## Simple example

``` r
x = matrix(1:9, 3)
x
#>      [,1] [,2] [,3]
#> [1,]    1    4    7
#> [2,]    2    5    8
#> [3,]    3    6    9
```

``` r
library(colprods)
#> colprods version 0.0.0.9000. For help, type: ?colprods
```

``` r
colprods_for_loop(x)
colprods_sapply(x)
colprods_apply(x)
colprods_rcpp(x)
colprods_rcpp_rowwise(x)
colprods_arma(x)
as.numeric(colprods_arma(x))
#> [1]   6 120 504
#> [1]   6 120 504
#> [1]   6 120 504
#> [1]   6 120 504
#> [1]   6 120 504
#>      [,1] [,2] [,3]
#> [1,]    6  120  504
#> [1]   6 120 504
```

Notice that `colprods_arma` returns a matrix - this is because I haven’t
worked out how to coerce a single-row matrix into a vector within the
RcppArmadillo code.

## Benchmarking

``` r
library(dplyr)
library(microbenchmark)
bench = function(x){
    microbenchmark(
        "for_loop" = colprods_for_loop(x),
        "sapply"   = colprods_sapply(x),
        "apply"    = colprods_apply(x),
        "rcpp"     = colprods_rcpp(x),
        "rcpp2"    = colprods_rcpp_rowwise(x),
        "arma"     = colprods_arma(x),
        "arma2"    = as.numeric(colprods_arma(x))
    )
}
print_bench = function(x){
    x %>% 
        summary %>% 
        mutate(mean_rel = mean / min(mean)) %>% 
        mutate(median_rel = median / min(median)) %>% 
        select(expr, mean, median, mean_rel, median_rel, neval) %>% 
        mutate_at(vars(mean, median), round) %>% 
        mutate_at(vars(ends_with("_rel")), funs(round(., 1))) %>% 
        print.data.frame(row.names = FALSE)
}
```

### Tall matrix

``` r
nr = 1000
nc = 100
x = matrix(rnorm(nr * nc), nr, nc)
bench_tall = x %>% bench
bench_tall %>% print_bench
#>      expr mean median mean_rel median_rel neval
#>  for_loop  858    525     15.1       10.5   100
#>    sapply  928    607     16.3       12.2   100
#>     apply 1626   1142     28.7       22.9   100
#>      rcpp  540    520      9.5       10.4   100
#>     rcpp2  597    551     10.5       11.0   100
#>      arma   59     50      1.0        1.0   100
#>     arma2   57     51      1.0        1.0   100
bench_tall %>% boxplot(log = TRUE)
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

### Wide matrix

``` r
nr = 100
nc = 1000
x = matrix(rnorm(nr * nc), nr, nc)
bench_wide = x %>% bench
bench_wide %>% print_bench
#>      expr mean median mean_rel median_rel neval
#>  for_loop 1994   1775     28.5       34.0   100
#>    sapply 2885   2370     41.2       45.3   100
#>     apply 3405   2754     48.7       52.7   100
#>      rcpp  578    534      8.3       10.2   100
#>     rcpp2  626    567      9.0       10.8   100
#>      arma   73     52      1.0        1.0   100
#>     arma2   70     56      1.0        1.1   100
bench_wide %>% boxplot(log = TRUE)
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />
