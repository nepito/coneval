data <- readr::read_csv("../../data/raw/tabla2_3_basicos_inegi.csv", col_types = "fif")

test_that("Data has the expected shape", {
  expect_true("tbl" %in% class(data))
  expect_equal(nrow(data), 330)
  expect_equal(ncol(data), 3)
})

resumen_by_decil <- data %>% 
  dplyr::group_by(decil) %>%
  dplyr::summarize(promedio = mean(ingreso))

test_that("resumen_by_decil has the expected shape", {
  expect_true("tbl" %in% class(resumen_by_decil))
  expect_equal(nrow(resumen_by_decil), 10)
  expect_equal(ncol(resumen_by_decil), 2)
})

resumen_by_entidad <- data %>% 
  dplyr::group_by(entidad_federativa) %>%
  dplyr::summarize(promedio = mean(ingreso))

test_that("resumen_by_entidad has the expected shape", {
  expect_true("tbl" %in% class(resumen_by_entidad))
  expect_equal(nrow(resumen_by_entidad), 33)
  expect_equal(ncol(resumen_by_entidad), 2)
})

gini_sonora <-  data %>% 
  dplyr::filter(entidad_federativa == "SONORA") %>% 
  .$ingreso %>% 
  ineq::ineq(type="Gini")

test_that("gini_sonora has the expected shape", {
  expect_equal(gini_sonora, 0.463, tolerance=1e-3)
})