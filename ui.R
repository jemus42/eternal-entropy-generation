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
          choices = rulesets,
          selected = "cot"
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
                width = 2,
                numericInput(
                  inputId = "sr_d6_count",
                  label = "D6 Count",
                  value = 5,
                  min = 1,
                  step = 1,
                  width = "100%"
                ),
                actionButton(
                  inputId = "sr_roll_btn",
                  label = "Roll!",
                  width = "100%"
                )
              ),
              column(
                width = 9, offset = 1,
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
            fluidRow(
              column(
                width = 3,
                h3("Keep track of your shit"),
                numericInput(inputId = "cot_counter_mp", label = "MP", value = 11),
                numericInput(inputId = "cot_counter_sp", label = "Stabilität", value = 33),
                numericInput(inputId = "cot_counter_gl", label = "Glück", value = 50)
              ),
              column(
                width = 3, offset = 1,
                h3("Roll some dice"),
                radioButtons(
                  inputId = "cot_modifier", label = "Modifier",
                  choices = c("None", "Bonus", "Malus"),
                  selected = "None"
                ),
                radioButtons(
                  inputId = "cot_modifier_count", label = "Count",
                  choices = 1:2, selected = 1
                ),
                actionButton(inputId = "cot_d100", label = "1W100")
              ),
              column(
                width = 5,
                htmlOutput(outputId = "cot_d100_out")
              )
            )
          )
        )
        )
      )
    )
  )
)
