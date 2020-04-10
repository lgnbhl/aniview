#' Animate an element when it comes into view
#'
#' Programmatically animate Shiny and R Markdown content when it comes into view.
#'
#' @param element An shiny or rmarkdown element.
#' @param animation An animation from \href{https://daneden.github.io/animate.css/}{animate.css}
#' @param ... Additional class element 
#'
#' @importFrom htmltools tagAppendAttributes
#'
#' @examples 
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
aniview <- function(element, animation, ...){
  if(missing(animation)) stop("must pass animate.css effect.", call. = FALSE)
  if(missing(element)) stop("must pass element.", call. = FALSE)
  
  htmltools::tagAppendAttributes(element, "data-av-animation" = animation, class =  "aniview", ...)
}
