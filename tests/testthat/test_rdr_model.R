context("POS Tagging")

test_that("Unexisting model", {
  expect_error(rdr_model(language = "NOOO", annotation = "POS"))
})


test_that("POS", {
  m <- rdr_available_models()
  results <- lapply(m$POS$language, FUN=function(language){
    m <- rdr_model(language = language, annotation = "POS")
    rdr_pos(m, "Just some jibberish to get going")
  })
  expect_true(all(sapply(results, FUN=function(x) inherits(x, "data.frame"))))
})

test_that("UniversalPOS", {
  m <- rdr_available_models()
  results <- lapply(m$UniversalPOS$language, FUN=function(language){
    m <- rdr_model(language = language, annotation = "UniversalPOS")
    rdr_pos(m, "Just some jibberish to get going")
  })
  expect_true(all(sapply(results, FUN=function(x) inherits(x, "data.frame"))))
})

test_that("MORPH", {
  m <- rdr_available_models()
  results <- lapply(m$MORPH$language, FUN=function(language){
    m <- rdr_model(language = language, annotation = "MORPH")
    rdr_pos(m, "Just some jibberish to get going")
  })
  expect_true(all(sapply(results, FUN=function(x) inherits(x, "data.frame"))))
})
