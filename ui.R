shinyUI(
  navbarPage(
    title = "Eternal Entropy Generation",
    theme = shinythemes::shinytheme("flatly"),
    collapsible = TRUE,
    header = tags$head(
      tags$link(href = "css/style.css", rel = "stylesheet")
    ),
    # Main view ----
    tabPanel(title = "Roll",
      fluidRow(
        column(width = 10, offset = 1,
        selectInput(
          inputId = "ruleset", width = "100%",
          label = "Ruleset",
          choices = rulesets
        )
        )
      ),
      hr(),
      fluidRow(
        column(width = 10, offset = 1,
        tabsetPanel(
          id = "switcher",
          type = "hidden",
          tabPanel(
            title = "sr",
            fluidRow(
              column(
                width = 4,
                numericInput(
                  inputId = "sr_d6_count",
                  label = "D6 Count",
                  value = 5,
                  min = 1,
                  step = 1,
                  width = "25%"
                ),
                actionButton(
                  inputId = "sr_roll_btn",
                  label = "Roll!",
                  width = "25%"
                )
              ),
              column(
                width = 8,
                htmlOutput(outputId = "sr_result")
              )
            )
          ),
          tabPanel(
            title = "dsa",
            "DSA goes zkzkzkzk"
          ),
          tabPanel(
            title = "cot",
            "SCREAMING"
          )
        )
        )
      )
    )
  )
)
