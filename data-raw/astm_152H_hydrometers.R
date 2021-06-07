## code to prepare `astm_152H_hydrometers` dataset goes here
library(magrittr)

astm_152H_hydrometers <- readr::read_csv(file = './data-raw/hydrometers/asi468-ASTM-152H-hydrometers.csv',
                col_types = 'iDddddddddd',
                skip_empty_rows = TRUE,
                trim_ws = TRUE) %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::ends_with("mm"),
      .fns =~.*0.1)) %>%
  dplyr::rename_with(
    .cols = dplyr::ends_with("mm"),
    .fn = stringr::str_replace, pattern = "mm$", replacement = "cm"
  )

head(astm_152H_hydrometers)

usethis::use_data(astm_152H_hydrometers, overwrite = TRUE)
