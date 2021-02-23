.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "aniview-assets",
    system.file("assets", package = "waiter")
  )
}
