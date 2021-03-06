## code to prepare `mini_sand_cone_vol` dataset goes here

# this object is the cubic centimeters of volume contained by the
# open-ended cone constructed 2021-03-06. I use it for bulk density
# measurements of small soil cores extracted from my cleat mark cylinders.
# This is analogous to the sand-cone displacement method of ASTM D1556M − 15e1
library(magrittr)

# a note: Previously when I had saved the water properties in the soiltestr package,
# apparently they were getting some weird rounding or something because when I tried
# to join the cone vols data with the water properties it would add all the columns present
# in the water properties table, but give me NA values for everything. I checked whether
# this was a floating point number issue by filtering the water props object using dplyr::near()
# and sure enough it worked to find water temps of 21.4, but when I tried to do a
# simple filter with == it returned no matches.

# I went back into the soiltestr package and rounded the values of the temperatures
# in deg. C to 1 digit, rebuild the package and it worked. Cool that I was able to fi
# it but pretty annoying. In the future try to build things that will be joined only on
# character vectors or factors and not on doubles.

mini_sand_cone_vol <- readr::read_csv("inst/ext-data/mini-sand-cone-method/cone-volumes_2021-03-06.csv") %>%
  dplyr::filter(dplyr::across(dplyr::everything(), .fns = ~!is.na(.))) %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c, by = "water_temp_c") %>%
  dplyr::select(replication, mass, water_density_Mg_m3) %>%
  dplyr::mutate(water_vol = mass / water_density_Mg_m3) %>%
  dplyr::summarize(water_vol = mean(water_vol)) %>%
  purrr::pluck("water_vol", 1) %>%
  signif(3)

usethis::use_data(mini_sand_cone_vol, overwrite = TRUE)

