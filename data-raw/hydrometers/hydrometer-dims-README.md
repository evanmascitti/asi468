The dimensions are abbreviated using the symbols in ASTM D7928-17.

Each entry in the spreadsheet corresponds to a measurment made on the hydrometer.

Measurements abbreviations are followed by an underscore and then the unit in which
they were recorded. It is more convenient to record the length units in mm as this 
is what a digital caliper usually reports.

The R script that builds the data object converts all the mm measurements to cm. 

For the bulb volume, the entered value represents the average of 3 or more measurements. 

The column `pure_water_offset` represents the hydrometer reading when placed in pure water at 20 deg C. 
If the value is positive, it should later be subtracted from the actual reading and also from 
 the blank correction, because the reading _should_ be zero in this pure-water condition.

**EDIT**: after trying this out, it made almost zero difference. I worked through the math by hand and I guess it basically doesn't matter, because this is already accounted for in the blank correction measurement, which is also "equally wrong". It _very_ marginally affects the effective depth, but it's so little that it's not worth doing the extra correction. I am going to take the `pure_water_offset` column out of the csv file  the column there and also remove the code insid **soiltestr** that uses this adjustment. Should I ever need to see how this was done, see **soiltestr** commit dda1338, file R/compute_hydrometer_fines_pct_passing` lines 49 and 56-94; it is explained pretty well there. 
