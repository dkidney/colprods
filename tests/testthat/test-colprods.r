## unit tests - colprods

context("Checking colprods functions")

test_that("check all functions give identical results", {

    x = matrix(1:9,3,3)

    colprods_loop_result   = colprods_for_loop(x)
    colprods_apply_result  = colprods_apply(x)
    colprods_sapply_result = colprods_sapply(x)
    colprods_rcpp_result   = colprods_rcpp(x)
    colprods_rcpp2_result  = colprods_rcpp_rowwise(x)
    colprods_arma_result   = as.numeric(colprods_arma(x))

    ans = c(6, 120, 504)
    expect_equal( colprods_loop_result, ans )
    expect_equal( colprods_apply_result, ans )
    expect_equal( colprods_sapply_result, ans )
    expect_equal( colprods_rcpp_result, ans )
    expect_equal( colprods_rcpp_result, ans )
    expect_equal( colprods_arma_result, ans )

})


