context("Test data prep")

filename <- system.file("extdata/earthquakes.tsv.gz", package = "quakeR")
raw_data <- readr::read_delim(filename, delim = "\t")

test_that("The package can access raw data",{
  expect_is(raw_data, "data.frame")
  expect_true("LOCATION_NAME" %in% names(raw_data))

})

test_that("eq_clean_data function returns correct data", {

  expect_is(eq_clean_data(raw_data), "data.frame")

  expect_is(eq_clean_data(raw_data)$DATE, "Date")

  expect_is(eq_clean_data(raw_data)$LATITUDE, "numeric")
  expect_is(eq_clean_data(raw_data)$LONGITUDE, "numeric")

})

test_that("eq_location_clean returns a clean location", {
  expect_is(eq_location_clean(raw_data$LOCATION_NAME), "character")
  expect_identical(eq_location_clean("AZERBAIJAN:  SHEMAKHA (SAMAXI)"),
                   "Shemakha (Samaxi)")
})


context("Test ggplot2 geoms")

test_that("ggplot geoms work",{
  library(dplyr)
  library(ggplot2)
  library(stringr)

  g <-
    raw_data %>%
    eq_clean_data() %>%
    mutate_at(vars(DEATHS, EQ_PRIMARY), as.numeric) %>%
    filter(str_detect(str_to_lower(COUNTRY), "china|usa$|pakistan")) %>%
    filter(DATE >= "2000-01-01") %>%
    ggplot(aes(x = DATE,
               y = COUNTRY,
               size = EQ_PRIMARY,
               fill = DEATHS))

  expect_is(g + geom_timeline(), "ggplot")
  expect_is(g + geom_timeline() + geom_timeline_label(), "ggplot")
  expect_is(g + geom_timeline() + theme_timeline(), "ggplot")
})



context("Test leaflet maps")

test_that("ggplot leaflet maps work",{
  library(dplyr)

  leaf_data <-
    raw_data %>%
    eq_clean_data() %>%
    dplyr::filter(COUNTRY == "MEXICO",
                  lubridate::year(DATE) >= 2000)

  leaf <-
    leaf_data %>%
    eq_map()


  expect_is(eq_map(leaf_data), "leaflet")
  expect_is(eq_map(leaf_data, annot_col = "EQ_PRIMARY"), "leaflet")
  expect_error(eq_map(leaf_data, annot_col = "JUNK"),
               "Annotation column 'JUNK' not in the data.")

  expect_is(eq_map(eq_map_add_popup(leaf_data), annot_col = "popup_text"),
            "leaflet")

})
