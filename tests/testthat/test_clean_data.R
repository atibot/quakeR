context("Test data prep")

filename <- system.file("extdata/earthquakes.tsv.gz", package = "quakeR")
df <- readr::read_delim(filename, delim = "\t")

test_that("The package can access raw data",{
  expect_is(df, "data.frame")
  expect_true("LOCATION_NAME" %in% names(df))

})

test_that("eq_clean_data function returns correct data", {

  expect_is(eq_clean_data(df), "data.frame")

  expect_is(eq_clean_data(df)$DATE, "Date")

  expect_is(eq_clean_data(df)$LATITUDE, "numeric")
  expect_is(eq_clean_data(df)$LONGITUDE, "numeric")

})

test_that("eq_location_clean returns a clean location", {
  expect_is(eq_location_clean(df$LOCATION_NAME), "character")
  expect_identical(eq_location_clean("AZERBAIJAN:  SHEMAKHA (SAMAXI)"),
                   "Shemakha (Samaxi)")
})
