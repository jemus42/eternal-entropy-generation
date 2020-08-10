shinyUI(
  navbarPage(
    title = "Eternal Entropy Generation",
    theme = shinythemes::shinytheme("flatly"),
    collapsible = TRUE,
    header = tags$head(
      tags$link(href = "css/style.css", rel = "stylesheet")
    ),
    footer = useShinyjs(),
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
              # column(
              #   width = 2,
                h2("Keep track of your shit"),
                column(3, numericInput(inputId = "cot_counter_tp", label = "TP", value = 11)),
                column(3, numericInput(inputId = "cot_counter_mp", label = "MP", value = 11)),
                column(3, numericInput(inputId = "cot_counter_sp", label = "Stabilität", value = 55)),
                column(3, numericInput(inputId = "cot_counter_gl", label = "Glück", value = 50))
              # ),
            ),
            fluidRow(
              h2("Roll some dice"),
              column(width = 2,
                fluidRow(
                  column(
                    width = 6,
                    radioButtons(
                      inputId = "cot_modifier", label = "Modifier",
                      choices = c("None", "Bonus", "Malus"),
                      selected = "None"
                    )
                  ),
                  hidden(
                    column(id = "cot-modifier-wrapper",
                      width = 6,
                      radioButtons(
                        inputId = "cot_modifier_count", label = "# of Modifiers",
                        choices = 1:2, selected = 1
                      )
                    )
                  )
                ),
                fluidRow(
                  class = "cot-button-wrapper",
                  actionButton(inputId = "cot_d100", label = "1W100", width = "80%"),
                  actionButton(inputId = "cot_d4", label = "1W4", width = "80%")
                )
              ),
              column(
                width = 6,
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
