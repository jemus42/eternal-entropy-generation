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
        label_throw_sr6(res$numbers)
      )
    )
  })

  # Cthulu ----
  observeEvent(input$cot_modifier, {
    if (input$cot_modifier != "None") {
      show(id = "cot-modifier-wrapper")
    } else {
      hide(id = "cot-modifier-wrapper")
    }
  })

  # Dice results and corresponsing output ----
  cot_d100_res <- eventReactive(input$cot_d100, ignoreInit = TRUE, {

    modifier <- input$cot_modifier

    cot100(
      bonus = modifier == "Bonus",
      malus = modifier == "Malus",
      mod_count = input$cot_modifier_count
    )
  })

  output$cot_d100_out <- renderUI({
    throw <- cot_d100_res()

    res_modifier_class <- switch(
      throw$modifier,
     "Bonus" = "label-success",
     "Malus" = "label-danger",
     "None" = "label-info"
    )

    div(
      #width = 12,
      class = "dice-display",
      #h3("Result"),
      tags$span(class = "cot-w1", paste("Einer:", throw$w1), " / "),
      tags$span(class = "cot-w10", paste("Zehner:", paste(throw$w10, collapse = ", "))), br(),
      tags$span(class = paste("cot-result label", res_modifier_class), throw$result)
    )
  })

  # COT d4
  cot_d4_res <- eventReactive(input$cot_d4, ignoreInit = TRUE, {
    modifier <- input$cot_modifier
    cot_dice(
      sides = 4,
      bonus = modifier == "Bonus",
      malus = modifier == "Malus",
      mod_count = input$cot_modifier_count
    )
  })

  output$cot_d4_out <- renderUI({
    throw <- cot_d4_res()
    res_modifier_class <- switch(
      throw$modifier,
      "Bonus" = "label-success",
      "Malus" = "label-danger",
      "None" = "label-info"
    )

    div(
      class = "dice-display",
      tags$span(class = "cot-w4", paste(throw$dice, collapse = ", ")), br(),
      tags$span(class = paste("cot-result label", res_modifier_class), throw$result)
    )
  })

  # COT d6
  cot_d6_res <- eventReactive(input$cot_d6, ignoreInit = TRUE, {
    modifier <- input$cot_modifier
    cot_dice(
      sides = 6,
      bonus = modifier == "Bonus",
      malus = modifier == "Malus",
      mod_count = input$cot_modifier_count
    )
  })

  output$cot_d6_out <- renderUI({
    throw <- cot_d6_res()
    res_modifier_class <- switch(
      throw$modifier,
      "Bonus" = "label-success",
      "Malus" = "label-danger",
      "None" = "label-info"
    )

    div(
      class = "dice-display",
      tags$span(class = "cot-w6", paste(throw$dice, collapse = ", ")), br(),
      tags$span(class = paste("cot-result label", res_modifier_class), throw$result)
    )
  })

  # COT d8
  cot_d8_res <- eventReactive(input$cot_d8, ignoreInit = TRUE, {
    modifier <- input$cot_modifier
    cot_dice(
      sides = 8,
      bonus = modifier == "Bonus",
      malus = modifier == "Malus",
      mod_count = input$cot_modifier_count
    )
  })

  output$cot_d8_out <- renderUI({
    throw <- cot_d8_res()
    res_modifier_class <- switch(
      throw$modifier,
      "Bonus" = "label-success",
      "Malus" = "label-danger",
      "None" = "label-info"
    )

    div(
      class = "dice-display",
      tags$span(class = "cot-w8", paste(throw$dice, collapse = ", ")), br(),
      tags$span(class = paste("cot-result label", res_modifier_class), throw$result)
    )
  })

  #COT D20
  cot_d20_res <- eventReactive(input$cot_d20, ignoreInit = TRUE, {
    modifier <- input$cot_modifier
    cot_dice(
      sides = 20,
      bonus = modifier == "Bonus",
      malus = modifier == "Malus",
      mod_count = input$cot_modifier_count
    )
  })

  output$cot_d20_out <- renderUI({
    throw <- cot_d20_res()
    res_modifier_class <- switch(
      throw$modifier,
      "Bonus" = "label-success",
      "Malus" = "label-danger",
      "None" = "label-info"
    )

    div(
      class = "dice-display",
      tags$span(class = "cot-w20", paste(throw$dice, collapse = ", ")), br(),
      tags$span(class = paste("cot-result label", res_modifier_class), throw$result)
    )
  })

})
