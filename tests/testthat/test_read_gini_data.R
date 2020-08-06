data <- readr::read_csv("../../data/raw/tabla2_3_basicos_inegi.csv", col_types = "fif")

test_that("Data has the expected shape", {
  expect_true("tbl" %in% class(data))
  expect_equal(nrow(data), 330)
  expect_equal(ncol(data), 3)
})



test_that("resumen_by_decil has the expected shape", {
  resumen_by_decil <- coneval::summarize_income_by_decil(data)
  expect_true("tbl" %in% class(resumen_by_decil))
  expect_equal(nrow(resumen_by_decil), 10)
  expect_equal(ncol(resumen_by_decil), 2)
})


test_that("resumen_by_entidad has the expected shape", {
  resumen_by_entidad <- coneval::summarize_income_by_state(data)
  expect_true("tbl" %in% class(resumen_by_entidad))
  expect_equal(nrow(resumen_by_entidad), 33)
  expect_equal(ncol(resumen_by_entidad), 2)
})


test_that("gini_sonora has the expected shape", {
  expected_gini <- 0.463
  obtained_gini <- coneval::gini_by_state(data, "SONORA")
  expect_equal(obtained_gini, expected_gini, tolerance=1e-3)
})