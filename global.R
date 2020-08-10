library(shiny)
library(shinythemes)
library(glue)
library(shinyjs)

rulesets <- c(
  "Shadowrun" = "sr",
  "DSA" = "dsa",
  "Call of Cthulu" = "cot"
)

label_throw_sr6 <- function(throw) {
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

cot100 <- function(bonus = FALSE, malus = FALSE, mod_count = 1) {
  if (bonus & malus) stop("Can't have it both ways")
  if (!bonus & !malus) mod_count <- 0
  mod_count <- as.integer(mod_count)

  ret <- list(
    w1 = sample(0:9, size = 1),
    w10 = sample(seq(0, 90, 10), size = 1 + mod_count, replace = TRUE),
    modifier = c("Bonus", "Malus")[c(bonus, malus)],
    result = NA
  )

  if (length(ret$modifier) == 0) ret$modifier <- "None"

  modifier_fun <- switch(
    ret$modifier,
    "Bonus" = min,
    "Malus" = max,
    "None" = dplyr::first
  )

  ret$result <- ret$w1 + ret$w10

  ret$result <- ifelse(ret$result == 0, 100, ret$result)

  ret$result <- modifier_fun(ret$result)

  # ret$string <- glue("{ret$w1} + ({paste(ret$w10, collapse = ',')}) = {ret$result}")

  ret
}

# cot100()
# cot100(bonus = TRUE, mod_count = 1)
# cot100(bonus = TRUE, mod_count = 2)
# cot100(malus = TRUE, mod_count = 1)
# cot100(malus = TRUE, mod_count = 2)

# summary(replicate(10000, cot100()$result))
# summary(replicate(10000, cot100(bonus = TRUE)$result))
# summary(replicate(10000, cot100(malus = TRUE)$result))


cot_dice <- function(sides = 4, bonus = FALSE, malus = FALSE, mod_count = 1) {
  if (bonus & malus) stop("Can't have it both ways")
  if (!bonus & !malus) mod_count <- 0
  mod_count <- as.integer(mod_count)

  ret <- list(
    sides = sides,
    dice = sample(sides, size = 1 + mod_count, replace = TRUE),
    modifier = c("Bonus", "Malus")[c(bonus, malus)],
    result = NA
  )

  if (length(ret$modifier) == 0) ret$modifier <- "None"

  modifier_fun <- switch(ret$modifier,
                         "Bonus" = min,
                         "Malus" = max,
                         "None" = dplyr::first
  )

  ret$result <- modifier_fun(ret$dice)

  ret
}

# cot_dice(4)
# cot_dice(6, bonus = TRUE)
# cot_dice(8, bonus = TRUE, mod_count = 2)


# summary(replicate(10000, cot100()$result))
# summary(replicate(10000, cot_dice(sides = 100)$result))

# bench::mark(
#   cot_dice = cot_dice(100)$result,
#   cot100 = cot100()$result,
#   check = FALSE
# )
