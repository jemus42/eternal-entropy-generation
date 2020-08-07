shinyServer(function(input, output, session) {

  observeEvent(input$ruleset, {
    updateTabsetPanel(session, "switcher", selected = input$ruleset)
  })

  # Roll Shadowrun ----
  sr_res <- eventReactive(input$sr_roll_btn, ignoreInit = TRUE, {
    d6 <- isolate(input$sr_d6_count)

    throw <- sample(1:6, size = d6, replace = TRUE)
    list(
      numbers = throw,
      successes = sum(throw >= 5),
      glitch = sum(throw == 1) >= (d6/2)
    )
  })

  output$sr_result <- renderUI({
    res <- sr_res()

    div(
      tags$div(
        id = "sr6-success-count",
        glue("Successes: {res$successes}")
      ),
      tags$div(
        id = "sr6-glitch",
        if (res$glitch) {
          h2("YOU DONE GOOFED")
        }
      ),
      tags$div(
        id = "sr6-dice-display",
        paste0(res$numbers, collapse = ", ")
      )
    )
  })

})
