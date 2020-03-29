#' Animate an element
#'
#' @param element An shiny or rmarkdown element.
#' @param animation An animation from \href{https://daneden.github.io/animate.css/}{animate.css}
#' @param ... Additional class element 
#'
#' @importFrom htmltools tagAppendAttributes
#'
#' @export
aniview <- function(element, animation, ...){
  if(missing(animation)) stop("must pass animate.css effect.", call. = FALSE)
  if(missing(element)) stop("must pass element.", call. = FALSE)
  
  htmltools::tagAppendAttributes(element, "data-av-animation" = animation, class =  "aniview", ...)
}
