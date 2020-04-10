
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![CRAN
status](https://www.r-pkg.org/badges/version/aniview)](https://CRAN.R-project.org/package=aniview)
[![pipeline
status](https://gitlab.com/lgnbhl/aniview/badges/master/pipeline.svg)](https://gitlab.com/lgnbhl/aniview/pipelines)

# aniview <img src="man/figures/logo.png" align="right" />

> Animate Shiny and R Markdown content when it comes into view

The package `aniview` allows to animate Shiny and R Markdown content
when it comes into view using
[animate-css](https://daneden.github.io/animate.css/) thanks to
[AniView](https://jjcosgrove.github.io/jquery-aniview/).

## Installation

Install the package from Github.

``` r
# install.packages("remotes")
remotes::install_github("lgnbhl/aniview")
```

## Shiny

In order to use aniview, you must first call `use_aniview()` in the
apps’ UI.

Then simply apply `aniview()` to any shiny element with an animation
listed on the [animate-css
website](https://daneden.github.io/animate.css/).

``` r
library(shiny)
library(ggplot2)
library(aniview)

shinyApp(
  ui = fluidPage(
    align = "center",
    aniview::use_aniview(), # add use_aniview() in the UI
    aniview(h1("Shiny with AniView"), animation = "fadeInUp"),
    br(),
    aniview(plotOutput("plot"), animation = "slideInRight")
  ),
  server = function(input, output){
    output$plot <- renderPlot({
      ggplot(mpg, aes(displ, hwy, colour = class)) + 
        geom_point()
    })
  }
)
```

### Htmlwidgets

The function `aniview()` doesn’t work directly with
[htmlwidgets](https://www.htmlwidgets.org/).

The solution is to put the htmlwidget inside a container and animate it.

Below an example animating the `box()` from `shinydashboard` in order to
use `plotly`.

``` r
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

To animate a element of a R Markdown document, you must first call
`use_aniview()` inside a R code chunk with `{r, echo = FALSE}` so the
code will not be shown in the final document.

``` r
```{r, echo = FALSE}
aniview::use_aniview()
```
```

Then you can animate any content of your R Markdown document using the
`:::` markers of the `rmarkdown` package followed by `{.aniview
data-av-animation="ANIMATE-CSS EFFECT"}`. The animate-css effects are
listed [here](https://daneden.github.io/animate.css/).

Below an example with the “slideInUp” effect.

``` md
::: {.aniview data-av-animation="slideInUp"}
This element will be animated.
:::
```

You can learn more about the CSS class markers in the [Custom
block](https://bookdown.org/yihui/rmarkdown-cookbook/custom-blocks.html)
chapter of the *R Markdown Cookbook* from Yihui Xie.

### Xaringan presentation

[xaringan](https://github.com/yihui/xaringan) is a package for creating
slideshows with [remark.js](https://github.com/gnab/remark) using R
Markdown. You can take a look at its [introductory
presentation](https://slides.yihui.name/xaringan/).

You can easily animate a slide using the “animated” class of
[animate-css](https://daneden.github.io/animate.css/) with any animation
effect.

Below is a minimal example.

``` md
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
