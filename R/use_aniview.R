#' Use AniView
#'
#' @param animateThreshold integrer. +ve numbers delay the animation sequence until the specified number of pixels have come into view. -ve numbers will trigger the animation sequence prior to the element coming into view.
#' @param scrollPollInterval integrer. frequency at which user scrolling is 'polled' i.e. tested. This is in milliseconds and is an extension to jQuery's in-built 'scroll' event/handler.
#' 
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags tagList
#' @export

use_aniview <- function(
  animateThreshold = 0,
  scrollPollInterval = 20
){
  options <- list(
    animateThreshold = animateThreshold,
    scrollPollInterval = scrollPollInterval
  )
  
  options <- jsonlite::toJSON(options, auto_unbox = TRUE)
  
  tagList(
    html_dependencies_aniview(),
    htmltools::tags$script(
      sprintf(
        "$(document).ready(function(){
            $('.aniview').AniView(%s);
        });",
        options
      )
    )
  )
}

html_dependencies_aniview <- function() {
  list(
    htmltools::htmlDependency(
      name = "jquery-aniview",
      version = "1.0.2",
      package = "aniview",
      src = c(
        file = "jquery-aniview-1.0.2",
        url = ""
      ),
    script = "jquery.aniview.js"
    ),
    htmltools::htmlDependency(
      name = "animate.css",
      version = "3.7.2",
      package = "aniview",
      src = c(
        file = "animate.css-3.7.2",
        url = ""
      ),
      stylesheet = "animate.min.css"
    )
  )
}
