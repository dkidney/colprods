
.onAttach = function(libname, pkgname){
    packageStartupMessage("colprods version ",
                          utils::packageVersion("colprods"),
                          ". For help, type: ?colprods")
}

.onUnload = function(libpath){
    library.dynam.unload("colprods", libpath)
}
