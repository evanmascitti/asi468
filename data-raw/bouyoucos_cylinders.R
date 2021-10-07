## code to prepare `bouyoucos_cylinders` dataset goes here

library(magrittr)
library(dplyr)


cyls_raw <- readr::read_csv(
  './data-raw/bouyoucos-cylinders/bouyoucos-cylinder-dimensions_2019-05-19.csv',
  col_types = 'iDddddd',
  skip_empty_rows = TRUE,
  lazy = FALSE
  )

bouyoucos_cylinders <- cyls_raw %>%
  dplyr::select(bouyoucos_cylinder_number,
                calibration_date,
                volume_mL,
                area_cm2,
                diameter_cm)

usethis::use_data(bouyoucos_cylinders, overwrite = TRUE)
