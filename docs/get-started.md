# Get Started

You can use aniview to animate content in Shiny, Rmarkdown and even [xaringan](https://github.com/yihui/xaringan) presentations.

The [aniview](https://jjcosgrove.github.io/jquery-aniview/) jquery plugin allows to enable animations only when content comes into view.

## Shiny

In order to use aniview in R Shiny, you must first call `use_aniview()` in the UI. 

Then simply apply `aniview()` to any shiny element with an animation listed on the [animate-css website](https://daneden.github.io/animate.css/).

Here a basic example:

```r
library(shiny)
library(ggplot2)
library(aniview)

shinyApp(
  ui = fluidPage(
    align = "center",
    aniview::use_aniview(), # add use_aniview() in the UI
    aniview(h1("Shiny with AniView"), animation = "fadeInUp"),
    HTML(rep("&darr;<br/><br/>scroll down<br/><br/>", 10)),
    aniview(plotOutput("plot"), animation = "slideInLeft")
  ),
  server = function(input, output){
    output$plot <- renderPlot({
      ggplot(mpg, aes(displ, hwy, colour = class)) + 
        geom_point()
    })
  }
)
```

## Htmlwidgets

The function `aniview()` doesn't work directly with [htmlwidgets](https://www.htmlwidgets.org/).

One solution is to put the htmlwidget inside a container and animate it.

Below an example animating the `box()` from `shinydashboard` in order to use `plotly`.

```r
library(shiny)
library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    use_aniview(), # use_aniview() should be inside the body element
    fluidRow(
      aniview(box(plotlyOutput("plotly")), animation = "slideInLeft"),
    )
  )
)

server <- function(input, output) {
  output$plotly <- renderPlotly({
    gg <- ggplot(mpg, aes(displ, hwy, colour = class)) + 
      geom_point()
    ggplotly(gg)
  })
}

shinyApp(ui, server)
```

## R Markdown

To animate a element of a R Markdown document, you must first call `use_aniview()` inside a R code chunk with ```{r, echo = FALSE}``` so the code will not be shown in the final document.

```r
```{r, echo = FALSE}
aniview::use_aniview()
```
```

Then you can animate any content of your R Markdown document using the `:::` markers of the `rmarkdown` package followed by `{.aniview data-av-animation="<ANIMATE-CSS EFFECT>"}`. The animate-css effects are listed [here](https://daneden.github.io/animate.css/).

Below an example with the "slideInUp" effect.

```md
::: {.aniview data-av-animation="slideInUp"}
This element will be animated.
:::
```

You can learn more about the CSS class markers in the [Custom block](https://bookdown.org/yihui/rmarkdown-cookbook/custom-blocks.html) chapter of the *R Markdown Cookbook* from Yihui Xie.

## Xaringan presentation

[xaringan](https://github.com/yihui/xaringan) is a package for creating slideshows with [remark.js](https://github.com/gnab/remark) using R Markdown. You can take a look at its [introductory presentation](https://slides.yihui.name/xaringan/).

You can easily animate a slide using the "animated" class of [animate-css](https://daneden.github.io/animate.css/) with any animation effect.

Below is a minimal example.

```md
---
title: "Presentation Ninja"
subtitle: "with xaringan"
output:
  xaringan::moon_reader:
    lib_dir: libs
---

```{r, echo = FALSE}
aniview::use_aniview()
```

# A normal slide

---
class: animated, bounceInDown

# An animated slide
```
