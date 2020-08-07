shinyServer(function(input, output, session) {

  observeEvent(input$ruleset, {
    updateTabsetPanel(session, "switcher", selected = input$ruleset)
  })

  # Roll Shadowrun ----
  sr_res <- eventReactive(input$sr_roll_btn, ignoreInit = TRUE, {
    d6 <- isolate(input$sr_d6_count)

    throw <- sample(1:6, size = d6, replace = TRUE, prob = c(.8, .1, .1, .1, .5, .5))
    list(
      numbers = throw,
      successes = sum(throw >= 5),
      glitch = sum(throw == 1) >= (d6/2)
    )
  })

  output$sr_result <- renderUI({
    res <- sr_res()

    extra_classes <- "alert-success"
    if (res$successes == 0) extra_classes <- "alert-warning"
    if (res$glitch) extra_classes <- "alert-danger"

    fluidRow(
      column(
        class = paste("success-count alert", extra_classes),
        role = "alert",
        id = "sr6-success-count",
        width = 1,
        glue("{res$successes}")
      ),
      column(
        class = "dice-display",
        id = "sr6-dice-display",
        width = 10, offset = 1,
        label_throw(res$numbers)
      )
    )
  })

})
