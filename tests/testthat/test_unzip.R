context("Unzipping models")

test_that("Unzip POS", {
  m <- rdr_available_models()
  sapply(m$POS$language, FUN=function(language) rdr_model(language = language, annotation = "POS"))
  expect_true(all(file.exists(m$POS$dictionary)))
  expect_true(all(file.exists(m$POS$rules)))
})

test_that("Unzip UniversalPOS", {
  m <- rdr_available_models()
  sapply(m$UniversalPOS$language, FUN=function(language) rdr_model(language = language, annotation = "UniversalPOS"))
  expect_true(all(file.exists(m$UniversalPOS$dictionary)))
  expect_true(all(file.exists(m$UniversalPOS$rules)))
})

test_that("Unzip MORPH", {
  m <- rdr_available_models()
  sapply(m$MORPH$language, FUN=function(language) rdr_model(language = language, annotation = "MORPH"))
  expect_true(all(file.exists(m$MORPH$dictionary)))
  expect_true(all(file.exists(m$MORPH$rules)))
})