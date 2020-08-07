library(shiny)
library(shinythemes)
library(glue)

rulesets <- c(
  "Shadowrun" = "sr",
  "DSA" = "dsa",
  "Call of Cthulu" = "cot"
)

# throw <- sample(1:6, size = 13, replace = TRUE, prob = c(.8, .1, .1, .1, .5, .5))


label_throw <- function(throw) {
  purrr::map(throw, ~{
    if (.x >= 5) {
      tags$span(class = "sr-dice sr-success alert alert-success", .x)
    } else if (.x == 1)
      {
      tags$span(class = "sr-dice sr-glitch alert alert-danger", .x)
    } else {
      tags$span(class = "sr-dice alert alert-info", .x)
    }
  })
}


