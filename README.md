
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/vadimus202/quakeR.svg?branch=master)](https://travis-ci.org/vadimus202/quakeR)

[![Coverage status](https://codecov.io/gh/vadimus202/quakeR/branch/master/graph/badge.svg)](https://codecov.io/github/vadimus202/quakeR?branch=master)

Intro
-----

The package `quakeR` is designed for working with the NOAA Significant Earthquakes dataset. The dataset has a substantial amount of information that is not immediately accessible to people without knowledge of the intimate details of the dataset or of R. This package provides the tools for processing and visualizing the data so that others may extract some use out of the information embedded within.

For more info, please read the **"Introduction to the quakeR package"** vignette.

The Data
--------

This project is centered around a dataset obtained from the U.S. National Oceanographic and Atmospheric Administration (NOAA) on significant earthquakes around the world. This dataset contains information about 5,933 earthquakes over an approximately 4,000 year time span.

The dataset can be downloaded from this [link](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1). Alternatively, a copy of the dataset is included with this package, and can be loaded in R with the following code:

``` r
filename <- system.file("extdata/earthquakes.tsv.gz", package = "quakeR")
raw_data <- readr::read_delim(filename, delim = "\t")
```
