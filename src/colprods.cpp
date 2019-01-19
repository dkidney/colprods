// #include <Rcpp.h> // dont need this line if also inclduing RcppArmadillo.h
#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;

//' @rdname colprods
//' @name colprods_arma
//' @title Calculate column products of a matrix
//' @description Various functions to calculate the column products of a matrix, each with
//'   a different implementation.
//' @param x a matrix
//' @example inst/examples/example-colprods.r
//' @export
// [[Rcpp::export]]
arma::rowvec colprods_arma(NumericMatrix x){
    arma::mat X = arma::mat(x.begin(), x.nrow(), x.ncol(), false);
    arma::rowvec colprods = prod(X,0) ;
    return colprods ;
}

//' @rdname colprods
//' @name colprods_rcpp
//' @export
// [[Rcpp::export]]
NumericVector colprods_rcpp(NumericMatrix x){
    int nrow_x = x.nrow() ;
    int ncol_x = x.ncol() ;
    NumericVector colprods(ncol_x) ;
    colprods.fill(1) ;
    for (int col = 0 ; col < ncol_x ; col++) {
        for (int row = 0 ; row < nrow_x ; row++) {
            colprods(col) *= x(row,col) ;
        }
    }
    return wrap(colprods) ;
}

//' @rdname colprods
//' @name colprods_rcpp_colwise
//' @export
// [[Rcpp::export]]
NumericVector colprods_rcpp_rowwise(NumericMatrix x){
    int nrow_x = x.nrow() ;
    int ncol_x = x.ncol() ;
    NumericVector colprods(ncol_x) ;
    colprods.fill(1) ;
    for (int row = 0 ; row < nrow_x ; row++) {
        for (int col = 0 ; col < ncol_x ; col++) {
            colprods(col) *= x(row,col) ;
        }
    }
    return wrap(colprods) ;
}
