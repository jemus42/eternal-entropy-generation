shinyUI(
  navbarPage(
    title = "Eternal Entropy Generation",
    theme = shinythemes::shinytheme("flatly"),
    collapsible = TRUE,
    header = tags$head(
      tags$link(href = "css/style.css", rel = "stylesheet")
    ),
    footer = tagList(
      useShinyjs()
    ),
    # Main view ----
    tabPanel(title = "Call of Cthulu",
      fluidRow(
        column(width = 10, offset = 1,
        tabsetPanel(
          id = "switcher",
          type = "hidden",
          tabPanel(
            title = "cot",
            fluidRow(
                h2("Keep track of your shit"),
                column(3, numericInput(inputId = "cot_counter_tp", label = "TP", value = 11)),
                column(3, numericInput(inputId = "cot_counter_mp", label = "MP", value = 11)),
                column(3, numericInput(inputId = "cot_counter_sp", label = "Stabilität", value = 55)),
                column(3, numericInput(inputId = "cot_counter_gl", label = "Glück", value = 50))
            ),
            fluidRow(
              h2("Roll some dice"),
              column(width = 2,
                fluidRow(
                  # h3("Modifiers"),
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
                        inputId = "cot_modifier_count", label = "Modifier Dice",
                        choices = 1:2, selected = 1
                      )
                    )
                  )
                )
              ),
              column(width = 10,
                fluidRow(
                  column(
                    width = 3,
                    actionButton(inputId = "cot_d100", label = "1W100", width = "100%"),
                    htmlOutput(outputId = "cot_d100_out")
                  ),
                  column(
                    width = 3,
                    actionButton(inputId = "cot_d4", label = "1W4", width = "100%"),
                    htmlOutput(outputId = "cot_d4_out")
                  ),
                  column(
                    width = 3,
                    actionButton(inputId = "cot_d6", label = "1W6", width = "100%"),
                    htmlOutput(outputId = "cot_d6_out")
                  ),
                  column(
                    width = 3,
                    actionButton(inputId = "cot_d8", label = "1W8", width = "100%"),
                    htmlOutput(outputId = "cot_d8_out")
                  )
                )
              )
            )
          )
        )
        )
      )
    ),
    tabPanel(
      title = "Shadowrun (6)",
      fluidRow(
        column(
          width = 2,
          numericInput(
            inputId = "sr_d6_count",
            label = "D6 Count",
            value = 5,
            min = 1,
            max = 100, # Don't get greedy.
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
    )
  )
)
