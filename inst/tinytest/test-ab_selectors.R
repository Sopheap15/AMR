# ==================================================================== #
# TITLE                                                                #
# Antimicrobial Resistance (AMR) Data Analysis for R                   #
#                                                                      #
# SOURCE                                                               #
# https://github.com/msberends/AMR                                     #
#                                                                      #
# LICENCE                                                              #
# (c) 2018-2022 Berends MS, Luz CF et al.                              #
# Developed at the University of Groningen, the Netherlands, in        #
# collaboration with non-profit organisations Certe Medical            #
# Diagnostics & Advice, and University Medical Center Groningen.       # 
#                                                                      #
# This R package is free software; you can freely use and distribute   #
# it for both personal and commercial purposes under the terms of the  #
# GNU General Public License version 2.0 (GNU GPL-2), as published by  #
# the Free Software Foundation.                                        #
# We created this package for both routine data analysis and academic  #
# research and it was publicly released in the hope that it will be    #
# useful, but it comes WITHOUT ANY WARRANTY OR LIABILITY.              #
#                                                                      #
# Visit our website for the full manual and a complete tutorial about  #
# how to conduct AMR data analysis: https://msberends.github.io/AMR/   #
# ==================================================================== #

# antibiotic class selectors
expect_equal(ncol(example_isolates[, ab_class("antimyco"), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, aminoglycosides(), drop = FALSE]), 4, tolerance = 0.5)
expect_equal(ncol(example_isolates[, aminopenicillins(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, betalactams(), drop = FALSE]), 16, tolerance = 0.5)
expect_equal(ncol(example_isolates[, carbapenems(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins(), drop = FALSE]), 7, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins_1st(), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins_2nd(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins_3rd(), drop = FALSE]), 3, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins_4th(), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, cephalosporins_5th(), drop = FALSE]), 0, tolerance = 0.5)
expect_equal(ncol(example_isolates[, fluoroquinolones(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, glycopeptides(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, lincosamides(), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, lipoglycopeptides(), drop = FALSE]), 0, tolerance = 0.5)
expect_equal(ncol(example_isolates[, macrolides(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, oxazolidinones(), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, penicillins(), drop = FALSE]), 7, tolerance = 0.5)
expect_equal(ncol(example_isolates[, polymyxins(), drop = FALSE]), 1, tolerance = 0.5)
expect_equal(ncol(example_isolates[, streptogramins(), drop = FALSE]), 0, tolerance = 0.5)
expect_equal(ncol(example_isolates[, quinolones(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, tetracyclines(), drop = FALSE]), 3, tolerance = 0.5)
expect_equal(ncol(example_isolates[, trimethoprims(), drop = FALSE]), 2, tolerance = 0.5)
expect_equal(ncol(example_isolates[, ureidopenicillins(), drop = FALSE]), 1, tolerance = 0.5)

# Examples:

# select columns 'mo', 'AMK', 'GEN', 'KAN' and 'TOB'
expect_equal(ncol(example_isolates[, c("mo", aminoglycosides())]), 5, tolerance = 0.5)

expect_equal(ncol(example_isolates[, c(administrable_per_os() & penicillins())]), 5, tolerance = 0.5)
expect_equal(ncol(example_isolates[, c(administrable_iv() & penicillins())]), 7, tolerance = 0.5)
expect_equal(ncol(example_isolates[, c(administrable_iv() | penicillins())]), 37, tolerance = 0.5)

# filter using any() or all()
expect_equal(nrow(example_isolates[any(carbapenems() == "R"), ]), 55, tolerance = 0.5)
expect_equal(nrow(subset(example_isolates, any(carbapenems() == "R"))), 55, tolerance = 0.5)

# filter on any or all results in the carbapenem columns (i.e., IPM, MEM):
expect_equal(nrow(example_isolates[any(carbapenems()), ]), 962, tolerance = 0.5)
expect_equal(nrow(example_isolates[all(carbapenems()), ]), 756, tolerance = 0.5)
expect_equal(nrow(example_isolates[any(carbapenems() == "R"), ]), 55, tolerance = 0.5)
expect_equal(nrow(example_isolates[any(carbapenems() != "R"), ]), 910, tolerance = 0.5)
expect_equal(nrow(example_isolates[carbapenems() != "R", ]), 704, tolerance = 0.5)

# filter with multiple antibiotic selectors using c()
expect_equal(nrow(example_isolates[all(c(carbapenems(), aminoglycosides()) == "R"), ]), 26, tolerance = 0.5)

# filter + select in one go: get penicillins in carbapenems-resistant strains
expect_equal(nrow(example_isolates[any(carbapenems() == "R"), penicillins()]), 55, tolerance = 0.5)
expect_equal(ncol(example_isolates[any(carbapenems() == "R"), penicillins()]), 7, tolerance = 0.5)

x <- data.frame(x = 0,
                mo = 0,
                gen = "S",
                genta = "S",
                J01GB03 = "S",
                tobra = "S",
                Tobracin = "S")
# should have the first hits
expect_identical(colnames(x[, aminoglycosides()]),
                 c("gen", "tobra"))

if (AMR:::pkg_is_available("dplyr", min_version = "1.0.0")) {
  expect_equal(example_isolates %>% select(administrable_per_os() & penicillins()) %>% ncol(), 5, tolerance = 0.5)
  expect_equal(example_isolates %>% select(administrable_iv() & penicillins()) %>% ncol(), 7, tolerance = 0.5)
  expect_equal(example_isolates %>% select(administrable_iv() | penicillins()) %>% ncol(), 37, tolerance = 0.5)
  expect_warning(example_isolates %>% select(GEH = GEN) %>% select(aminoglycosides(only_treatable = TRUE)))
}
