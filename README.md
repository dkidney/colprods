19 Jan 2019

<!-- README.md is generated from README.Rmd. Please edit that file -->

# colprods

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

## Example

``` r
library(colprods)
#> colprods version 0.0.0.9000. For help, type: ?colprods
x = matrix(1:9, 3)
colprods_for_loop(x)
#> [1]   6 120 504
colprods_sapply(x)
#> [1]   6 120 504
colprods_apply(x)
#> [1]   6 120 504
colprods_rcpp(x)
#> [1]   6 120 504
colprods_rcpp_rowwise(x)
#> [1]   6 120 504
colprods_arma(x)
#>      [,1] [,2] [,3]
#> [1,]    6  120  504
as.numeric(colprods_arma(x))
#> [1]   6 120 504
```
