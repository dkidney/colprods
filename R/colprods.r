
#' @rdname colprods
#' @name colprods_for_loop
#' @export

colprods_for_loop = function(x){
    colprods = numeric(ncol(x))
    for(j in 1:ncol(x)){
        colprods[j] = prod(x[,j])
    }
    colprods
}


#' @rdname colprods
#' @name colprods_apply
#' @export

colprods_apply = function(x){
    apply(x, 2, prod)
}


#' @rdname colprods
#' @name colprods_sapply
#' @export

colprods_sapply = function(x){
    sapply(1:ncol(x), function(j) prod(x[,j]))
}

