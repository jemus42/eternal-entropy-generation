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

    extra_classes <- "label-success"
    if (res$successes == 0) extra_classes <- "label-warning"
    if (res$glitch) extra_classes <- "label-danger"

    fluidRow(
      column(
        # class = paste("success-count alert", extra_classes),
        role = "label",
        id = "sr6-success-count",
        width = 1,
        h3("Erfolge"),
        tags$span(class = paste("success-count label", extra_classes), res$successes)
      ),
      column(
        class = "dice-display",
        id = "sr6-dice-display",
        width = 10, offset = 1,
        h3("Würfel"),
        label_throw(res$numbers)
      )
    )
  })

  # Cthulu ----
  cot_d100_res <- eventReactive(input$cot_d100, ignoreInit = TRUE, {
    sample(100, size = 1, replace = TRUE)
  })

  output$cot_d100_out <- renderText({
    cot_d100_res()
  })

})
