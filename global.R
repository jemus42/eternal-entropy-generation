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
      tags$span(class = "sr-dice sr-success label label-success", .x)
    } else if (.x == 1)
      {
      tags$span(class = "sr-dice sr-glitch label label-danger", .x)
    } else {
      tags$span(class = "sr-dice label label-info", .x)
    }
  })
}


# Cthulu ----

cot100 <- function(bonus = FALSE, malus = FALSE) {
  if (bonus & malus) stop("Can't have it both ways")

  # browser()
  ret <- list(
    w1 = sample(0:9, size = 1),
    w10 = sample(seq(0, 90, 10), size = 1),
    modifier = c("Bonus", "Malus")[c(bonus, malus)]
  )

  if (length(ret$modifier) == 0) ret$modifier <- "None"

  modifier_fun <- switch(ret$modifier,
                         "Bonus" = min,
                         "Malus" = max,
                         "None" = identity
  )

  if (bonus | malus ) {
    ret[["w10"]] <- c(ret$w10, sample(seq(0, 90, 10), size = 1))
  }

  if (modifier_fun(ret$w10) == 0 & ret$w1 == 0) {
    ret["result"] <- 100
  } else {
    ret["result"] <- modifier_fun(ret$w10) + ret$w1
  }

  ret
}

# cot100()
# cot100(bonus = TRUE)
# cot100(malus = TRUE)

# summary(replicate(10000, cot100()$result))
# summary(replicate(10000, cot100(bonus = TRUE)$result))
# summary(replicate(10000, cot100(malus = TRUE)$result))
