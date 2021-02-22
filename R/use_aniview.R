#' Use AniView
#'
#' @param animateThreshold integrer. +ve numbers delay the animation sequence until the specified number of pixels have come into view. -ve numbers will trigger the animation sequence prior to the element coming into view.
#' @param scrollPollInterval integrer. frequency at which user scrolling is 'polled' i.e. tested. This is in milliseconds and is an extension to jQuery's in-built 'scroll' event/handler.
#' @param use_cdn use CDN (by default) or usee locally stored files.
#' 
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags tagList htmlDependency
#' 
#' @examples
#' 
#' if (interactive()) {
#'  library(shiny)
#'   shinyApp(
#'    ui = fluidPage(
#'      use_aniview(), # add use_aniview() in the UI
#'      aniview(h1("Shiny with AniView"), animation = "fadeInUp"),
#'      aniview(textOutput("text"), animation = "zoomIn")
#'    ),
#'   server <- function(input, output, session){
#'     output$text <- renderText({ print("An animated text.") })
#'   }
#'  )
#' }
#' 
#' @export

use_aniview <- function(animateThreshold = 0, scrollPollInterval = 20, use_cdn = TRUE){
  
  options <- list(
    animateThreshold = animateThreshold,
    scrollPollInterval = scrollPollInterval
  )
  
  options <- jsonlite::toJSON(options, auto_unbox = TRUE)
  
  tagList(
    html_dependencies_aniview(use_cdn),
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

#' AniView dependencies
#' 
#' Get aniview html dependencies.
#' 
#' @param use_cdn use CDN (by default) or use locally stored files.
#' 
#' @importFrom htmltools tagList htmlDependency
#' 
#' @rdname aniview-dependencies
#' 
#' @export

html_dependencies_aniview <- function(use_cdn = FALSE) {
  
  # animate.css
  if(use_cdn)
    animatecss <- htmltools::htmlDependency(
      name = "animate.css",
      version = "3.7.2",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/"),
      stylesheet = "animate.min.css"
    )
  else 
    animatecss <- htmltools::htmlDependency(
      name = "animate.css",
      version = "3.7.2",
      src = "",
      stylesheet = c(file = "htmlwidgets/animate.min.css"),
      package = "aniview"
    )
  
  # jquery-aniview
  if(use_cdn)
    jqueryaniview <- htmltools::htmlDependency(
      name = "jquery-aniview",
      version = "1.0.2",
      src = c(href = "https://unpkg.com/jquery-aniview@1.0.2/dist/"),
      script = "jquery.aniview.js"
    )
  else 
    jqueryaniview <- htmltools::htmlDependency(
      name = "jquery-aniview",
      version = "1.0.2",
      src = "",
      script = c(file = "htmlwidgets/jquery.aniview.js"),
      package = "aniview"
    )
  
  htmltools::tagList(animatecss, jqueryaniview)
}
