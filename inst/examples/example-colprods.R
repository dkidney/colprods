\dontrun{

library(colprods)

# simple example -----

x = matrix(1:9, 3)
colprods_for_loop(x)
colprods_sapply(x)
colprods_apply(x)
colprods_rcpp(x)
colprods_rcpp_rowwise(x)
colprods_arma(x)
as.numeric(colprods_arma(x))

# benchmarking -----

library(microbenchmark)

nr = 1000
nc = 100
x = matrix(rnorm(nr * nc), nr, nc)
microbenchmark(
    colprods_for_loop(x),
    colprods_sapply(x),
    colprods_apply(x),
    colprods_rcpp(x),
    colprods_rcpp_rowwise(x),
    colprods_arma(x),
    as.numeric(colprods_arma(x))
)

nr = 100
nc = 1000
x = matrix(rnorm(nr * nc), nr, nc)
microbenchmark(
    colprods_for_loop(x),
    colprods_apply(x),
    colprods_sapply(x),
    colprods_rcpp(x),
    colprods_rcpp_rowwise(x),
    colprods_arma(x),
    as.numeric(colprods_arma(x))
)
}

